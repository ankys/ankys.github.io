---
title: Home
---

## 中安淳 (Atsushi NAKAYASU, Ph.D.)

![Portrait](profile/img/portrait_20160627.jpg){ style="width:70%;border-radius:50%;" }  
<q>才能に機会を、努力に対価を
(Opportunities for Abilities, Value for Effort)</q>
{ .leftfloatbox style="width:30%;max-width:20em;text-align:center;" }

京都大学大学院理学研究科数学教室 [](https://www.math.kyoto-u.ac.jp/)
特定助教  
Program-Specific Assistant Professor,
Department of Mathematics, Faculty of Science, Kyoto University [](https://www.math.kyoto-u.ac.jp/en)

`ankys@@@math.kyoto-u.ac.jp`
[](https://orcid.org/0000-0002-2008-7321)
[](https://www.researchgate.net/profile/Atsushi_Nakayasu)
[](https://github.com/ankys)

[経歴](cv_ja.html)
[CV](cv.html)

[ポリシー (Policy)](policy.html)

<br clear="left" />

## 告知 (Announcement)

<ul id="announcement">
<li v-for="announcement in announcements" v-if="!announcement.archived"><span>[[ announcement.date ]]</span><span v-if="announcement.texttype">：[[ announcement.texttype ]]</span><span v-if="announcement.location">：[[ announcement.location ]]</span><span v-if="announcement.description">：[[ announcement.description ]]</span><span v-if="announcement.time"> ([[ announcement.time ]])</span></li>
</ul>

<script type="text/plain" id="tannouncement">{% file "announcement.csv" %}</script>

## 予定 (Schedule)

<ul id="schedule">
<li v-for="schedule in schedules" v-if="!schedule.cancelled && schedule.timespan.end > new Date()"><span>[[ schedule.time ]]</span><span v-if="schedule.texttype">：[[ schedule.texttype ]]</span><span v-if="schedule.location">：[[ schedule.location ]]</span><span v-if="schedule.description">：[[ schedule.description ]]<a v-if="schedule.url" v-bind:href="schedule.url"></a></li>
</ul>

<script type="text/plain" id="tschedule">{% file "schedule.csv" %}</script>

* 毎週月曜日13:15-14:45：授業 (Class)：[微分積分学（講義）Ｂ](edu/2310calc/)
* 隔週火曜日8:45-12:00：授業 (Class)：[微分積分学（演義）Ｂ](edu/2310calc/)
* 毎週火曜日15:00-17:00：研究 (Research)
* 毎週金曜日12:00-14:00：授業 (Class)：オフィスアワー (Office hour)
* 毎週金曜日16:00-17:00：勉強 (Study)：[京都大学NLPDEセミナー](https://www.kurims.kyoto-u.ac.jp/~nobu/nlpde/)

## 研究 (Research)

非線形偏微分方程式論、
フラクタル上の力学系、
粘性解、
力学系、
ハミルトン・ヤコビ方程式、
平均曲率流、
特異拡散方程式、
距離空間、
フラクタル、
複雑ネットワーク、
交通流

Nonlinear partial differential equations,
Dynamical systems on fractals,
Viscosity solution,
Dynamical system,
Hamilton-Jacobi equations,
Mean curvature flows,
Singular diffusion equations,
Metric spaces,
Fractals,
Complex network,
Traffic flow

[研究業績 (Research work)](work.html)

[ORCID](https://orcid.org/0000-0002-2008-7321)
[Google Scholar‬](https://scholar.google.com/citations?user=6TrBAN4AAAAJ)
[ResearchGate](https://www.researchgate.net/profile/Atsushi_Nakayasu)
[Researchmap](https://researchmap.jp/ankys/)

プロジェクト (Projects)

* 一般化された空間上の非線形偏微分方程式
* [距離空間上の粘性解の基礎と応用](https://kaken.nii.ac.jp/grant/KAKENHI-PROJECT-19K14566/)
  ([English](https://kaken.nii.ac.jp/en/grant/KAKENHI-PROJECT-19K14566/))
* 粘性解の安定性の応用と一般化 (Application and generalization of stability of viscosity solutions)
  [ポスター (Poster)](res/2308ginpu.pdf)

## 教育 (Education)

京都大学数学教室（特定助教） [](https://www.math.kyoto-u.ac.jp/)

京都大学国際高等教育院（特定助教） [](https://www.z.k.kyoto-u.ac.jp/)

* [2023年度京都大学微分積分学（講義・演義）Ｂ](edu/2310calc/)

[全ての授業](edu/)

## 社会サービス (Social services)

日本数学会（正会員） [](https://www.mathsoc.jp/)

## ノート (Notes)

* [微分積分学１](notes/calc1t.pdf)：実一変数の微分積分学 [](https://www.overleaf.com/read/dnbxpxhmghdw)
* [微分積分学２](notes/calc2t.pdf)：実多変数の微分積分学 [](https://www.overleaf.com/read/mcpscxzskmvv)
* [線形代数学１](notes/lina1t.pdf)：四則演算のみの線形代数学 [](https://www.overleaf.com/read/kgnytcwwnbrp)
* [二スケール収束とその周辺](notes/tsconvn.pdf) [](https://www.overleaf.com/read/fspbgvfcqpcx)

## ソフトウェア (Software)

* [Makefile](serv/tex/Makefile) and [tex.pl](serv/tex/tex.pl) for TeX
* [Homura](https://github.com/ankys/homura_deno): A general-purpose static site generator [](https://github.com/ankys/homura_deno)
* [PosterDivider2](https://ankys.github.io/posterdivider2/posterdivider.html): 画像やPDFをいくつかのページに分割 [](https://github.com/ankys/posterdivider2)
* [科研費Markdown](https://ankys.github.io/kaken.md/): Markdownで科研費の書類を記述 [](https://github.com/ankys/kaken.md)

[GitHub](https://github.com/ankys)

## 連絡先 (Contact)

Email:
`ankys@@@math.kyoto-u.ac.jp`  
Website:
`https://ankys.github.io/`

Tel:
`075-753-3731`
Fax:
`075-753-3711`  
Tel:
`+81 75 753 3731`
Fax:
`+81 75 753 3711`

事務所：
理学部3号館153号室  
Office:
Room 153, Graduate School of Science Bldg No 3

住所：
〒606-8502　京都市左京区北白川追分町　京都大学理学部数学教室  
Address:
Department of Mathematics, Faculty of Science, Kyoto University, Kitashirakawa Oiwake-cho, Sakyo-ku, Kyoto, 606-8502 Japan

<script src="https://unpkg.com/papaparse@5.3.1/papaparse.min.js"></script>
<!-- <script src="https://cdn.jsdelivr.net/npm/vue@2/dist/vue.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/vue@2"></script>
<script>
function StringFormat(format) {
	var args = Array.from(arguments);
	var str = format.replace(/(\$(\$|[0-9]+))/g, function(match, s, a) {
		var s2;
		return (
			a == "\$" ? a :
			a == "0" ? s :
			(s2 = args[a]) !== undefined ? s2 :
			s
		);
	});
	return str;
}
var mapType = {
	"private" : "私用 (Private)",
	"duty" : "公用 (Duty)",
	"event" : "行事 (Event)",
	"presentation" : "講演 (Presentation)",
	"class" : "授業 (Class)",
	"study" : "勉強 (Study)",
	"research" : "研究 (Research)",
	"meeting" : "会議 (Meeting)",
	"trip" : "出張 (Trip)",
	"vacation" : "休暇 (Vacation)"
}
var tAnnouncement = document.getElementById("tannouncement");
var textAnnouncement = tAnnouncement.textContent;
var announcements = Papa.parse(textAnnouncement, { header: true, skipEmptyLines: true }).data;
announcements.forEach(function(announcement) {
  announcement.archived = announcement.status === "#";
  announcement.texttype = mapType[announcement.type] || "";
});
var vueAnnouncement = new Vue({ el: "#announcement", delimiters: ["[[", "]]"], data: { announcements: announcements } });
</script>
<script>
var tSchedule = document.getElementById("tschedule");
var textSchedule = tSchedule.textContent;
var schedules = Papa.parse(textSchedule, { header: true, skipEmptyLines: true }).data;
var dateNow = new Date();
schedules.forEach(function(schedule) {
  schedule.cancelled = schedule.status === "#";
	function parseTimespan(str) {
		var m;
		var r =
			(m = str.match(/^\s*(\d+)\/(\d+)\/(\d+)\s*$/)) ?
				[m[1], m[2], m[3], "", "", m[1], m[2], m[3], "", ""] :
			(m = str.match(/^\s*(\d+)\/(\d+)\/(\d+)\s*-\s*(\d+)\s*$/)) ?
				[m[1], m[2], m[3], "", "", m[1], m[2], m[4], "", ""] :
			(m = str.match(/^\s*(\d+)\/(\d+)\/(\d+)\s*-\s*(\d+)\s*$/)) ?
				[m[1], m[2], m[3], "", "", m[1], m[2], m[4], "", ""] :
			(m = str.match(/^\s*(\d+)\/(\d+)\/(\d+)\s*-\s*(\d+)\/(\d+)\s*$/)) ?
				[m[1], m[2], m[3], "", "", m[1], m[4], m[5], "", ""] :
			(m = str.match(/^\s*(\d+)\/(\d+)\/(\d+)\s*-\s*(\d+)\/(\d+)\/(\d+)\s*$/)) ?
				[m[1], m[2], m[3], "", "", m[4], m[5], m[6], "", ""] :
			(m = str.match(/^\s*(\d+)\/(\d+)\/(\d+)\s+(\d+):(\d+)\s*$/)) ?
				[m[1], m[2], m[3], m[4], m[5], m[1], m[2], m[3], m[4], m[5]] :
			(m = str.match(/^\s*(\d+)\/(\d+)\/(\d+)\s+(\d+):(\d+)\s*-(\d+):(\d+)\s*$/)) ?
				[m[1], m[2], m[3], m[4], m[5], m[1], m[2], m[3], m[6], m[7]] :
			["", "", "", "", "", "", "", "", "", ""];
		var startS = StringFormat("$1/$2/$3 $4:$5", r[0] || 0, r[1] || 0, r[2] || 0, r[3] || 0, r[4] || 0);
		var endS = StringFormat("$1/$2/$3 $4:$5", r[5] || 0, r[6] || 0, r[7] || 0, r[8] || 23, r[9] || 59);
		var start = new Date(startS);
		var end = new Date(endS);
		return { str: str, start: start, end: end };
	}
	var time = schedule.time || "";
	var timespan = parseTimespan(time);
	schedule.timespan = timespan;
  schedule.texttype = mapType[schedule.type] || "";
});
schedules.sort(function(a, b) {
	return a.timespan.start - b.timespan.start;
});
var vueSchedule = new Vue({ el: "#schedule", delimiters: ["[[", "]]"], data: { schedules: schedules } });
</script>
