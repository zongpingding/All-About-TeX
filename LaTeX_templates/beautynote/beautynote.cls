\NeedsTeXFormat{LaTeX2e}
\newcommand{\templateauthor}{Ethan Lu}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

\def\fileversion{1.1}
\def\filedate{7/09/2023}

\ProvidesClass{beautynote}[\filedate\space Version \fileversion\space by \templateauthor]
\RequirePackage{ifthen}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage[T1]{fontenc}
\RequirePackage[svgnames,dvipsnames,x11names,table]{xcolor}
\RequirePackage{ninecolors}
% \RequirePackage[fontsize=12pt]{fontsize}
% \linespread{1.05}
% \overfullrule=1pt
%%%%%%%%%%%%%%%%%%%%%%%%%%%  Chapetr Title Format %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[explicit]{titlesec}
\RequirePackage{graphicx} % Required for inserting images
% 关于图片 graphicx
% 如果图片没有指定后缀, 依次按下列顺序搜索
\DeclareGraphicsExtensions{.pdf,.eps,.jpg,.png}
% 设置图表搜索路径, 可以给图表文件夹取如下名字
\graphicspath{{figures/}{figure/}}
\RequirePackage{varwidth}
\RequirePackage{tikz}
\usetikzlibrary{calc,shadows,hobby,intersections, decorations.markings, decorations.pathreplacing,spy,arrows,shapes,fadings,trees,mindmap,patterns,shapes.arrows,shapes.symbols,tikzmark,shapes.geometric,graphs, quotes, angles,decorations.pathmorphing,through,shadings,backgrounds,positioning,fit,arrows.meta,shapes.misc,decorations.shapes}
\pgfdeclarelayer{background} %背景%底层
\pgfdeclarelayer{foreground} %上层
\pgfdeclarelayer{top} %顶部
\pgfdeclarelayer{bottom} %底部
\pgfsetlayers{bottom,background,main,foreground,top}
\tikzfading[name=fade right,
                    right color =transparent!100,
                    left color=transparent!50]
\tikzfading[name=fade left,
                    left color =transparent!100,
                    right color=transparent!50]
\tikzfading[name=fade up,
                    top color =transparent!30,
                    bottom color=transparent!0]
\tikzfading[name=fade down,
                    bottom color =transparent!100,
                    top color=transparent!50]
%% -------- 章节样式
\definecolor{gray1}{HTML}{9E9E9E}
\definecolor{gray2}{HTML}{d4d3d8}
\definecolor{black1}{HTML}{616065}

