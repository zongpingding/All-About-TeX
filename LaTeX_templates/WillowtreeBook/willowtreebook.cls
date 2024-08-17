\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{willowtreebook}[2021/09/22 Willow Tree Book LaTeX class v1.02]
\DeclareOption{ContainsChinese}{\def\ChineseTextInThisDocument{}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}
\ProcessOptions\relax
\LoadClass{memoir}
\RequirePackage{xparse}
\def\mckaybook@title{}
\def\mckaybook@subtitle{}
\def\mckaybook@author{}
\def\mckaybook@bibliography{}
\def\mckaybook@colophon{This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 Unported License.}
\NewDocumentCommand\Title{m}{\global\def\mckaybook@title{#1}}
\NewDocumentCommand\Subtitle{m}{\global\def\mckaybook@subtitle{#1}}
\NewDocumentCommand\Author{m}{\global\def\mckaybook@author{#1}}
\NewDocumentCommand\BibliographyFile{m}{\global\def\mckaybook@bibliography{#1}}
\NewDocumentCommand\Colophon{m}{\global\def\mckaybook@colophon{#1}}
% For handling names like Benjamin McKay, where the letter c should be raised up, type in as Benjamin \scotsMc{}Kay.
\DeclareRobustCommand{\scotsMc}{\scotsMcx{c}}
\DeclareRobustCommand{\scotsMC}{\scotsMcx{\textsc{c}}}
\DeclareRobustCommand{\scotsMcx}[1]{%
  M%
  \raisebox{\dimexpr\fontcharht\font`M-\height}{%
    \check@mathfonts\fontsize{\sf@size}{0}\selectfont
    \kern.3ex\underline{\kern-.3ex #1\kern-.3ex}\kern.3ex
  }%
}
\expandafter\def\expandafter\@uclclist\expandafter{%
  \@uclclist\scotsMc\scotsMC
}
\RequirePackage{etex}
\RequirePackage{newunicodechar}
\RequirePackage[utf8]{inputenc} % Default input file encoding
\ifdefined\ChineseTextInThisDocument
\RequirePackage{CJKutf8}
\let\I\relax
\NewDocumentCommand\Chinese{m}{\begin{CJK*}{UTF8}{gbsn}#1\end{CJK*}}
\else 
\fi
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}
\RequirePackage{isomath}
\RequirePackage[tt=lining]{cfr-lm}
\RequirePackage[mathscr]{eucal}
\RequirePackage[%
activate={true,nocompatibility},%
final,%
tracking=true,%
kerning=true,%
spacing=true,%
factor=1100,%
stretch=10,%
shrink=10]{microtype}
\microtypecontext{spacing=nonfrench}
\usepackage{embrac} % fixes parentheses and brackets in italic text.
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{braket}
\RequirePackage{mathtools}
\mathtoolsset{showonlyrefs,showmanualtags,centercolon,mathic}
% If we need more room between rows of matrices and arrays, we can write
% \begin{pmatrix}[1.5]
% instead of 
% \begin{pmatrix}
\RenewDocumentCommand\env@matrix{O{\arraystretch}}
{%
\edef\arraystretch{#1}%
  \hskip -\arraycolsep
  \let\@ifnextchar\new@ifnextchar
  \array{*\c@MaxMatrixCols c}
}%
\NewDocumentCommand\tallmatrix{}{1.5}
\RequirePackage{varioref}
\RequirePackage{longtable}
\RequirePackage{multicol}
\setmarginnotes{2em}{3cm}{.5cm}
%.......Indices
\newcommand{\NotationIndexName}{List of notation}
\makeindex
\makeglossary[not]
\changeglossnum[not]{\thepage}
\changeglossnumformat[not]{|hyperpage}
\renewcommand*{\glossaryname}{\NotationIndexName}
\renewcommand*{\glossarymark}{\markboth{\glossaryname}{}}
\renewcommand{\begintheglossaryhook}
{%
\begin{longtable}[c]{lp{9cm}}%
\endfirsthead%
\endhead%
\endfoot%
\endlastfoot%
}%
\renewcommand{\atendtheglossaryhook}
{%
\end{longtable}%
}%
\renewcommand{\glossitem}[4]{#1 & #2, #4 \\[4pt]}
\renewcommand{\glossaryspace}{}
\newcommand{\paddedpagenumber}%
% Returns the current page number, zero padded, 
% so page 3 is 003, page 12 is 012, page 101 is 101
{%%
\ifnum\value{page}<100 0\fi%
\ifnum\value{page}<10 0\fi%
\arabic{page}%
}%%
\newcounter{howmany@notation}
\setcounter{howmany@notation}{0}
\newcommand{\Notation}[3]%%
%%use: \Notation{Nonmathmode token for comparing}{math mode expression}{description}
{\glossary[not](\paddedpagenumber){\(#2\)}{#3}%
\stepcounter{howmany@notation}%
}
\newcounter{howmany@indexentries}
\setcounter{howmany@indexentries}{0}
\newcommand{\SubIndex}[1]%
{%
\stepcounter{howmany@indexentries}%
\index{#1}%
}%
% There is a serious problem with Notation. You can't
% use absolute value signs or floor or ceiling signs anywhere. Replace them
% with the following:
\newcommand{\leftAbs}{\left"|}
\newcommand{\rightAbs}{\right"|}
\newcommand{\leftDoubleAbs}{"| "| }
\newcommand{\rightDoubleAbs}{"| "| }
\newcommand{\normNotation}[1]{\leftDoubleAbs#1\rightDoubleAbs}
\newcommand{\orderForNotationIndex}[1]{\leftAbs{#1}\rightAbs}
\newcommand{\lengthForNotationIndex}[1]{\leftDoubleAbs{#1}\rightDoubleAbs}
\newcommand{\normForNotationIndex}[1]{\leftDoubleAbs{#1}\rightDoubleAbs}
\newcommand{\lcl}{
\rule[-2.5pt]{.4pt}{1em}
\rule[6.4pt]{2pt}{.4pt}
}
\newcommand{\rcl}{
\rule[6.4pt]{2pt}{.4pt}
\rule[-2.5pt]{.4pt}{1em}
}
\newcommand{\lflr}{
\rule[-2.5pt]{.4pt}{1em}
\rule[-2.5pt]{2pt}{.4pt}
}
\newcommand{\rflr}{
\rule[-2.5pt]{2pt}{.4pt}
\rule[-2.5pt]{.4pt}{1em}
}
\newcommand{\ceilForNotationIndex}[1]{\lcl{#1}\rcl}
\newcommand{\floorForNotationIndex}[1]{\lflr{#1}\rflr}
% For the subject index:
% Example:
%    \define{interest rate}
% puts into the Subject index a reference
% to the current page saying that this is
% where the term ``interest rate'' is defined.
\newcommand{\FancyIndexEntry}[1]{\emph{\textbf{\hyperpage{#1}}}}
\newcommand{\define}[1]
{%
\stepcounter{howmany@indexentries}%
\index{#1|FancyIndexEntry}%
}%
%% PDF Output
\ifpdf
  \pdfoutput=1
  \RequirePackage[plainpages=false,
    hyperfigures,
    pdftitle={\mckaybook@title},
    pdfauthor={\mckaybook@author},
    colorlinks=true,
    pdfpagelabels=true,
    bookmarksnumbered,
    hidelinks,
    pagebackref,
    pdftex]
    {hyperref}
  \RequirePackage{memhfixc}
% Hyperref uses very bright colours to highlight links. Change them:
  \RequirePackage[svgnames]{xcolor}
  \definecolor{dark-red}{rgb}{0.4,0.15,0.15}
  \definecolor{dark-blue}{rgb}{0.15,0.15,0.4}
  \definecolor{medium-blue}{rgb}{0,0,0.5}
  \hypersetup{
    colorlinks, linkcolor={dark-red},
    citecolor={dark-blue}, urlcolor={medium-blue}
  }
\fi
\newcommand{\idxmark}[1]{#1\markboth{#1}{#1}}
\newcommand{\doidxbookmark}[1]{{\def\@tempa{Symbols}\def\@tempb{#1}%
\ifx\@tempa\@tempb %
Analphabetics
\phantomsection%
\pdfbookmark[0]{Analphabetics}{Analphabetics-idx}%
\else
#1%
\phantomsection%
\pdfbookmark[0]{#1}{#1-idx}%
\fi%
\vskip\onelineskip\par}}
\newcommand\doglobookmark[1]{%
}%
%......Figures
\newcommand{\stdFigSize}{1in}
\newsubfloat{figure} % Memoir class, instead of subfigure class.
\let\subfigure\subbottom
\newcommand{\subfigcapskip}{3em}
\setfloatadjustment{figure}{\scriptsize\centering}
\setfloatadjustment{marginfigure}{\scriptsize\centering}
\setmpjustification{\scriptsize\RaggedLeft}{\scriptsize\RaggedRight}
\captionnamefont{\scriptsize}
\captiontitlefont{\scriptsize}
\newcommand{\heading}{\sffamily}
\newcommand{\chapterSummary}[1]{{\small{#1}}\vspace{0.5cm}\par\noindent}
\makechapterstyle{bobo}{%
\aliaspagestyle{part}{empty}
\renewcommand{\partnamefont}{\raggedleft\normalfont\huge\heading}
\renewcommand{\partnumfont}{\normalfont\huge\heading}
\renewcommand{\printpartnum}{}
\renewcommand{\partname}{}
\renewcommand*{\parttitlefont}{\huge\heading}
\setlength{\beforechapskip}{0pt}
\renewcommand*{\chapnamefont}{\large\centering}
\renewcommand*{\chapnumfont}{\large}
\renewcommand*{\printchapternonum}{%
\vphantom{\printchaptername}%
\vphantom{\chapnumfont 1}%
\afterchapternum}
\renewcommand*{\chaptitlefont}{\Large\heading}
\renewcommand*{\printchaptertitle}[1]{%
\centering\smallcolouredbox\chaptitlefont ##1}}
\chapterstyle{bobo}
\setsecheadstyle{\large\heading\raggedright}
\setsubsecheadstyle{\heading\raggedright}
\setsubsubsecheadstyle{\heading\raggedright}
\setheadfoot{2\onelineskip}{3\onelineskip}
\newcommand{\optionalSection}[1]%
{%%
\section{#1}
{\small{This section can be omitted without loss of continuity.}}%
\medskip\par\noindent%
}%%
%......Table of contents
% depth of numbering of sectioning commands:
\setsecnumdepth{chapter}
\maxsecnumdepth{chapter}
%% depth of table of contents:  
\setcounter{tocdepth}{0}
\RenewDocumentCommand\cftpartfont{}{\heading\small}
\RenewDocumentCommand\cftpartpagefont{}{\normalfont\small}
\RenewDocumentCommand\cftchapterfont{}{\heading\small}
\RenewDocumentCommand\cftchapterpagefont{}{\normalfont\small}
\setlength{\cftbeforechapterskip}{3pt}
\RenewDocumentCommand\cftchapterleader{}{\quad}
\setpnumwidth{1em}
\RenewDocumentCommand\cftchapterafterpnum{}{\cftparfillskip}
\setlength{\cftbeforepartskip}{10pt}
\RenewDocumentCommand\cftpartleader{}{\quad}
\setpnumwidth{1em}
\RenewDocumentCommand\cftpartafterpnum{}{\cftparfillskip}
%......Title page
\pretitle{\begin{center}\HUGE}
\posttitle{\end{center}}
\preauthor{\vspace{2cm}\begin{center}}
\postauthor{\end{center}}
\predate{\begin{center}}
\postdate{\end{center}}
\usepackage{tcolorbox}
\tcbuselibrary{breakable}
\tcbuselibrary{skins}
%......Theorem Styles
%\newtheoremstyle{RegularStyle}% name
%  {}%      Space above, empty = `usual value'
%  {}%      Space below
%  {\normalfont}% Body font
%  {}%         Indent amount (empty = no indent, \parindent = para indent)
%  {\normalfont\scshape}% Thm head font
%  {.}%        Punctuation after thm head
%  {.5em}%     Space after thm head: " " = normal interword space;
%        %       \newline = linebreak
%  {} % {\thmnote{#3}}% Thm head spec
%\theoremstyle{RegularStyle}
%{%
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{proposition}[theorem]{Proposition}
%.......Colours
\colorlet{exampleBackgroundColour}{gray!16}
\newtcolorbox{example}{%
enhanced,%
breakable,%
colback=gray!16,%
colframe=gray!22,%
leftrule=1.4pt,%
toprule=1.4pt,%
bottomrule=1.4pt,%
rightrule=1.4pt,%
arc=3mm,%
before upper={\parindent15pt\noindent}%
}
\newenvironment{exampleAndImage}[1]%
{%
\begin{tcolorbox}[enhanced,%
breakable,%
colback=gray!16,%
colframe=gray!22,%
leftrule=1.4pt,%
toprule=1.4pt,%
bottomrule=1.4pt,%
rightrule=1.4pt,%
arc=3mm,%
sidebyside,%
lower separated=false,%
righthand width=#1,%
before upper={\parindent15pt\noindent}%
]%
}%
{%
\end{tcolorbox}%
}%
\NewDocumentEnvironment{examples}{}{%
\begin{example}%
\begin{itemize}}%
{\end{itemize}%
\end{example}}
% In the middle of an example, the background color is not white. If you need a white background to put an image on it, it looks best to use an imageborderinexample.
\definecolor{image-border-color}{gray}{.975}
\NewDocumentCommand\imageborderinexample{m}{\begin{center}\tcbox[colframe=image-border-color, colback=white]
{#1}\end{center}}
\NewDocumentCommand\includegraphicsinexample{om}%
{\IfValueTF{#1}{\imageborderinexample{\includegraphics[#1]{#2}}}{\imageborderinexample{\includegraphics{#2}}}}
\NewDocumentCommand\inputinexample{m}{\imageborderinexample{\input{#1}}}
%......Problems
% To define a new problem, use: 
% \begin{problem}{<label>} <statement> \end{problem}
% To give a solution to that problem:
% \begin{answer{<label>} <statement> \end{answer}
% using the same <label>.
% The label is for use in \ref{problem:label}, to refer to the problem.
% To say that a problem is exceptionally important, write
% \begin{problem*}{<label>} <statement> \end{problem*}
\NewDocumentEnvironment{ReviewExercises}{}{\section{Review~problems}}{}
\NewDocumentEnvironment{subproblems}{}{\begin{enumerate}}{\end{enumerate}}
\swapnumbers
\newtheoremstyle{ProblemStyle}% name
  {}%             Space above, empty = `usual value'
  {}%             Space below
  {\normalfont}%  Body font
  {}%             Indent amount (empty = no indent, \parindent = para indent)
  {\bfseries}%    Theorem head font
  {}%             Punctuation after thm head
  {.5em}%         Space after thm head: " " = normal interword space; \newline = linebreak
  {}%             Theorem head specification
\newtheoremstyle{HardProblemStyle}% name
  {}%             Space above, empty = `usual value'
  {}%             Space below
  {\normalfont}%  Body font
  {}%             Indent amount (empty = no indent, \parindent = para indent)
  {\bfseries}%    Theorem head font
  {\({}^*\)}%     Punctuation after thm head
  {.5em}%         Space after thm head: " " = normal interword space; \newline = linebreak
  {}%             Theorem head spec

{%
    \theoremstyle{ProblemStyle}
    \newtheorem{problemTheorem}{}[chapter]
    \theoremstyle{HardProblemStyle}
    \newtheorem{HardProblemTheorem}[problemTheorem]{}
}%
\swapnumbers
\NewDocumentEnvironment{problem}{m}{\begin{problemTheorem}\label{problem:#1}}{\end{problemTheorem}}
\NewDocumentEnvironment{problem*}{m}{\begin{HardProblemTheorem}\label{problem:#1}}{\end{HardProblemTheorem}}
\newoutputstream{ansout}
\NewDocumentCommand\printanswers{}{\closeoutputstream{ansout}\input{\jobname.ans}}
% Unfortunately, some complications involving `at' signs 
% and protection make it apparently necessary to define a
% \newparagraph symbol, which will later expand to \par. 
% Otherwise, we get mysterious errors. We could probably
% just make use of \protect here.
\let\newparagraph=\par
\NewDocumentEnvironment{@nswer}{m}{\@bsphack\IfStreamOpen{ansout}{}{\openoutputfile{\jobname.ans}{ansout}}
\addtostream{ansout}{\smallskip\newparagraph\noindent\textbf{\protect\ref{problem:#1}.}}}{\@esphack}
\newcounter{howmany@answers}
\setcounter{howmany@answers}{0}
\NewDocumentEnvironment{answer}{m}%
{\stepcounter{howmany@answers}\@bsphack\@nswer{#1}\writeverbatim{ansout}}{\par\endwriteverbatim\end@nswer\@esphack}
% Colour for the rulings in tables:
\RequirePackage{colortbl}
\newcommand{\defaultArrayRuleColor}{gray!30}
\arrayrulecolor{\defaultArrayRuleColor}
    \def\rulecolor#1#{\CT@arc{#1}}
    \def\CT@arc#1#2{%
      \ifdim\baselineskip=\z@\noalign\fi
      {\gdef\CT@arc@{\color#1{#2}}}}
    \let\CT@arc@\relax
\rulecolor{gray!30}
\RequirePackage{enumitem}
\setlist[enumerate,1]{label=\emph{\alph*.}}
\setlist[enumerate,2]{label=\arabic*.,
ref=\theenumi.\emph{\alph*}}
\setlist[enumerate,3]{label=\roman*), ref=\theenumii.\roman*}
\NewDocumentCommand\writetitlepage{}
{%
    \ifx\mckaybook@title\@empty
    \else
    		\begingroup
    		\raggedleft
    		\vspace*{\baselineskip}
    		{\Large \mckaybook@author
    		}\\[0.167\textheight]
    		\ifx\mckaybook@subtitle\@empty%
			\Huge\heading\mckaybook@title\\[\baselineskip]%
		\else%
			\Huge\heading\mckaybook@title\\[\baselineskip]%
	    		\Large\heading\mckaybook@subtitle\\[\baselineskip]%
    		\fi
		\normalfont
    		\vfill
    		{\Large \today}\par
    		\vspace*{3\baselineskip}
    		\endgroup
    \fi
}%
%% \newclr generates a colour based on the current chapter number, so we execute it every time we create a new chapter. It saves that colour in a global color variable called chpclr. This colour is used to highlight the chapter name at the beginning of the chapter and in all of the headings at the top of each page.
\newcommand*{\newcolr}%%
{%%
\newcount\mycount
% First mod out by 15:
\mycount=\value{chapter}
\divide\mycount by 15
\multiply\mycount by 15
\multiply\mycount by -1
\advance\mycount by \value{chapter}
% Second, choose which color scheme to interpolate:
\ifnum\mycount>9 
	\advance\mycount -10 
	\multiply\mycount by 20
	\xglobal\colorlet{chpclr}{colorAAA!\the\mycount!colorCCC}
\else
	\ifnum\mycount>4 
		\advance\mycount -5 
		\multiply\mycount by 20
		\xglobal\colorlet{chpclr}{colorCCC!\the\mycount!colorBBB}
	\else
		\multiply\mycount by 20
		\xglobal\colorlet{chpclr}{colorBBB!\the\mycount!colorAAA}
	\fi
\fi
}%%
\newlength{\smallboxh}
\newlength{\smallboxd}
\newlength{\smallboxw}
\setlength{\smallboxw}{.1mm}
\settoheight{\smallboxh}{l}
\settodepth{\smallboxd}{l}
\newcommand*{\blanksp}{\phantom{\rule[\smallboxd]{\smallboxw}{\smallboxh}}}
\newif\ifchaptercolours
\chaptercoloursfalse
\NewDocumentCommand\smallcolouredbox{}%
{%%
\ifchaptercolours\,{\colorbox{chpclr}{\blanksp}}\,\else\fi
}%%
\RenewDocumentCommand\chapnamefont{m}{\newcolr\large\centering#1}
\definecolor{colorAAA}{rgb}{.75,1,1}
\definecolor{colorBBB}{rgb}{1,.75,1}
\definecolor{colorCCC}{rgb}{1,1,.75}
\AtBeginDocument%
{%%
\frontmatter
% Title page
\ifx\mckaybook@title\@empty
\else
    \ifx\mckaybook@subtitle\@empty%
        \title{\MakeUppercase{\mckaybook@title}}
	\else
        \title{\MakeUppercase{\mckaybook@title} \\ \MakeUppercase{\mckaybook@subtitle}}
    \fi
    \ifx\mckaybook@author\@empty%
    \else
		\author
		{%
			{%
				\LARGE{\mckaybook@author}
	        }%
			\\
	    }%
	\fi
\fi
\writetitlepage
\thispagestyle{empty}
\pagenumbering{roman}
\makeheadrule{companion}{\headwidth}{0pt}
\makeevenhead{companion}%
{\normalfont\thepage}{}{\small\heading\leftmark\smallcolouredbox\negphantom{\smallcolouredbox}}
\makeoddhead{companion}%
{\small\negphantom{\smallcolouredbox}\smallcolouredbox\heading\rightmark}{}{\normalfont\thepage}
\setlength{\cftchapterindent}{4cm}
\setlength{\cftpartindent}{4cm}
\pagestyle{empty}
\clearpage{\footnotesize\vspace*{18cm}\par\noindent{\mckaybook@colophon}}
\clearpage
\pagestyle{companion}
}%%
\NewDocumentCommand\negphantom{m}{\settowidth{\dimen0}{#1}\hspace*{-\dimen0}}
\NewDocumentCommand\afterpreface{}
{%
\clearpage
\tableofcontents*
\mainmatter
\chaptercolourstrue
\pagenumbering{arabic}
}%
\NewDocumentCommand\hintsPreamble{}{}
\NewDocumentCommand\bibliographyPreamble{}{}
\AtEndDocument%
{%%
\backmatter
\chaptercoloursfalse
\ifnum\value{howmany@answers}>0\relax%
% Hints for the problems
% Lets add a space in the table of contents.
\chapter{Hints}\label{chp:Hints}%
\hintsPreamble%
\printanswers%
\fi%
\ifx\mckaybook@bibliography\@empty
\else
% Bibliography
\bibliographystyle{amsplain}%
\renewcommand{\prebibhook}{\bibliographyPreamble{}}
\bibliography{\mckaybook@bibliography}
\flushbottom
\fi
% Notation Index
\ifnum\value{howmany@notation}>0
\indexintoc
{\RenewDocumentCommand{\indexspace}{}{}\small{\printglossary[not]}}
\cleardoublepage
\fi
% Index
\ifnum\value{howmany@indexentries}>0
\indexintoc
\RenewDocumentCommand\indexname{}{Index}
{\small{\printindex}}
\fi
}%% AtEndDocument
