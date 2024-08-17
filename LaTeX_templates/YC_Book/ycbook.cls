  %% yc-book.cls
  %% Copyright (c) Youssef Cherem <ycherem(at)gmail.com>, 2018
  %
  % This work may be distributed and/or modified under the
  % conditions of the LaTeX Project Public License, either version 1.3c
  % of this license or (at your option) any later version.
  % The latest version of this license is in
  %   http://www.latex-project.org/lppl.txt
  % and version 1.3 or later is part of all distributions of LaTeX
  % version 2005/12/01 or later.
  %
  % This work has the LPPL maintenance status `maintained'.
  % 
  % The Current Maintainer of this work is Youssef Cherem.
  %
  % This work consists of the files ycbook.cls, ycbook-doc.tex, and ycbook-doc.pdf



\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ycbook}[2018/01/03 ycbook class]
 
\LoadClassWithOptions{mwbk}	



%%%% OPTIONS %%%%%


\SetSectionFormatting[breakbefore,breakafter,wholewidth]{part}
{0pt plus1pt}
{\FormatChapterHeading{20pt}%
	{\centering\Large\partname\space}%
	{\centering\LARGE}}
{0pt plus1pt}


\DeclareOption{chapterrule}{\SetSectionFormatting[breakbefore,wholewidth]{chapter}
	{56pt plus8pt minus4pt}%espaço antes do capítulo
	{\Large\textbf{\ifHeadingNumbered
			\HeadingNumber.\enspace\fi % pode retirar o ponto daqui^: \HeadingNumber.\enspace\fi para não ficar com ponto depois do número da seção
			\HeadingText}\\\rule[12pt]{\hsize}{0.4pt}%\thispagestyle{plain}
		} %\hsize=horizontal size of the text...
	{24pt plus9pt}%espaço depois do capítulo
	}


\DeclareOption{sectionrule}{%
	\SetSectionFormatting{section}
	{24pt plus5pt minus2pt}
	{\large\textbf{\ifHeadingNumbered
			\HeadingNumber.\enspace\fi %deixei o ponto
			\HeadingText}\\\rule[10pt]{\hsize}{0.4pt}}
	{10pt plus3pt}
	}


  
\DeclareOption{chaptercentered}{%
\SetSectionFormatting[breakbefore,wholewidth]{chapter}
{12pt}
{\FormatChapterHeading{12pt}%additional space between label and chapter title
	{\centering\LARGE \@chapapp \space}{\Huge\centering}}
{24pt plus6pt}

\renewcommand*\chapter@toc{%
	\ifHeadingNumbered\typeout{\@chapapp~\thechapter}\fi
	\addcontentsline{toc}{chapter}{%
		\ifHeadingNumbered
		\mw@seccntformat{\@chapapp~\thechapter}%
		\fi
		\HeadingTOCText}}%

}

\DeclareOption{chapterleft}{%
	\SetSectionFormatting[breakbefore,wholewidth]{chapter}
	{12pt}
	{\FormatChapterHeading{12pt}%
		{\LARGE \@chapapp \space}{\Huge}}
	{24pt plus6pt}

\renewcommand*\chapter@toc{%
	\ifHeadingNumbered\typeout{\@chapapp~\thechapter}\fi
	\addcontentsline{toc}{chapter}{%
		\ifHeadingNumbered
		\mw@seccntformat{\@chapapp~\thechapter}%
		\fi
		\HeadingTOCText}}%

}

\DeclareOption{chapterright}{%
	\SetSectionFormatting[breakbefore,wholewidth]{chapter}
	{12pt}
	{\FormatChapterHeading{12pt}%
		{\flushright\LARGE \@chapapp \space}{\flushright\Huge}}
	{24pt plus6pt}
	
\renewcommand*\chapter@toc{%
	\ifHeadingNumbered\typeout{\@chapapp~\thechapter}\fi
	\addcontentsline{toc}{chapter}{%
		\ifHeadingNumbered
		\mw@seccntformat{\@chapapp~\thechapter}%
		\fi
		\HeadingTOCText}}%

}

%%%%%%%%nochapter name%%%%%%


\DeclareOption{nochaptercentered}{\SetSectionFormatting[breakbefore,wholewidth]{chapter}
	{12pt}
{\FormatBlockHeading{\centering\bfseries\LARGE}}
	{24pt plus9pt}

\renewcommand*\chapter@toc{%
	\ifHeadingNumbered\typeout{\thechapter}\fi
	\addcontentsline{toc}{chapter}{%
		\ifHeadingNumbered
		\mw@seccntformat{\thechapter}%
		\fi
		\HeadingTOCText}}%
}


\DeclareOption{nochapterleft}{\SetSectionFormatting[breakbefore,wholewidth]{chapter}
	{12pt}
{\FormatBlockHeading{\bfseries\LARGE}}
	{24pt plus9pt}

\renewcommand*\chapter@toc{%
	\ifHeadingNumbered\typeout{\thechapter}\fi
	\addcontentsline{toc}{chapter}{%
		\ifHeadingNumbered
		\mw@seccntformat{\thechapter}%
		\fi
		\HeadingTOCText}}%
}


\DeclareOption{nochapterright}{\SetSectionFormatting[breakbefore,wholewidth]{chapter}
		{12pt}
{\FormatBlockHeading{\flushright\bfseries\LARGE}}
	{24pt plus9pt}

\renewcommand*\chapter@toc{%
	\ifHeadingNumbered\typeout{\thechapter}\fi
	\addcontentsline{toc}{chapter}{%
		\ifHeadingNumbered
		\mw@seccntformat{\thechapter}%
		\fi
		\HeadingTOCText}}%%
}

%%%%%%%%%%


\def\ps@myheadings{%
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings
	\let\ps@blank\hf@empty
	\ps@normal
	\let\@mkboth\@gobbletwo
	\let\chaptermark\@gobble
	\let\sectionmark\@gobble
}



	\def\ps@myheadingsbeforeplain{%
		\let\ps@normal\hf@headings
		\let\ps@opening\hf@plain
		\let\ps@closing\hf@plain
		\let\ps@blank\hf@plain
		\ps@normal
		\let\@mkboth\@gobbletwo
		\let\chaptermark\@gobble
		\let\sectionmark\@gobble
	}


%%for headings:%%%%

\if@twoside
\def\ps@headings{%
		\let\@mkboth\@gobbletwo
		\let\ps@normal\hf@headings
		\let\ps@opening\hf@plain
		\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
		\let\ps@blank\hf@empty
		\ps@normal
	\def\chaptermark##1{%
		\markboth{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter.\enspace
			\fi
			\fi
			##1}{}}%
	\def\sectionmark##1{%
		\markright{%
			\ifHeadingNumbered \thesection.\enspace \fi
			##1}}}
\else
\def\ps@headings{%
	\let\@mkboth\@gobbletwo
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
	\let\ps@blank\hf@empty
	\ps@normal
	\def\chaptermark##1{%
		\markright{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter.\enspace
			\fi
			\fi
			##1}}}
\fi


\if@twoside
\def\ps@headingsnodot{%
	\let\@mkboth\@gobbletwo
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
	\let\ps@blank\hf@empty
	\ps@normal
	\def\chaptermark##1{%
		\markboth{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter\enspace
			\fi
			\fi
			##1}{}}%
	\def\sectionmark##1{%
		\markright{%
			\ifHeadingNumbered \thesection\enspace \fi
			##1}}}
\else
\def\ps@headingsnodot{%
	\let\@mkboth\@gobbletwo
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
	\let\ps@blank\hf@empty
	\ps@normal
	\def\chaptermark##1{%
		\markright{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter\enspace
			\fi
			\fi
			##1}}}
\fi


\if@twoside
\def\ps@headingsbeforeplain{%
	\let\@mkboth\@gobbletwo
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
	\let\ps@blank\hf@plain
	\ps@normal
	\def\chaptermark##1{%
		\markboth{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter.\enspace
			\fi
			\fi
			##1}{}}%
	\def\sectionmark##1{%
		\markright{%
			\ifHeadingNumbered \thesection.\enspace \fi
			##1}}}
\else
\def\ps@headingsbeforeplain{%
	\let\@mkboth\@gobbletwo
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
	\let\ps@blank\hf@plain
	\ps@normal
	\def\chaptermark##1{%
		\markright{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter.\enspace
			\fi
			\fi
			##1}}}
\fi

		
\if@twoside
\def\ps@headingsbeforeplainnodot{%
	\let\@mkboth\@gobbletwo
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
	\let\ps@blank\hf@plain
	\ps@normal
	\def\chaptermark##1{%
		\markboth{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter\enspace
			\fi
			\fi
			##1}{}}%
	\def\sectionmark##1{%
		\markright{%
			\ifHeadingNumbered \thesection\enspace \fi
			##1}}}
\else
\def\ps@headingsbeforeplainnodot{%
	\let\@mkboth\@gobbletwo
	\let\ps@normal\hf@headings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@headings %% <-- this was @empty, now @headings!!! use this for page numbers and headings to appear on even pages before new chapter
	\let\ps@blank\hf@plain
	\ps@normal
	\def\chaptermark##1{%
		\markright{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter\enspace
			\fi
			\fi
			##1}}}
\fi


\if@twoside
\def\ps@uheadings{%
	\let\@mkboth\markboth
	\let\ps@normal\hf@uheadings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@uheadings
	\let\ps@blank\hf@empty
	\ps@normal
	\def\chaptermark##1{%
		\markboth{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter.\enspace
			\fi
			\fi
			##1}{}}%
	\def\sectionmark##1{%
		\markright{%
			\ifHeadingNumbered \thesection.\enspace \fi
			##1}}}
\else
\def\ps@uheadings{%
	\let\@mkboth\markboth
	\let\ps@normal\hf@uheadings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@uheadings
	\let\ps@blank\hf@empty
	\ps@normal
	\def\chaptermark##1{%
		\markright{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter.\enspace
			\fi
			\fi
			##1}}}
\fi
\def\ps@myuheadings{%
	\let\ps@normal\hf@uheadings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@uheadings
	\let\ps@blank\hf@empty
	\ps@normal
	\let\@mkboth\@gobbletwo
	\let\chaptermark\@gobble
	\let\sectionmark\@gobble
}



\if@twoside
\def\ps@uheadingsnodot{%
	\let\@mkboth\markboth
	\let\ps@normal\hf@uheadings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@uheadings
	\let\ps@blank\hf@empty
	\ps@normal
	\def\chaptermark##1{%
		\markboth{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter\enspace
			\fi
			\fi
			##1}{}}%
	\def\sectionmark##1{%
		\markright{%
			\ifHeadingNumbered \thesection\enspace \fi
			##1}}}
\else
\def\ps@uheadingsnodot{%
	\let\@mkboth\markboth
	\let\ps@normal\hf@uheadings
	\let\ps@opening\hf@plain
	\let\ps@closing\hf@uheadings
	\let\ps@blank\hf@empty
	\ps@normal
	\def\chaptermark##1{%
		\markright{%
			\ifHeadingNumbered
			\if@mainmatter
			\@chapapp\
			\thechapter\enspace
			\fi
			\fi
			##1}}}
\fi



\DeclareOption*{\PassOptionsToClass{\CurrentOption}{mwbk}}


\DeclareOption{sansserifnotes}{%marginpar to sans serif
%	\let\oldmarginpar\marginpar
%	\renewcommand{\marginpar}[1]{\oldmarginpar{\footnotesize \raggedright \sffamily#1}}
	
	%footnote to sans serif
	\let\oldfootnote\footnote
	\renewcommand{\footnote}[1]{\oldfootnote{\sffamily#1}}
	
	%footnotemark to sans serif
	\long\def\@makefnmark{%
		\hbox {\@textsuperscript {\sffamily\@thefnmark}}
		}
		}


\DeclareOption{nodots}{
\renewcommand*\@seccntformat[1]{\csname the#1\endcsname\enspace}
\def\mw@seccntformat#1{#1\enspace}
}
%%%%%%%%%%%% end of nodots option %%%%%%%%%%%%%%%%



%%%%%%%%%%%%%% footnotes %%%%%%%%%%%%%%%%

\DeclareOption{nofootnoterule}{%
	\renewcommand\footnoterule{}%
}

\DeclareOption{traditionalfootnote}{%
	\renewcommand\@makefntext[1]{%
		\indent\@makefnmark#1}
}

%\renewcommand\@makefntext[1]{%
%	%\parindent\@parindent
%	\indent
%	\@makefnmark\enspace#1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%

\ExecuteOptions{headings,chapterleft}

\ProcessOptions\relax

\RequirePackage{titletoc}


%%%%% FANCY TOC %%%%%%%%%



\newcommand{\fancytoc}{%	

	\titlecontents{part}
	[0pt]
	{\addvspace{2pc}%
		\bfseries\centering}%
	{\contentsmargin{0pt}%
		 \Large Parte~\thecontentslabel
		 \\[10pt]%
		\normalfont\Large\itshape}
	{\contentsmargin{0pt}%
		\huge}
	{}%\quad\contentspage
	[\addvspace{.5pc}]
	
	\titlecontents{chapter}
	[0pt]
	{\addvspace{1pc}%
		\itshape}%
	{\contentsmargin{0pt}%
		%\bfseries
		\large\thecontentslabel\enspace%
	}
	{\contentsmargin{0pt}%
		\itshape\large}
	{\quad\contentspage}
	[\addvspace{.5pc}]%
	
	%
	%\titlecontents{section}
	%[3.8em] % ie, 1.5em (chapter) + 2.3em
	%{}
	%{\contentslabel{2.3em}}
	%{\hspace*{-2.3em}}
	%{\titlerule*[1pc]{.}\contentspage}
	
	\titlecontents{section}
	[3.4em] % ie, 1.5em (chapter) + 2.3em
	{}
	{\contentslabel{2em}\enspace\enspace}
	{\hspace*{-2.3em}\enspace}
	{\quad\contentspage}%
	
	\titlecontents{subsection}
	[6.6em] % ie, 1.5em (chapter) + 2.3em
	{}
	{\contentslabel{2.3em}\enspace\enspace}
	{\hspace*{-2.3em}\enspace}
	{\quad\contentspage}%
	
	\titlecontents{subsubsection}
	[8.9em] % ie, 1.5em (chapter) + 2.3em
	{}
	{\contentslabel{2.3em}\enspace\enspace}
	{\hspace*{-2.3em}\enspace}
	{\quad\contentspage}%
	
	
	\titlecontents{figure}
	[0pt] % ie, 1.5em (chapter) + 2.3em
	{}
	{\contentslabel{2.3em}\enspace}
	{\hspace*{-2.3em}\enspace}
	{\quad\contentspage}
	
	\titlecontents{table}
	[0pt] % ie, 1.5em (chapter) + 2.3em
	{}
	{\contentslabel{2.3em}\enspace}
	{\hspace*{-2.3em}\enspace}
	{\quad\contentspage}
	
	
	%%%%%%% end part in toc %%%%%%%%
}

%double all #1 like ##1 if it's inside another definition

%For the parameters of a definition inside a definition you need to double the hash char:
%
%\renewcommand\appendix{\par
%	\def\@makechapterhead##1{%
%		... ##1 ...
%	}%
%	...
%}

%from http://tex.stackexchange.com/questions/62438/how-to-add-leaders-to-table-of-contents-without-tocloft/62441#62441 

\newcommand{\traditionaltoc}{
	
	\renewcommand*\l@part[2]{%
		\ifnum \c@tocdepth >-2\relax
		\addpenalty{-\@highpenalty}%
		\addvspace{2.25em \@plus\p@}%
		\begingroup
		\parindent \z@ \rightskip \@pnumwidth
		\parfillskip -\@pnumwidth
		{\leavevmode
			\large \bfseries ##1\hfil \hb@xt@\@pnumwidth{\hss ##2}}\par
		\nobreak
		\global\@nobreaktrue
		\everypar{\global\@nobreakfalse\everypar{}}%
		\endgroup
		\fi}
	
	
	\renewcommand*\l@chapter[2]{%
		\ifnum \c@tocdepth >\m@ne
		\addpenalty{-\@highpenalty}%
		\vskip 1.0em \@plus\p@
		\setlength\@tempdima{1.5em}%
		\begingroup
		\parindent \z@ \rightskip \@pnumwidth
		\parfillskip -\@pnumwidth
		\leavevmode \bfseries
		\advance\leftskip\@tempdima
		\hskip -\leftskip
		##1\nobreak
		\xleaders\hbox{$\m@th
			\mkern \@dotsep mu\hbox{.}\mkern \@dotsep
			mu$}\hfill%
		\nobreak\hb@xt@\@pnumwidth{\hss ##2}\par
		\penalty\@highpenalty
		\endgroup
		\fi}
	}

\RequirePackage{ifxetex}
\ifxetex
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
%dot below in xetex
\renewcommand{\d}[1]
{\hmode@bgroup
	\o@lign{\relax#1\crcr\hidewidth\ltx@sh@ft{-1ex}.\hidewidth}\egroup}
\else
\RequirePackage[utf8]{inputenc}
\fi

\RequirePackage{hyperref}

\pdfstringdefDisableCommands{%
	\let\enspace\empty  % this causes the warning for \kern
	\let\noindent\empty % this causes the warning for \indent
}

\RequirePackage{graphicx}

\RequirePackage{booktabs}




%%% para notas sempre à direita.
%%%http://tex.stackexchange.com/questions/69595/marginnote-always-on-right-side-of-the-page
%\RequirePackage{etoolbox}
%\patchcmd{\@addmarginpar}{\ifodd\c@page}{\ifodd\c@page\@tempcnta\m@ne}{}{}
%\reversemarginpar


\frenchspacing


	%%%% uso econômico de espaços%%%%
	
	\renewcommand\floatpagefraction{.9}
	\renewcommand\dblfloatpagefraction{.9} % for two column documents
	\renewcommand\topfraction{.9}
	\renewcommand\dbltopfraction{.9} % for two column documents
	\renewcommand\bottomfraction{.9}
	\renewcommand\textfraction{.1}   
	\setcounter{totalnumber}{50}
	\setcounter{topnumber}{50}
	\setcounter{bottomnumber}{50}

%\setcounter{totalnumber}{1}
%\setcounter{topnumber}{1}
%\setcounter{bottomnumber}{1}
%\renewcommand{\topfraction}{.99}
%\renewcommand{\bottomfraction}{.99}
%\renewcommand{\textfraction}{.01}


%%%% margins in two-side 


\if@marginparsused
\setlength\marginparsep{1cc}
\addtolength\oddsidemargin{-1cc}
\addtolength\evensidemargin{5.5cc}
\setlength{\marginparwidth}{1.3in}
\setlength\marginparpush{.5\baselineskip}
\else
\setlength\marginparsep{0cc}
\setlength\marginparwidth{0cc}
\def\marginpar{\ClassError{mwcls}{Marginpars are disabled by
		default in this class.\MessageBreak  Use `withmarginpar'
		option to enable}{}\global\let\marginpar\@gobble}