\newcommand{\chapternumbered}[1]{%
    \begin{tikzpicture}[remember picture,overlay]
    \def\xshiftofnode{2cm}
    \def\hlenofnode{2.8cm}
    \def\vlenofnode{4.76cm}
    \def\nodecorners{8pt}
    \def\chapnameyshift{0.7cm}
    \def\chapbackheightI{.1\paperheight}
    \def\chapbackheightII{.15\paperheight}
        \fill[gray2] % 浅色
        (current page.north west) coordinate (NW) --++(0,-\chapbackheightII) [bend left=-9] to ([shift={(\paperwidth,-.8*\chapbackheightI-2.96cm)}]NW) |- (NW)  --cycle; % bottom background
        \fill[gray1!80] % 深色
        (current page.north west) coordinate (NW) --++(0,-\chapbackheightI) [bend left=-10] to ([shift={(\paperwidth,-.8*\chapbackheightI-3.5cm)}]NW) |- (NW)  --cycle; % subbottom background
        %%%%%%%%%%%%%%%%%% Chapname Box %%%%%%%%%%%%%%%%%%%%
        \fill[black1,opacity=0.8]
            ([xshift=\xshiftofnode]NW) {[rounded corners=\nodecorners]--++(0,-\vlenofnode)} coordinate (chapnameleft) {[rounded corners=\nodecorners]--++(\hlenofnode,0)} coordinate (chapnameright) --++(0,\vlenofnode)--cycle;
        \pattern[pattern=sixpointed stars,pattern color=gray2!50,opacity=0.8]
            ([xshift=\xshiftofnode]NW)--++(0,-0.76*\vlenofnode) coordinate (bendl) [bend left=-2] to  ([shift={(\hlenofnode,-0.168*\vlenofnode)}]bendl) |- ([xshift=\xshiftofnode]NW) --cycle;
        \fill [black1,path fading=fade up]%
            ([xshift=\xshiftofnode]NW)--++(0,-0.76*\vlenofnode) coordinate (bendl) [bend left=-2] to  ([shift={(\hlenofnode,-0.168*\vlenofnode)}]bendl) |- ([xshift=\xshiftofnode]NW) --cycle;
        %%%%%%%%%%%%%%%%%% Chapname Box %%%%%%%%%%%%%%%%%%%%
        \node[font=\huge\bfseries,text=gray!20!white] (chapname) at ($([yshift=\chapnameyshift]chapnameleft)!0.5!([yshift=\chapnameyshift]chapnameright)$) {CH\ \thechapter}; %chapname
        \node[right,font=\huge\bfseries,text=black] (chaptitle) at ([shift={(1.5cm,-.08*\chapnameyshift)}]chapname) {\begin{varwidth}{.92\linewidth} \baselineskip=23pt #1\end{varwidth}}; % chaptitle
    \end{tikzpicture}
}
\newcommand{\chapternonum}[1]{%
    \begin{tikzpicture}[remember picture,overlay]
    \def\xshiftofnode{2cm}
    \def\hlenofnode{2.8cm}
    \def\vlenofnode{4.76cm}
    \def\nodecorners{8pt}
    \def\chapnameyshift{0.7cm}
    \def\chapbackheightI{.1\paperheight}
    \def\chapbackheightII{.15\paperheight}
        \fill[gray2]
        (current page.north west) coordinate (NW) --++(0,-\chapbackheightII) [bend left=-9] to ([shift={(\paperwidth,-.8*\chapbackheightI-2.96cm)}]NW) |- (NW)  --cycle; % bottom background
        \fill[gray1!80]
        (current page.north west) coordinate (NW) --++(0,-\chapbackheightI) [bend left=-10] to ([shift={(\paperwidth,-.8*\chapbackheightI-3.5cm)}]NW) |- (NW)  --cycle; % subbottom background
        %%%%%%%%%%%%%%%%%% Chapname Box %%%%%%%%%%%%%%%%%%%%
        \fill[black1,opacity=0.8]
            ([xshift=\xshiftofnode]NW) {[rounded corners=\nodecorners]--++(0,-\vlenofnode)} coordinate (chapnameleft) {[rounded corners=\nodecorners]--++(\hlenofnode,0)} coordinate (chapnameright) --++(0,\vlenofnode)--cycle;
        \pattern[pattern=sixpointed stars,pattern color=gray2!50,opacity=0.8]
            ([xshift=\xshiftofnode]NW)--++(0,-0.76*\vlenofnode) coordinate (bendl) [bend left=-2] to  ([shift={(\hlenofnode,-0.168*\vlenofnode)}]bendl) |- ([xshift=\xshiftofnode]NW) --cycle;
        \fill [black1,path fading=fade up]%
            ([xshift=\xshiftofnode]NW)--++(0,-0.76*\vlenofnode) coordinate (bendl) [bend left=-2] to  ([shift={(\hlenofnode,-0.168*\vlenofnode)}]bendl) |- ([xshift=\xshiftofnode]NW) --cycle;
        %%%%%%%%%%%%%%%%%% Chapname Box %%%%%%%%%%%%%%%%%%%%
        \node[font=\fontsize{30pt}{30pt}\selectfont\scshape,text=gray!20!white] (chapname) at ($([yshift=\chapnameyshift]chapnameleft)!0.5!([yshift=\chapnameyshift]chapnameright)$) {chap}; %chapname
        \node[right,font=\huge\bfseries,text=black] (chaptitle) at ([shift={(1.5cm,-.08*\chapnameyshift)}]chapname) {\begin{varwidth}{.92\linewidth} \baselineskip=23pt #1\end{varwidth}}; % chaptitle
    \end{tikzpicture}
}

\titleformat{\chapter}{\huge\bfseries}{}{1em}{\chapternumbered{#1}}
\titleformat{name=\chapter,numberless}{\bfseries\huge}{}{1em}{\chapternonum{#1}}
\titlespacing{\chapter}{0pt}{0pt}{65pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Using Packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{geometry}
\RequirePackage[leqno]{amsmath}
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{empheq}
\RequirePackage{mdframed}
\RequirePackage{booktabs}
\RequirePackage{lipsum}
\pagecolor{gray!15}
\RequirePackage{psfrag}
\RequirePackage{bbding}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{pgfplots}
\RequirePackage{bm,times}
\RequirePackage{bropd,physics}
\RequirePackage{indentfirst}
\RequirePackage{float}
\RequirePackage{pifont}
\RequirePackage{pgfornament-han}
\RequirePackage{shadowtext}
\shadowoffset{.65pt}
\RequirePackage{eso-pic,transparent}
\RequirePackage{extramarks}
\RequirePackage{etoolbox}
\RequirePackage[type={CC},modifier={by-nc-nd},hyperxmp={false},version={4.0}]{doclicense}
\RequirePackage{xpatch}
\RequirePackage{rotating}
\RequirePackage{fbox}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Other Settings

%%%%%%%%%%%%%%%%%%%%%%%%%% Page Setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\geometry{a4paper,margin=2.2cm}
\setcounter{secnumdepth}{4}
%%%%%%%%%%%%%%%%%%%%%%%%%% Define some useful colors %%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{ocre}{RGB}{243,102,25}
\definecolor{mygray}{RGB}{243,243,244}
\definecolor{deepGreen}{HTML}{a71930}
\definecolor{shallowGreen}{HTML}{D5CABD}
\definecolor{deepBlue}{HTML}{005670}
\definecolor{shallowBlue}{HTML}{ced7df}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Define an orangebox command %%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\orangebox[1]{\fcolorbox{ocre}{mygray}{\hspace{1em}#1\hspace{1em}}}
\newenvironment{note}[1][\bf Note:]{\Line\uuline{#1} }{\Line}
\newcommand{\Line}{\noindent\\\tikz\draw[line width=0.65pt,gray!80,dashed] (0,0)--++(.99\linewidth,0);\par}
\newcommand{\prob}[2][Problems]{\vspace{1em}\begin{center}
    \pgfornamenthan[color=#2,scale=0.25,symmetry=c]{68}\hspace{.3em}\begin{tabular}{c}  \pgfornamenthan[color=#2,scale=0.4]{60}\\[1.6em]
        \shadowtext{\textbf{\color{#2}\fontsize{25pt}{25pt}\selectfont \textsc{#1}}}  \end{tabular}\hspace{.5em}\pgfornamenthan[color=#2,scale=0.25,symmetry=h]{68}
\end{center}\vspace{1em}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% English Environments %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newtheoremstyle{mytheoremstyle}{3pt}{3pt}{\itshape}{0cm}{\rmfamily\bfseries}{}{.5em}{{\color{black}\thmname{#1}~\thmnumber{#2}}\thmnote{\,--\,#3}}
\newtheoremstyle{myproblemstyle}{3pt}{3pt}{\normalfont}{0cm}{\rmfamily\bfseries}{}{.5em}{{\color{black}\thmname{#1}~\thmnumber{#2}}\thmnote{\,--\,#3}}
\theoremstyle{mytheoremstyle}
\newmdtheoremenv[linewidth=3pt,backgroundcolor=shallowGreen!50,linecolor=deepGreen,leftline = true,rightline=false,topline=false,bottomline=false,leftmargin=0pt,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=3pt]{theorem}{Theorem}[section]
\newmdtheoremenv[linewidth=3pt,backgroundcolor=shallowGreen!50,linecolor=deepGreen,leftline = true,rightline=false,topline=false,bottomline=false,leftmargin=0pt,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=3pt]{lemma}{Lemma}[section]
\newmdtheoremenv[linewidth=3pt,backgroundcolor=shallowGreen!50,linecolor=deepGreen,leftline = true,rightline=false,topline=false,bottomline=false,leftmargin=0pt,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=3pt]{proposition}{Proposition}[section]
\theoremstyle{mytheoremstyle}
\newmdtheoremenv[linewidth=3pt,backgroundcolor=shallowBlue!70,linecolor=deepBlue,leftline = true,rightline=false,topline=false,bottomline=false,leftmargin=0pt,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=3pt]{definition}{Definition}[section]
\theoremstyle{myproblemstyle}
\newmdtheoremenv[linecolor=black!60,backgroundcolor=gray!20,linewidth=3pt,leftline = true,rightline=false,topline=false,bottomline=false,leftmargin=0pt,innerleftmargin=5pt,innerrightmargin=5pt,innertopmargin=5pt,innerbottommargin=5pt]{problem}{Problem}[section]
\newtheorem*{remark}{Remark}
\newenvironment*{solution}{\begin{proof}[Solution]}{\end{proof}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plotting Settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepgfplotslibrary{colorbrewer}
\pgfplotsset{width=8cm,compat=1.9}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Some colors
\definecolor{airforceblue}{rgb}{0.36, 0.54, 0.66}
\definecolor{beaublue}{HTML}{7eabc0}
%%
% Some commands that will be useful for the title.
\makeatletter
\newcommand{\doctitle}[1]{\def\@doctitle{#1}}
\newcommand{\docsubtitle}[1]{\def\@docsubtitle{#1}}
\newcommand{\dockeywords}[1]{\def\@dockeywords{#1}}
\newcommand{\footext}[1]{\def\@footext{#1}}
\makeatother

% To make the lists more aesthetic, gray tones.
\setlist{label=\textcolor{gray}{\textbullet},topsep=2pt,noitemsep}
\setenumerate{label=\textcolor{gray}{\textit{\arabic*}.},topsep=2pt,noitemsep,font=\upshape}

% Keeping the gray tones along the document, on the header bar.
\renewcommand{\headrulewidth}{1pt}
\xpretocmd\headrule{\color{lightgray}}{}{\PatchFailed}
\renewcommand{\qedsymbol}{\textcolor{gray}{$\blacksquare$}}

% Important, header and footer spacing
\def\mylength{3pt}
\setlength{\headheight}{12pt+\mylength}
\addtolength{\headsep}{10pt}
\addtolength{\footskip}{10pt}
\addtolength{\textheight}{-20pt-1ex-\mylength}

% Par indent modifications
\setlength{\parindent}{2em}

% If you want to put a quote, it can appear in italic.
\AtBeginEnvironment{quote}{\itshape}

% A beautiful background for the titlepage.
\newcommand\BackgroundPic[1]{\put(0,0){\parbox[b][\paperheight]{\paperwidth}{\vfill\centering\includegraphics[width=\paperwidth,height=\paperheight,scale=1.05]{#1}\vfill}}} % 保持长宽比 keepaspectratio,
\AtBeginEnvironment{titlepage}{\AddToShipoutPictureBG*{\transparent{0.3}\BackgroundPic{fibonacci.jpg}}}
% Page numbering Box
\newcommand{\pagenumber}[1]{{\setlength{\fboxsep}{5pt}\fbox[#1,lcolor=beaublue,rcolor=beaublue,tcolor=beaublue,bcolor=beaublue]{\fontsize{10pt}{10pt}\selectfont{\textcolor{gray!50!black}{\textsc{\thepage}}}}}}

% Header configuration
\makeatletter

\fancypagestyle{singleside}{%
\fancyhf{}%
\lhead{\color{gray}\nouppercase{\textit{\lastleftxmark}}}%
\rhead{\color{black}\nouppercase{\textsc{\lastrightxmark}}}%
\rfoot{\pagenumber{lt}}%
\lfoot{\fontsize{10pt}{10pt}\selectfont{\textsc{\textcolor{airforceblue}{\@doctitle}\;\textcolor{lightgray}{|}\;\textcolor{gray!70!black}{\@docsubtitle}}}}%
\cfoot{\color{gray!70!black}\fontsize{10pt}{10pt}{\@footext}}
\renewcommand{\headrulewidth}{1pt}}%

\fancypagestyle{twoside}{%
\fancyhf{}%
\fancyhead[RE]{\textcolor{black}{\nouppercase{\leftmark}}}%
\fancyhead[LO]{\textcolor{black}{\nouppercase{\lastrightxmark}}}%
\fancyhead[RO]{\textcolor{gray}{\textit{\lastleftxmark}}}%
\fancyhead[LE]{\textcolor{gray}{\color{gray}{\textbf{\textsc{\romannumeral\thechapter\relax}}}}}%
\fancyfoot[LE]{\pagenumber{lt}}%
\fancyfoot[RO]{\pagenumber{rt}}%
\fancyfoot[RE]{\fontsize{10pt}{10pt}\selectfont{\textcolor{airforceblue}{\textsc{\@doctitle}}}}%
\fancyfoot[LO]{\fontsize{10pt}{10pt}\selectfont{\textcolor{gray!70!black}{\textsc{\@docsubtitle}}}}%
\fancyfoot[CO,CE]{\color{gray!70!black}\fontsize{10pt}{10pt}{\@footext}}%
\fancyheadoffset[leh,roh]{1em}%
\renewcommand{\headrulewidth}{1pt}}%

\fancypagestyle{auxsingle}{%
\fancyhf{}%
\chead{\nouppercase{\textsc{\leftmark}}}%
% \lfoot{\fontsize{10pt}{10pt}\selectfont{\textsc{\textcolor{airforceblue}{\@doctitle}\;\textcolor{lightgray}{|}\;\textcolor{gray!70!black}{\@docsubtitle}}}}%
\rfoot{\pagenumber{lt}}%
\renewcommand{\headrulewidth}{1pt}}%

\fancypagestyle{auxtwoside}{%
\fancyhf{}%
\fancyhead[CE,CO]{\nouppercase{\textsc{\leftmark}}}%
\fancyfoot[RE]{\fontsize{10pt}{10pt}\selectfont{\textcolor{airforceblue}{\textsc{\@doctitle}}}}%
\fancyfoot[LO]{\fontsize{10pt}{10pt}\selectfont{\textcolor{gray!70!black}{\textsc{\@docsubtitle}}}}%
\fancyfoot[LE]{\pagenumber{lt}}%
\fancyfoot[RO]{\pagenumber{rt}}%
\fancyheadoffset{0em}%
\renewcommand{\headrulewidth}{1pt}}%

\makeatother

% Now, if we load all-in-one with two side option, we will adjust the headers accordingly
\makeatletter
\if@twoside
    \fancypagestyle{copyright}{
    \fancyhf{}%
    \fancyfoot[LE]{\pagenumber{lt}}%
    \fancyfoot[RO]{\pagenumber{rt}}%
    \fancyheadoffset{0em}%
    \renewcommand{\headrulewidth}{0pt}}%
    \fancypagestyle{plain}{%
    \fancyhf{}%
    \fancyfoot[RE]{\fontsize{10pt}{10pt}\selectfont{\textcolor{airforceblue}{\textsc{\@doctitle}}}}%
    \fancyfoot[LO]{\fontsize{10pt}{10pt}\selectfont{\textcolor{gray!70!black}{\textsc{\@docsubtitle}}}}%
    \fancyfoot[RO,LE]{\pagenumber{lt}}%
    \renewcommand{\headrulewidth}{0pt}}%
\else
    \fancypagestyle{copyright}{
    \fancyhf{}%
    \rfoot{\pagenumber{rt}}%
    \fancyheadoffset{0em}%
    \renewcommand{\headrulewidth}{0pt}}%
    \fancypagestyle{plain}{%
    \fancyhf{}%
    \lfoot{\fontsize{10pt}{10pt}\selectfont{\textsc{\textcolor{airforceblue}{\@doctitle}\;\textcolor{lightgray}{|}\;\textcolor{gray!70!black}{\@docsubtitle}}}}%
    \rfoot{\pagenumber{rt}}%
    \renewcommand{\headrulewidth}{0pt}}%
\fi
\makeatother

\makeatletter
\if@twoside
  \newcommand{\defaultsettings}{twoside}
  \newcommand{\auxsettings}{auxtwoside}
\else
  \newcommand{\defaultsettings}{singleside}
  \newcommand{\auxsettings}{auxsingle}
\fi
\pagestyle{\defaultsettings}
\makeatother

% Section and subsection marks.
\makeatletter
\renewcommand{\chaptermark}[1]{\markboth{#1}{}\extramarks{}{}}
\renewcommand{\sectionmark}[1]{\extramarks{\thesection}{#1}}
\renewcommand{\subsectionmark}[1]{\extramarks{\thesubsection}{#1}}
\makeatother

% Greetings for the template author command (modify the auxiliar pagestyles).
\newboolean{copyright}
\newcommand{\copyrights}{\setboolean{copyright}{true}}

% This is my favourite config for bibliography. Each one of the references can be briefly explained with the field "note".
\RequirePackage[style=english]{csquotes}
\RequirePackage[
backend=biber,
style=alphabetic,
sorting=ynt
]{biblatex}
\newcommand{\familynameformat}[1]{\MakeUppercase{#1}}
\AtBeginBibliography{%
  \renewcommand{\mkbibnamefamily}{\familynameformat}%
}
\renewbibmacro*{begentry}{%
  \iffieldundef{note}
    {\undef\bbxnote}
    {\savefield{note}{\bbxnote}%
     \clearfield{note}}}
\renewbibmacro*{finentry}{%
  \restorefield{note}{\bbxnote}%
  \iffieldundef{note}
    {\finentry}
    {\setunit{\finentrypunct\par\vspace{\bibitemsep}\nobreak}
     \textit{\printfield{note}}%
     \finentry}}
\let\familynameformat=\textsc
\nocite{*}

\addbibresource{ref.bib}

% Setting up the titlepage.
\makeatletter%
\title{{\large\color{airforceblue}{\textit{\@doctitle}}}\\[0.5cm]{\Huge\color{gray!70!black}\textsc{\@docsubtitle}}}%
\makeatother%
% Some commands that will be useful for the copyrightpage
\makeatletter
\newcommand{\copyrightpage}[5]{\def\@faculty{#1}\def\@university{#2}\def\@publisher{#3}\def\@ams{#4}\def\@city{#5}}
\makeatother
