
#
# Makefile for ankys mathwork version 20180710
# Copyright 2018 Atsushi Nakayasu. MIT License.
#

TEX=tex.pl
BIBTEX=bibtex
INKSCAPE=inkscape
BB=extractbb
STARTPDF=startsumatrapdf

TEXM:=$(shell $(TEX) -F $(wildcard *.tex))
SRC:=$(TEXM)
TRG:=$(SRC:.tex=.pdf)
VERSION:=$(shell date +%Y%m%d)
EXF:=\
	\$$RECYCLE.BIN \
	Thumbs.db \
	.Trashes \
	.fseventsd \
	.TemporaryItems \
	.DS_Store \
	._* \
	*.settings \
	*.stackdump \
	*.bak \
	\\\#*\\\# \
	.\\\#* \
	*~ \
	.*~ \
	*.a \
	*.out \
	*.dll \
	*.exe \
	*.dvi \
	*.pdvi \
	*.aux \
	*.log \
	*.nav \
	*.idx \
	*.out \
	*.snm \
	*.toc \
	*.tdo \
	*.synctex.gz \
	*.bbl \
	*.blg \
	*.ps \
	*.pdf \
	*.eps \
	*.eps_tex \
	*.pdf_tex \
	*.md.tex \
	*.md.b.tex \
	*.bb \
	*.xbb \

README=Readme.txt
-include $(README)

.PHONY: all clean release
all:

RELEASE=Release~
DEPENDS=.depends~

ifneq ($(MAKECMDGOALS),clean)
-include $(DEPENDS)
endif

$(DEPENDS): $(wildcard * */* */*/* */*/*/*)
	$(TEX) -M $(TEXM) > $@

.SUFFIXES:
%.pdf: %.tex
	$(TEX) --synctex $<
# %.dvi: %.tex
# 	$(TEX) --synctex -c $<
# %.aux: %.tex
# 	$(TEX) -S $<
# %.bbl: %.aux
# 	$(BIBTEX) $<; ret=$$?; rm -f $*.blg; exit $$ret
%.eps_tex: %.svg
	$(INKSCAPE) -z $< --export-eps=$*.eps --export-latex
%.pdf_tex: %.svg
	$(INKSCAPE) -z $< --export-pdf=$*.pdf --export-latex
	$(BB) $*.pdf
%.md.tex: %.md
	pandoc -fmarkdown -tlatex $< -o$@
%.md.b.tex: %.md
	pandoc -fmarkdown -tbeamer $< -o$@
%-$(VERSION).tex: %.tex
	$(TEX) -E $< > $@

all: $(TRG)
clean:
	rm -rf $(EXF)
release: $(TRG:.pdf=-$(VERSION).tex) $(TRG:.pdf=-$(VERSION).pdf)
	rm -rf $(RELEASE)
	mkdir -p $(RELEASE)
	mv $(TRG:.pdf=-$(VERSION).pdf) $(RELEASE)
	mv $(TRG:.pdf=-$(VERSION).tex) $(RELEASE)
gettarget:
	echo "$(TRG)"