\fi









%%%%%% TWO PAGE PICTURE %%%%%%%%
%%%% from: http://tex.stackexchange.com/questions/23860/how-to-include-a-picture-over-two-pages-left-part-on-left-side-right-on-right
%%% Thanks to Martin Scharrer

\RequirePackage{adjustbox}
\RequirePackage{afterpage}
\RequirePackage{placeins}
\RequirePackage[strict]{changepage}


	\newcommand*{\twopagepicture}[4]{%
    \checkoddpage
    \ifoddpage
        \expandafter\@firstofone
    \else
        \expandafter\afterpage
    \fi
    {\afterpage{%
    \if #1t%
        \if #2p%
            \thispagestyle{empty}%
            \afterpage{\thispagestyle{empty}}%
        \fi
    \fi
    \begin{figure}[#1]
        \if #2p%
            \if #1t%
                \vspace*{-\dimexpr1in+\voffset+\topmargin+\headheight+\headsep\relax}%
            \fi
        \fi
        \if #1b%
            \caption{#4}%
        \fi
        \makebox[\textwidth][l]{%
        \if #2p\relax
            \let\mywidth\paperwidth
            \hskip-\dimexpr1in+\hoffset+\evensidemargin\relax
        \else
            \let\mywidth\linewidth
        \fi
        \adjustbox{trim=0 0 {.5\width} 0,clip}{\includegraphics[width=2\mywidth]{#3}}}%
        \if #1b\else
            \caption{#4}%
        \fi
        \if #2p%
            \if #1b%
                \vspace*{-\dimexpr\paperheight-\textheight-1in-\voffset-\topmargin-\headheight-\headsep\relax}%
            \fi
        \fi
    \end{figure}%
    \begin{figure}[#1]
        \if #2p%
            \if #1t%
                \vspace*{-\dimexpr1in+\voffset+\topmargin+\headheight+\headsep\relax}%
            \fi
        \fi
        \makebox[\textwidth][l]{%
        \if #2p%
            \let\mywidth\paperwidth
            \hskip-\dimexpr1in+\hoffset+\oddsidemargin\relax
        \else
            \let\mywidth\linewidth
        \fi
        \adjustbox{trim={.5\width} 0 0 0,clip}{\includegraphics[width=2\mywidth]{#3}}}%
        \if #2p%
            \if #1b%
                \vspace*{-\dimexpr\paperheight-\textheight-1in-\voffset-\topmargin-\headheight-\headsep\relax}%
            \fi
        \fi
    \end{figure}%
    }}%
}

%% for usage with \caption*{}%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand*{\twopagepicturen}[4]{%
    \checkoddpage
    \ifoddpage
        \expandafter\@firstofone
    \else
        \expandafter\afterpage
    \fi
    {\afterpage{%
    \if #1t%
        \if #2p%
            \thispagestyle{empty}%
            \afterpage{\thispagestyle{empty}}%
        \fi
    \fi
    \begin{figure}[#1]
        \if #2p%
            \if #1t%
                \vspace*{-\dimexpr1in+\voffset+\topmargin+\headheight+\headsep\relax}%
            \fi
        \fi
        \if #1b%
            \caption*{#4}%
        \fi
        \makebox[\textwidth][l]{%
        \if #2p\relax
            \let\mywidth\paperwidth
            \hskip-\dimexpr1in+\hoffset+\evensidemargin\relax
        \else
            \let\mywidth\linewidth
        \fi
        \adjustbox{trim=0 0 {.5\width} 0,clip}{\includegraphics[width=2\mywidth]{#3}}}%
        \if #1b\else
            \caption*{#4}%
        \fi
        \if #2p%
            \if #1b%
                \vspace*{-\dimexpr\paperheight-\textheight-1in-\voffset-\topmargin-\headheight-\headsep\relax}%
            \fi
        \fi
    \end{figure}%
    \begin{figure}[#1]
        \if #2p%
            \if #1t%
                \vspace*{-\dimexpr1in+\voffset+\topmargin+\headheight+\headsep\relax}%
            \fi
        \fi
        \makebox[\textwidth][l]{%
        \if #2p%
            \let\mywidth\paperwidth
            \hskip-\dimexpr1in+\hoffset+\oddsidemargin\relax
        \else
            \let\mywidth\linewidth
        \fi
        \adjustbox{trim={.5\width} 0 0 0,clip}{\includegraphics[width=2\mywidth]{#3}}}%
        \if #2p%
            \if #1b%
                \vspace*{-\dimexpr\paperheight-\textheight-1in-\voffset-\topmargin-\headheight-\headsep\relax}%
            \fi
        \fi
    \end{figure}%
    }}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%LINHA COLORIDA NO CABEÇALHO
\newcommand{\coloredheadline}[1]{
	\renewcommand\hf@uheadings{%
		\def\@oddhead{\vtop{%
				\hb@xt@\textwidth{%
					\reset@font{\heading@font\rightmark}\hfil\thepage\strut}%
				\vskip2pt\color{#1}\hrule\vskip-2.4pt}}%
		\let\@oddfoot\@empty
		\def\@evenhead{\vtop{%
				\hb@xt@\textwidth{%
					\reset@font\strut\thepage\hfil\heading@font\leftmark}%
				\vskip2pt\color{#1}\hrule\vskip-2.4pt}}%
		\let\@evenfoot\@empty
	}
}

%LINHA COLORIDA NO RODAPÉ
\newcommand{\coloredfootline}[1]{
\renewcommand\footnoterule{%
	\kern-3\p@
	{\color{#1}\hrule\@width4pc}
	\kern2.6\p@}
}
\endinput
