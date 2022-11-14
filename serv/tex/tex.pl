#!/usr/bin/perl

#
# tex.pl version 20180710
# Copyright 2018 Atsushi Nakayasu. MIT License.
#

use v5.8;
use strict;
use warnings;
use utf8;

use File::Spec;
use File::Path;
use File::Temp;
use File::Copy;
use Getopt::Long;

sub file_readall {
	my $path = shift;
	unless (open(IN, $path)) {
		return;
	}
	binmode(IN);
	local $/;
	my $text = <IN>;
	close(IN);
	return $text;
}
sub path_parse_ext {
	my $name = shift;
	my $i = rindex($name, ".");
	return $i < 0 ? ($name, "") : (substr($name, 0, $i), substr($name, $i));
}

sub get_depends {
	my $path = shift;
	my $text = file_readall($path);
	return () unless defined($text);
	my @lines = $text =~ m/%(?:[^\x0D\x0A]*)|\\(?:include|input|bibliography|includegraphics)\{(?:[^\}]*)\}/osg;
	my @files = ();
	for my $line (@lines) {
		next if $line =~ m/^%/;
		my ($type, $file) = $line =~ m/^\\(include|input|bibliography|includegraphics)\{([^\}]*)\}$/ ? ($1, $2) : ();
		next unless defined($type);
		$file =~ s/^\s*|\s*$//osg;
		$file =
			($type eq "include" || $type eq "input") && !($file =~ m/\./os) ? "$file.tex" :
			$type eq "bibliography" ? "$file.bib" :
			$file;
		push(@files, $file);
	}
	return @files;
}
sub get_depends_tree {
	sub loop {
		my $path = shift;
		my $map_depends = shift;
		my $depends = shift;
		return if $depends->{$path};
		$depends->{$path} = 1;
		my $r_depends = $map_depends->{$path};
		unless (defined($r_depends)) {
			$r_depends = [get_depends($path)];
			$map_depends->{$path} = $r_depends;
		}
		for my $depend (@$r_depends) {
			loop($depend, $map_depends, $depends);
		}
	}
	my $path = shift;
	my $map_depends = shift || {};
	my $depends = {};
	loop($path, $map_depends, $depends);
	return sort(keys(%$depends));
}
sub expand_tree {
	my $path = shift;
	my $text = file_readall($path);
	$text =~ s/%[^\x0D\x0A]*(?:\x0D\x0A|\x0D|\x0A|$)//osg;
	$text =~ s/\\(input)\{([^\}]*)\}/expand_tree($2)/oseg;
	return $text;
}
sub show_log {
	my $text = shift;
	my @lines = split(m/\x0D\x0A|\x0D|\x0A/os, $text);
	for my $line (@lines) {
		next if $line eq " file:line:error style messages enabled.";
		if ($line =~ m/^[^:]*:[0-9]*:.*$/os) {
			print STDERR "$line\n";
		}
	}
}

my %options = ();
Getopt::Long::GetOptions(
	"help|h" => \$options{help},
	"version|v" => \$options{version},
	"x=s" => \$options{x},
	"l=s" => \$options{l},
	"E" => \$options{E},
	"S" => \$options{S},
	"c" => \$options{c},
	"all|a" => \$options{all},
	"o=s" => \$options{o},
	"synctex" => \$options{synctex},
	"loop=n" => \$options{loop},
	"F" => \$options{F},
	"M" => \$options{M},
);
my @args = @ARGV;

if ($options{help}) {
	print "usage: tex.pl [options] <input>\n";
	exit 0;
}
if ($options{version}) {
	print "tex.pl version 0.1\n";
	exit 0;
}

if ($options{F}) {
	for my $path (@args) {
		my $text = file_readall($path);
		if ($text =~ m/^[^%]*\\begin\{document\}/om) {
			print "$path\n";
		}
	}
	exit 0;
}
if ($options{M}) {
	my $map_depends = {};
	for my $path (@args) {
		my ($base, $ext) = path_parse_ext($path);
		my @targets = ("$base.pdf", "$base.dvi", "$base.aux");
		my @depends = get_depends_tree($path, $map_depends);
		my $str_targets = join(" ", @targets);
		my $str_depends = join(" ", @depends);
		print "$str_targets : $str_depends\n";
	}
	exit 0;
}

my $path_input = $args[0];
unless (defined($path_input)) {
	print STDERR "no input file\n";
	exit 1;
}

if ($options{E}) {
	my $text = expand_tree($path_input);
	print $text;
	exit 0;
}

my ($path_input_base, $path_input_ext) = path_parse_ext($path_input);
my $text_input = file_readall($path_input);
my $ARGV2 = $text_input =~ m/%!texpl_options\s+([^\x0D\x0A]*)(\x0D\x0A|\x0D|\x0A|$)/os ? $1 : "";
Getopt::Long::GetOptionsFromString($ARGV2,
	"x=s" => \$options{x},
	"l=s" => \$options{l},
);
my $tex =
	defined($options{x}) ? $options{x} :
	"latex";
my $dvipdf =
	defined($options{l}) ? $options{l} :
	"dvipdfmx";

my ($path_output_base, $path_output_ext) =
	defined($options{o}) ? path_parse_ext($options{o}) :
	($path_input_base, "");
my $output_mode =
	$options{all} ? "all" :
	$options{S} ? "aux" :
	$options{c} ? "dvi" :
	$path_output_ext eq ".aux" ? "aux" :
	$path_output_ext eq ".dvi" ? "dvi" :
	"pdf";
my $path_output =
	defined($options{o}) ? $options{o} :
	$output_mode eq "all" ? $path_output_base :
	$output_mode eq "aux" ? "$path_output_base.aux" :
	$output_mode eq "dvi" ? "$path_output_base.dvi" :
	$output_mode eq "pdf" ? "$path_output_base.pdf" :
	$path_output_base;

# print STDERR "$path_input -> $path_output($output_mode) ($tex, $dvipdf)\n";

my $flag_cygwin = $^O eq "cygwin";

# my $path_tempdir = "__temp__";
my $path_tempdir = File::Temp::tempdir();
my $epath_tempdir = $flag_cygwin ? Cygwin::posix_to_win_path($path_tempdir) : $path_tempdir;
my $path_stdout = "$path_tempdir/stdout~";
my $path_stderr = "$path_tempdir/stderr~";
my $path_log = "$path_tempdir/$path_input_base.log";
mkdir $path_tempdir;
sub clear_temp_files {
	File::Path::rmtree($path_tempdir);
	# unlink($path_stdout);
	# unlink($path_stderr);
	# unlink($path_log);
}

# my $exec_count = 1;
my $exec_count =
	defined($options{loop}) ? $options{loop} :
	$output_mode eq "all" ? 2 :
	$output_mode eq "aux" ? 1 :
	$output_mode eq "dvi" ? 2 :
	$output_mode eq "pdf" ? 2 :
	1;
for my $i (1 .. $exec_count) {
	my $flag_synctex =
		$options{synctex} && $i == $exec_count ? "-synctex=1" :
		"";
	my $command_tex =
		$tex eq "latex" ? "latex" :
		$tex eq "platex" ? "platex -guess-input-enc" :
		"latex";
	my $command = "$command_tex $flag_synctex -output-directory='$epath_tempdir' -interaction=batchmode -file-line-error  '$path_input' 2> '$path_stderr' > '$path_stdout'";
	# print STDERR "$command\n";
	my $return_value = system($command);

	if ($return_value != 0) {
		my $text = file_readall($path_log);
		show_log($text);
		clear_temp_files();
		exit 1;
	}
}

my $text = file_readall($path_log);
show_log($text);

if ($output_mode eq "aux") {
	my $path_aux1 = "$path_tempdir/$path_input_base.aux";
	my $path_aux2 = "$path_input_base.aux";
	rename($path_aux1, $path_aux2);
	clear_temp_files();
	exit 0;
}
if ($output_mode eq "dvi") {
	my $path_dvi1 = "$path_tempdir/$path_input_base.dvi";
	my $path_dvi2 = "$path_input_base.dvi";
	rename($path_dvi1, $path_dvi2);
	clear_temp_files();
	exit 0;
}

my $path_dvi = "$path_tempdir/$path_input_base.dvi";
my $path_pdf = "$path_tempdir/$path_input_base.pdf";
my $epath_dvi = $flag_cygwin ? Cygwin::posix_to_win_path($path_dvi) : $path_dvi;
my $epath_pdf = $flag_cygwin ? Cygwin::posix_to_win_path($path_pdf) : $path_pdf;
if ($dvipdf eq "dvipdfmx") {
	my $command = "dvipdfmx -q -o '$epath_pdf' '$epath_dvi'";
	my $return_value = system($command);
} elsif ($dvipdf eq "dvips") {
	my $path_ps = "$path_tempdir/$path_input_base.ps";
	my $epath_ps = $flag_cygwin ? Cygwin::posix_to_win_path($path_ps) : $path_ps;
	my $command1 = "dvips -q '$epath_dvi' -o '$epath_ps'";
	my $return_value1 = system($command1);
	my $command2 = "ps2pdf '$epath_ps'";
	my $return_value2 = system($command2);
}
if (1) {
	if ($options{synctex}) {
		my $path_synctex1 = "$path_tempdir/$path_input_base.synctex.gz";
		my $path_synctex2 = "$path_input_base.synctex.gz";
		unless (File::Copy::move($path_synctex1, $path_synctex2)) {
		}
	}
	my $path_pdf1 = "$path_tempdir/$path_input_base.pdf";
	my $path_pdf2 = "$path_input_base.pdf";
	# print STDERR "$path_pdf1 $path_pdf2\n";
	unless (File::Copy::move($path_pdf1, $path_pdf2)) {
	}
	clear_temp_files();
	exit 0;
}
