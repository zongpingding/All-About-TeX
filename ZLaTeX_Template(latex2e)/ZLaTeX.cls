\ProvidesClass{ZLaTeX}[2023/09/12:Initial Template]
\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}                             





% ----------------------------------------------------------------------
%                       1. kvoptions config 
% ----------------------------------------------------------------------
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}
\SetupKeyvalOptions{%
    family=ZLATEX,
    prefix=ZLATEX@,
    setkeys=\kvsetkeys
}
\newcommand{\kvs}[1]{\kvsetkeys{ZLATEX}{#1}}
% MathFont Option
\DeclareVoidOption{eulervm}{\kvs{math=eulervm}} 
\DeclareVoidOption{mtpro}{\kvs{math=mtpro}} 
\DeclareVoidOption{mathptmx}{\kvs{math=mathptmx}} 
\DeclareStringOption[]{math}
% Template 'zLaTeX' lang prefer
\DeclareVoidOption{cn}{\kvs{lang=cn}}
\DeclareVoidOption{en}{\kvs{lang=en}}
\DeclareStringOption[cn]{lang}
% bibend and bibstyle setting
\DeclareVoidOption{biber}{\kvs{bibend=biber}}
\DeclareVoidOption{bibtex}{\kvs{bibend=bibtex}}
\DeclareStringOption[biber]{bibend}
\DeclareStringOption[numeric-comp]{citestyle}
\DeclareStringOption[numeric]{bibstyle}
% packages about plot
\DeclareVoidOption{FunctionPlot}{\kvs{plot=FunctionPlot}} 
\DeclareVoidOption{gplot}{\kvs{plot=gplot}} 
\DeclareVoidOption{all}{\kvs{plot=all}} 
\DeclareStringOption[]{plot}
% Math command alias
\DeclareBoolOption{MathAlias}
% End of Option Declaration
\DeclareDefaultOption{
    \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessKeyvalOptions*\relax





% ----------------------------------------------------------------------
%                       2. switch languages 
% ----------------------------------------------------------------------
\ifdefstring{\ZLATEX@lang}{cn}{%
    % doc info name
    \newcommand{\ZLATEX@Author@Name}{作者}
    \renewcommand{\contentsname}{目录}
    % figure and table name
    \renewcommand{\figurename}{图}
    \renewcommand{\tablename}{表}
    % math environment
    \newcommand{\ZLATEX@difinition@name}{定义}
    \newcommand{\ZLATEX@theorem@name}{定理}
    \newcommand{\ZLATEX@proposition@name}{命题}
    \newcommand{\ZLATEX@corollary@name}{推论}
    \newcommand{\ZLATEX@lemma@name}{引理}
    \newcommand{\ZLATEX@proof@name}{证明}
}{\relax}
\ifdefstring{\ZLATEX@lang}{en}{%
    % doc info name
    \newcommand{\ZLATEX@Author@Name}{Author}
    \renewcommand{\contentsname}{Contents}
    % figure and table name
    \renewcommand{\figurename}{Fig}
    \renewcommand{\tablename}{Table}
    % math environment
    \newcommand{\ZLATEX@difinition@name}{Difinition}
    \newcommand{\ZLATEX@theorem@name}{Theorem}
    \newcommand{\ZLATEX@proposition@name}{Proposition}
    \newcommand{\ZLATEX@corollary@name}{Corollary}
    \newcommand{\ZLATEX@lemma@name}{Lemma}
    \newcommand{\ZLATEX@proof@name}{Proof}
}{\relax}





% ----------------------------------------------------------------------
%                       3. font config according to lang
% ----------------------------------------------------------------------
% load package accorrding to lang
\ifdefstring{\ZLATEX@lang}{cn}{
    % pass option to font spec(automaticaly call by ctex)
    \PassOptionsToPackage{quiet,no-math}{fontspec}
    \RequirePackage{ctex}               % basic chinese font package 
    % Chinese Font
    \setCJKfamilyfont{fangsong}{simfang.ttf}[
        Path=./ZLaTeX_Core/Source/Fonts/,
        BoldFont=simfangbold.ttf
    ]
    % English font
    \newfontfamily{\Cinzel}[Path=./ZLaTeX_Core/Source/Fonts/]{CinzelRegular.ttf}[
        BoldFont=CinzelBold.ttf,
        ItalicFont=SabonItalic.ttf
    ]
}{
    % English font package
    % inputenc for '€, ©, é, à, ü' and more Non-ASCII symbols in Latin-1 table
    \RequirePackage[latin1]{inputenc}
    % support more Nno-ASCII symbol or font Using coding T1  
    \RequirePackage[T1]{fontenc}
    % 'scit' shape support
    % \RequirePackage{lmodern}
    % English font redefine
    \newcommand{\Cinzel}{\rmfamily\scshape}
}





% ----------------------------------------------------------------------
%                           4.Check Compile Engine                                          
% ----------------------------------------------------------------------
\RequirePackage{ifxetex}
\ifdefstring{\ZLATEX@lang}{cn}{
    \ifxetex\relax
        \relax
    \else
        \ClassError{ZLaTeX}{Under lang=cn in class ZLATEX, Please Use XeTeX to compile the '*.tex' file} 
    \fi
}{\relax}





% ----------------------------------------------------------------------
%                               5.Page Layout 
% ----------------------------------------------------------------------
% 5.1 marginwidth, head, foot
% Standard A4 size(ISO 216, inch):8.27 × 11.69
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
% length define
\newlength{\left@sep}
\newlength{\post@right@sep}
\newlength{\top@sep}
\newlength{\he@dheight}
\newlength{\hdr@ffset}
\setlength{\left@sep}{.1\paperwidth}
\setlength{\top@sep}{.1\paperheight}
\setlength{\he@dheight}{0.05\paperheight}
% Initial Seeting:left = 1.25right, bottom = 1.375top 
\geometry{
    % body settings(Clip paper, Ratio=sqrt(2))
    paperheight=12.02in, paperwidth=8.5in,                  
    left=\left@sep, 
    top=\top@sep, height=.9\paperheight,
    marginparsep=\dimexpr(1\paperwidth-2\left@sep)/25, marginparwidth=\dimexpr(1.3\left@sep),
    % body internal setting(Clip body)  
    width=\dimexpr(1\paperwidth-1\marginparsep-1\marginparwidth-2\left@sep),
    headheight=\he@dheight, headsep=.02\paperheight, footskip=.05\paperheight,
}
% store temporary \post@right@sep
\setlength{\post@right@sep}{\dimexpr(1\paperwidth-1\left@sep-1\textwidth-1\marginparsep-1\marginparwidth)}
% store oorigina \S cmd
\let\@ldS\S
% 5.2 define page style
\fancypagestyle{fancy}{%
    \fancyhf{}                                          
    \pagenumbering{arabic}
    \setlength{\hdr@ffset}{\dimexpr(1\paperwidth-1\textwidth-\marginparsep)/2}
    \fancyheadoffset[rh]{\hdr@ffset}
    % To redefine \headrule not \headrulelength(pagestyle 'sepci@l' and 'plain' changed the same time)
    % new fancyhdr style --- 2023-10-17
    \renewcommand{\headrule}{
        \begin{tikzpicture}[overlay, remember picture]
            \draw[gray] (2pt, 5pt) node[circle, inner sep=0, minimum size=4pt, fill=gray] {} -- (1\linewidth+1\hdr@ffset, 5pt);
        \end{tikzpicture}    
    }
    % original fancyhdr style --- 2023-9-17
    \fancyhead[R]{\color{gray}\@ldS\number\numexpr\value{chapter}-0\relax.\;\currentch@ptername}
    \fancyhead[L]{\color{gray}\thepage}
}
% define 'speci@l' pagestyle for nomargin page
\fancypagestyle{speci@l}{
    \fancyhf{}
    \setlength{\hdr@ffset}{0pt}
    \fancyheadoffset[rh]{\hdr@ffset}
    \renewcommand{\headrule}{
        \begin{tikzpicture}[overlay, remember picture]
            \draw[gray] (2pt, 5pt) node[circle, inner sep=0, minimum size=4pt, fill=gray] {} -- (1\linewidth, 5pt);
        \end{tikzpicture}    
    }
    \fancyhead[R]{\color{gray}\@ldS\number\numexpr\value{chapter}-0\relax.\;\currentch@ptername}
    \fancyhead[L]{\color{gray}\thepage}
}
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\headrule}{}
    \fancyfoot[C]{\thepage}
    % To cancle page number in 'contents' page, You need to redefine the 'plain' pagestyle
    % Avoid using command '\addtocontents{toc}{\protect\thispagestyle{empty}}' 
}
% use deafault fancy page style right after \begin{document}
\AtBeginDocument{
    \pagestyle{fancy}
}
% 5.3 change current geometry
\renewcommand{\newgeometry}[1]{
    \Gm@restore@org
    \Gm@initnewgm
    \Gm@newgmtrue
    \setkeys{Gm}{#1}
    \Gm@newgmfalse
    \Gm@process
    \ifnum\mag=\@m\else\Gm@magtooffset\fi
    \Gm@changelayout
    \Gm@showparams{newgeometry}
}
\renewcommand{\restoregeometry}{
    \Gm@restore@pkg
    \Gm@changelayout
}
\newcommand{\cancle@margin}[1][.8]{%
    \newgeometry{             
        left=\dimexpr(5\left@sep-#1\dimexpr(5\left@sep))\relax,
        top=\top@sep, height=.838\paperheight, 
        width=\dimexpr(.2\paperwidth+#1\paperwidth-1\left@sep-1.3\post@right@sep),
        headheight=\he@dheight, headsep=.02\paperheight, footskip=.05\paperheight,
    }
    \thispagestyle{speci@l}
}
\newcommand{\start@margin}{\restoregeometry\relax}
\newcommand{\nomargin}[1][.8]{\clearpage\cancle@margin[#1]\relax}
\newcommand{\margin}{\clearpage\start@margin\relax}





% ----------------------------------------------------------------------
%                               6.Font Config
% ----------------------------------------------------------------------
\RequirePackage{thmtools,amsmath}   % basic math package
\RequirePackage{amsfonts,mathtools} % which provide more math font  
\RequirePackage{bm}                 % bold math font 
\ifdefstring{\ZLATEX@math}{eulervm}{
    \RequirePackage[OT1, euler-digits]{eulervm}
}{\relax}
\ifdefstring{\ZLATEX@math}{mtpro}{
    \RequirePackage[lite,subscriptcorrection,slantedGreek,nofontinfo]{mtpro2}
}{\relax}
\ifdefstring{\ZLATEX@math}{mathptmx}{
    \RequirePackage[T1]{fontenc}
    \RequirePackage{mathptmx}
}{\relax}





% ----------------------------------------------------------------------
%                               7.Optional Package
% ----------------------------------------------------------------------
\RequirePackage{pifont}
\RequirePackage{enumerate}          % 'enumerate' env personal config 
\RequirePackage{framed}             % framed box
\RequirePackage{booktabs}           % use three-line table 
\RequirePackage{multicol}           % use multicol table
\RequirePackage{marginnote}         % Margin setting
\let\m@rginnote\marginnote
\renewcommand{\marginnote}[2][-6em]{
    \m@rginnote[]{
        \ifdefstring{\ZLATEX@lang}{cn}{
            \kaishu
        }{\slshape} #2
    }[#1]
}





% ----------------------------------------------------------------------
%                           8.TikZ Setting
% ----------------------------------------------------------------------
% 8.1 tikz config
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\pgfplotsset{compat=1.17}       
% 8.2 plot packages import
\ifdefstring{\ZLATEX@plot}{gplot}{
    \RequirePackage{ZLaTeX_Core/Source/Packages/gplot}
}{\relax}
\ifdefstring{\ZLATEX@plot}{FunctionPlot}{
    \RequirePackage{ZLaTeX_Core/Source/Packages/FunctionPlot}
}{\relax}
\ifdefstring{\ZLATEX@plot}{all}{
    \RequirePackage{ZLaTeX_Core/Source/Packages/FunctionPlot}
    \RequirePackage{ZLaTeX_Core/Source/Packages/gplot}
}{\relax}





% ----------------------------------------------------------------------
%                           9.Float Environment
% ----------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{float}
\graphicspath{%
    {./figure/}{./figures/}{./image/}{./images/}%
    {./graphics/}{./graphic/}{./pictures/}{./picture/}%
    {./Pics}{./pics}%
    {./ZLaTeX_Core/AuxFiles/MMA}%
    {./ZLaTeX_Core/Source/CorePics}%
}
\counterwithin{figure}{subsection}
\counterwithin{table}{subsection}





% ----------------------------------------------------------------------
%                             10.Reference and index Setting
% ----------------------------------------------------------------------
\bibliographystyle{plain}
\RequirePackage[
    backend=\ZLATEX@bibend,
    citestyle=\ZLATEX@citestyle,
    bibstyle=\ZLATEX@bibstyle
]{biblatex}





% ----------------------------------------------------------------------
%                               11.Counter define and update
% ----------------------------------------------------------------------
% 11.1 Reset Counter 
\newcommand{\resetcount}{%
    % reser note's title
    \setcounter{section}{0}
    \setcounter{subsection}{0}
    \setcounter{equation}{0}
    % math env reset
    \setcounter{definition}{0}
    \setcounter{theorem}{0}
    \setcounter{proposition}{0}
    \setcounter{corollary}{0}
    \setcounter{lemma}{0}
}
% 11.2 chapter counter
\RequirePackage{ZLaTeX_Core/Source/Packages/numtrans}
\usetikzlibrary{calc}
\RequirePackage{tocloft}
\RequirePackage{titletoc}
\newcounter{chapter}
\newcommand{\currentch@ptername}{}
\newlength{\title@skip}
% chapter color and length
\definecolor{chpcolor}{HTML}{7f8184}
\definecolor{chpLogoTextColor}{HTML}{4c4c4e}
\definecolor{chpTextColor}{HTML}{231f20}
\newlength{\chaplinexshift}
\newlength{\chaplineyextend}
\setlength{\chaplinexshift}{.5em}
\setlength{\chaplineyextend}{\dimexpr(.75\paperwidth-5em-1\chaplinexshift)}
% default blind text for chapter
\newcommand{\@ALC}{%
    \includegraphics[width=.25\paperwidth]{./ZLaTeX_Core/Source/CorePics/ChapPic.png}\par\vspace*{2em}
    We add two words of caution. First, if two different syntactical variables
    occur in the same context, they do not necessarily 
    represent different expressions ...
}
\newcommand{\@ARC}{%
    Logic is the study of reasoning; and mathematical logic is the study of the type of
    reasoning done by mathematicians. To discover the proper approach to mathe*
    matical logic, we must therefore examine the methods of the mathematician.

    The conspicuous feature of mathematics, as opposed to other sciences, is
    the use of proofs instead of observations. A physicist may prove physical laws
    from other physical laws; but he usually regards agreement with observation as
    the ultimate test of a physical law. A mathematician may, on occasions, use
    observation; for example, he may measure the angles of many triangles and
    conclude that the sum of the angles is always 180°. However, he will accept this
    as a law of mathematics only when it has been proved.
}
\newcommand{\ChpS@ying}{%
    Mathematical logic has always been closely connected 
    with the philosophy of mathematics\par
    \leavevmode\hfill \textemdash {
        \ifdefstring{\ZLATEX@lang}{cn}{
            \itshape
        }{\relax}
        \normalsize Joseph R . Shoenfield
    }
}
% 11.3 chapter uer's interface 
\let\old@ALC\@ALC 
\let\old@ARC\@ARC 
\let\old@ChpSaying\ChpS@ying
\newcommand{\ALC}[1]{%
    \renewcommand{\@ALC}{#1}
}
\newcommand{\ARC}[1]{
    \renewcommand{\@ARC}{#1}
}
\newcommand{\ChpSaying}[2][]{
    \renewcommand{\ChpS@ying}{%
        #2\par
        \leavevmode\hfill \textemdash {
            \ifdefstring{\ZLATEX@lang}{cn}{
                \itshape
            }{\relax}
            \normalsize #1
        }
    }
}
\ExplSyntaxOn
\newcommand{\ch@pter}[2][simple]{
    \stepcounter{chapter}
    % add 'chapter' to contents
    \addtocontents{toc}{%
        \vspace*{3em}\large \Roman{chapter}~ \textbf{#2}\vspace*{-2.5em}% 
    }
    % before call 'chapter', add hline in contents
    \addtocontents{toc}{%
        \protect\mbox{}\protect\hspace*{1.7em}\rule[-2em]{.03\textwidth}{.006\textheight}%
        \rule[-2em]{\dimexpr.975\textwidth-2em}{.5pt}\par%
    }
    % page and counter settings
    \clearpage
    \resetcount
    % change chapter style acorrding to #1 
    \tl_if_eq:nnTF {#1}{simple}{
        \begin{tikzpicture}[overlay, remember~ picture]
            \node[anchor=north~ east, inner~ sep=0pt,
                xshift=0cm, yshift=-7cm, font=\Cinzel\Huge\bfseries] 
                at (current~ page.north~ east) {\mbox{Chapter~ \Roman{chapter}\hspace*{1em}}};
            \node[anchor=north~ east, inner~ sep=0pt,
                xshift=0cm, yshift=-9cm, font=\Cinzel\Large] 
                at (current~ page.north~ east) {\mbox{#2\hspace*{2em}}}; 
        \end{tikzpicture}
    }{
        \begin{tikzpicture}[overlay, remember~ picture]
            % 1.mark nodes(need tikz lib 'calu' )
            \coordinate (A) at ($(current~ page.north~ west)+(.125\paperwidth, 0pt)$);
            \coordinate (B) at ($(A)+(5em, -15em)$);
            \coordinate (C) at ($(current~ page.south~ west)+(0em, 22em)$);
            % 2.draw basic 'rectangle' and 'lines'
            \draw[fill=chpcolor, draw=none] (A) rectangle (B); 
            \draw[draw=chpcolor] (B)++(1\chaplinexshift, 6em) -- ++(1\chaplineyextend, 0pt);
            \draw[draw=chpcolor] (B)++(1\chaplinexshift, 0em) -- ++(1\chaplineyextend, 0pt);
            \draw[draw=chpcolor] (B)++(1\chaplinexshift, 1.5pt) -- ++(1\chaplineyextend, 0pt);
            % \shade[top color=yellow,bottom color=black] (0,0) rectangle +(2,1);
            \shade[top~ color=white, bottom~ color=chpcolor!25] (C) rectangle ++(1\paperwidth, 5pt);
            \shade[top~ color=chpcolor!25, bottom~ color=white] ($(C)+(0em, -12em)$) rectangle ++(1\paperwidth, -5pt);
            % 3. annotate text
            \node[anchor=south,color=white] at ($(B)+(-2.5em, 0em)$) {\numtrans{\thechapter}};
            \node[anchor=south~ west, inner~ sep=0pt, 
                yshift=6.5em, xshift=1\chaplinexshift, 
                font=\Large\bfseries, color=chpcolor] at (B) {\quad\relax};
            \node[anchor=south~ west, inner~ sep=0pt,
                yshift=1.5em, xshift=1\chaplinexshift,
                font=\Cinzel\Huge\bfseries, color=chpcolor] at (B) {#2};
            % 4. parbox insert
            \node[anchor=north~ west, inner~ sep=0pt, 
                color=chpTextColor] at ($(B)+(-5em, -1.7em)$) {%
                % left parbox insert
                \parbox[t][][r]{.25\paperwidth}{
                    \begingroup
                    \ifdefstring{\ZLATEX@lang}{cn}{
                        \Cinzel\itshape
                    }{\itshape}\@ALC
                    \endgroup
                }
                % mid blank parbox
                \parbox[t][][r]{1em}{\hspace*{1em}}
                % right parbox insert
                \parbox[t][][r]{\dimexpr(.5\paperwidth-1.5em)}{\@ARC}
            };
            \node[inner~ sep=0pt, font=\Large\Cinzel] at ($(C)+(.5\paperwidth, -6em)$){%
                \parbox[t][][r]{.75\paperwidth}{\ChpS@ying}
            };
        \end{tikzpicture}
    }
    % restore default blind text
    \renewcommand{\@ALC}{\old@ALC}
    \renewcommand{\@ARC}{\old@ARC}
    \renewcommand{\ChpS@ying}{\old@ChpSaying}
    % get current chapter name
    \renewcommand{\currentch@ptername}{#2}%
    \ifnum\value{chapter}=1\relax
        \setcounter{page}{1}
        \thispagestyle{empty}
        \setlength{\title@skip}{0em}
    \else%
        \setlength{\title@skip}{0em}
    \fi
    \thispagestyle{empty}
    \clearpage 
}
\ExplSyntaxOff





% ----------------------------------------------------------------------
%                               12.BookMark and hyperref
% ----------------------------------------------------------------------
\RequirePackage{hyperref}
\hypersetup{
    % bookmark in pdf viewer 
    linktoc=all,
    bookmarksnumbered=true,
    bookmarksopen=true,
    % set url and link color blue
    colorlinks=true,
    linkcolor=black,
    urlcolor=orange,
    citecolor=red,
}
% Add chapter to bookmark 
\newcommand{\chapter}[2][simple]{%
    \ch@pter[#1]{#2}\label{chapter-\thechapter}% 
    \pdfbookmark[0]{#2}{chapter-\thechapter}%   
}





% ----------------------------------------------------------------------
%                               13.Contents and Cover
% ----------------------------------------------------------------------
% 13.1 cover picture
\usetikzlibrary{calc}
\newcommand{\cover}[3][./ZLaTeX_Core/Source/CorePics/Cover_1.jpg]{%
    \begin{titlepage}
    \newlength{\note@name@width}
    \newlength{\author@name@width}
    \newlength{\note@name@push@left}
    \settowidth{\note@name@width}{\scalebox{3.5}{{\sffamily #2}}}
    \settowidth{\author@name@width}{\sffamily\color{gray}\huge \ZLATEX@Author@Name:\;#3}
    \setlength{\note@name@push@left}{5em}
    \begin{tikzpicture}[overlay, remember picture]
        % Backgroud Picture
        \node[anchor=north east, xshift=10pt, yshift=10pt] at (current page.north east)
            {\includegraphics[width=\dimexpr1\paperwidth+10pt]{#1}};
        % Blank space
        \draw[fill=white] (current page.south west) rectangle ++(1\paperwidth, 25em);
        \draw[fill=black, draw=black] (current page.south west)++%
            (1\paperwidth-2em-\note@name@width-\note@name@push@left, 20.2em) rectangle %
            ++(\note@name@width+\note@name@push@left, 2pt);
        % Note's Name
        \node[anchor=south west, xshift=\dimexpr(-\note@name@width-2em), yshift=16em]
            at (current page.south east) {\scalebox{3.5}{{\sffamily #2}}};
        % Author's Name
        \node[anchor=south west, xshift=\dimexpr(-\author@name@width-2em), yshift=10em]
            at (current page.south east) {\sffamily\color{gray}\huge \ZLATEX@Author@Name:\;#3};
    \end{tikzpicture}
    \setcounter{page}{0}
    \end{titlepage}
}
% 13.2 contents indent settings
\renewcommand{\cftsecindent}{3em}
\renewcommand{\cftsubsecindent}{4.5em}
\renewcommand{\cftsubsubsecindent}{6em}
\setlength{\cftsecnumwidth}{15pt}
% 13.3 contents in user's interface
\setcounter{tocdepth}{3}
% Roman pagenumbering for preface and contents page
% bug: redefine \tableofcontents will cause hbox overfull in contents pages
% \let\old@tableofcontents\tableofcontents
\newcommand{\contents}[1][.8]{%
    \pagestyle{plain}
    \pagenumbering{Roman}
    \nomargin[#1]
    \begin{center}
        \tableofcontents
    \end{center}
    \margin
    \pagenumbering{arabic}
    \pagestyle{fancy}
}





% ----------------------------------------------------------------------
%                               14.Math Environment
% ----------------------------------------------------------------------
% 14.1 Math Alias cmds import
\ifZLATEX@MathAlias
    \RequirePackage{ZLaTeX_Core/Source/Packages/MathAlias}
\fi 
\RequirePackage[most]{tcolorbox}
\RequirePackage[strict]{changepage}
\newcommand{\m@thenvfl@g}{}
% 14.2 definition,theorem Env
\newcounter{definition}[subsection]
\newcounter{theorem}[subsection]
\newcounter{proposition}[subsection]
\newcounter{corollary}[subsection]
\newcounter{lemma}[subsection]
\newcounter{post@eq@tag}
% 14.3 reset \theequation = \thesubsection.\theequation(need mathtools package)
% refer: https://liam.page/2013/08/23/LaTeX-Formula-Number/
\@addtoreset{equation}{subsection}
\newtagform{new@equation@form}[]{(\small\thesubsection.}{)}
\usetagform{new@equation@form}
% 14.4 Muti Functions Env:definition@theorem & proposition@corollary@lemma
% definition, theorem Env
% \RequirePackage{varwidth}     % new definition env need it
\newtcolorbox{definition@theorem@box}[2][]{
    enhanced,
    before skip=2mm,after skip=2mm,
    colback=black!5,colframe=black!50,boxrule=0.2mm,
    attach boxed title to top left={xshift=1cm,yshift*=1mm-\tcboxedtitleheight},
    varwidth boxed title*=-3cm,
    boxed title style={frame code={
            \path[fill=tcbcolback!30!black]
                ([yshift=-1mm,xshift=-1mm]frame.north west)
                    arc[start angle=0,end angle=180,radius=1mm]
                ([yshift=-1mm,xshift=1mm]frame.north east)
                    arc[start angle=180,end angle=0,radius=1mm];
            \path[left color=tcbcolback!60!black,right color=tcbcolback!60!black,
                middle color=tcbcolback!80!black]
                ([xshift=-2mm]frame.north west) -- ([xshift=2mm]frame.north east)
                [rounded corners=1mm]-- ([xshift=1mm,yshift=-1mm]frame.north east)
                -- (frame.south east) -- (frame.south west)
                -- ([xshift=-1mm,yshift=-1mm]frame.north west)
                [sharp corners]-- cycle;
        },interior engine=empty,
    },
    fonttitle=\bfseries,
    title={#2},#1
}
\newenvironment{definition@theorem}[2][]{% 
        % Params illustration
        % #1 --> definition@theorem's name
        % #2 --> Total background color
        \begingroup
        % reset 'equation' counter style in local region
        \setcounter{post@eq@tag}{\theequation}
        \setcounter{equation}{0}
        \let\old@the@equation\theequation
        % define theorem or definion name
        \newcommand{\definition@theorem@title}{}
        \ifdefstring{\m@thenvfl@g}{definition}{
            \renewcommand{\definition@theorem@title}{\textbf{\ZLATEX@difinition@name\;\thesubsection.\thedefinition #1}}
            % For equation tag form already follow by the subsection, 
            % there is no need to add \thesubsection before \thedefinition,
            % which is correspoend to \thedefinition tag form just right(refer: line 616 around)
            \renewcommand{\theequation}{\thedefinition-\old@the@equation}
        }{%
            \ifdefstring{\m@thenvfl@g}{theorem}{
                \renewcommand{\definition@theorem@title}{\textbf{\ZLATEX@theorem@name\;\thesubsection.\thetheorem #1}}
                \renewcommand{\theequation}{\thetheorem-\old@the@equation}
            }{\relax}
        }%
        % 1.Box Style For Definition and 
        % 1.1 original tcolorbox style
        \begin{tcolorbox}[%
            enhanced,
            arc=3pt,
            frame hidden,
            attach boxed title to top left={xshift=0pt, yshift=-1pt},%
            colback=#2,
            coltitle=black,
            title=\definition@theorem@title,
            boxed title style={arc=1.5pt, frame hidden, colback=#2}%
        ]%
        % 1.2 new style 
        % \begin{definition@theorem@box}[colbacktitle=#2]{\definition@theorem@title}
        % 2.inner box font style settings
        \ifdefstring{\ZLATEX@lang}{cn}{
            % \sffamily                 % en & zh font settings
            \fangsong                   % zh font settings
            % \sansmath                 % math font settings
        }{\itshape}
}{
    \end{tcolorbox}
    \setcounter{equation}{\thepost@eq@tag}
    \endgroup
}
% proposition, corollary, lemma Env
\newenvironment{proposition@corollary@lemma}[2][]{%
    % Params illustration
    % #1 --> proposition@corollary@lemma's name
    % #2 --> proposition@corollary@lemma's background and face color
    % Warning: Use 'red' as default color to avoid writer's ignore
    \begingroup
    % reset 'equation' counter style in local region
    \setcounter{post@eq@tag}{\theequation}
    \setcounter{equation}{0}
    \let\old@the@equation\theequation
    % define proposition,corollary or lemma name
    \newcommand{\proposition@corollary@lemma@name}{}
    \ifdefstring{\m@thenvfl@g}{proposition}{
        \renewcommand{\proposition@corollary@lemma@name}{\textbf{\ZLATEX@proposition@name\;\thesubsection.\theproposition #1}}
        \renewcommand{\theequation}{\theproposition-\old@the@equation}
    }{%
        \ifdefstring{\m@thenvfl@g}{corollary}{
            \renewcommand{\proposition@corollary@lemma@name}{\textbf{\ZLATEX@corollary@name\;\thesubsection.\thecorollary #1}}
            \renewcommand{\theequation}{\thecorollary-\old@the@equation}
        }{%
            \ifdefstring{\m@thenvfl@g}{lemma}{
                \renewcommand{\proposition@corollary@lemma@name}{\textbf{\ZLATEX@lemma@name\;\thesubsection.\thelemma #1}}
                \renewcommand{\theequation}{\thelemma-\old@the@equation}
            }{\relax}
        }%
    }%
    % vertical space adjust below displaystyle formula(include it in a local group)
    \setlength{\abovedisplayskip}{5pt plus 2pt minus 3pt}
    \setlength{\belowdisplayskip}{5pt plus 2pt minus 3pt}
    \setlength{\abovedisplayshortskip}{0pt plus 2pt minus 3pt}
    \setlength{\belowdisplayshortskip}{0pt plus 2pt minus 3pt}
    % '\FrameCommand' provide by package 'framed'
    \def\FrameCommand{%
        \hspace{1pt}%
        {\color{#2}\vrule width 1.5pt}%
        {\color{#2!10}\vrule width 2pt}%
        \colorbox{#2!10}%
    }%
    \MakeFramed{\advance\hsize-\width\FrameRestore}%
    \noindent\hspace{-4.55pt}%
    \begin{adjustwidth}{}{7pt}%
    \vspace{2pt}\vspace{2pt}%
    % before \proposition@corollary@lemma@name writes here
    \proposition@corollary@lemma@name\;
    \ifdefstring{\ZLATEX@lang}{cn}{
        \relax
    }{\itshape}
}{%
    \vspace{2pt}
    \end{adjustwidth}
    \endMakeFramed%
    \setcounter{equation}{\thepost@eq@tag}
    \endgroup
}
% 14.5 Specific each math environment
\definecolor{definition@color}{HTML}{d2dae2}
\definecolor{theorem@color}{HTML}{95a5a6}
\definecolor{proposition@color}{HTML}{1e90ff}
\definecolor{corollary@color}{HTML}{1abc9c}
\definecolor{lemma@color}{HTML}{ff7f50}
% 1> difinition environment
\newenvironment{definition}[1][]{%
    \stepcounter{definition}
    % def connect symbol
    \expandafter\ifx\expandafter\relax\detokenize{#1}\relax
        \def\c@nnect{}
    \else
        \def\c@nnect{:\;}
    \fi
    % Renew math env flag
    \renewcommand{\m@thenvfl@g}{definition}       
    \begin{definition@theorem}[\c@nnect{}#1]{definition@color!40}
}{\end{definition@theorem}}
% 2> theorem environment
\newenvironment{theorem}[1][]{%
    \stepcounter{theorem}
    % def connect symbol
    \expandafter\ifx\expandafter\relax\detokenize{#1}\relax
        \def\c@nnect{}
    \else
        \def\c@nnect{:\;}
    \fi 
    % Renew math env flag
    \renewcommand{\m@thenvfl@g}{theorem} 
    \begin{definition@theorem}[\c@nnect{}#1]{theorem@color!25}
}{\end{definition@theorem}}
% 3> proposition environment 
\newenvironment{proposition}[1][]{%
    \stepcounter{proposition}
    % def connect(illustrate) symbol
    \expandafter\ifx\expandafter\relax\detokenize{#1}\relax
        \def\c@nnect{}
    \else
        \def\c@nnect{(#1)}
    \fi
    % Renew math env flag
    \renewcommand{\m@thenvfl@g}{proposition} 
    \begin{proposition@corollary@lemma}[\c@nnect]{proposition@color}
}{\end{proposition@corollary@lemma}}
% 4> corollary environment 
\newenvironment{corollary}[1][]{%
    \stepcounter{corollary}
    % def connect(illustrate) symbol
    \expandafter\ifx\expandafter\relax\detokenize{#1}\relax
        \def\c@nnect{}
    \else
        \def\c@nnect{(#1)}
    \fi
    % Renew math env flag
    \renewcommand{\m@thenvfl@g}{corollary} 
    \begin{proposition@corollary@lemma}[\c@nnect]{corollary@color}
}{\end{proposition@corollary@lemma}}
% 5> lemma environment 
\newenvironment{lemma}[1][]{%
    \stepcounter{lemma}
    % define connect(illustrate) symbol
    \expandafter\ifx\expandafter\relax\detokenize{#1}\relax
        \def\c@nnect{}
    \else
        \def\c@nnect{(#1)}
    \fi
    % Renew math env flag
    \renewcommand{\m@thenvfl@g}{lemma} 
    \begin{proposition@corollary@lemma}[\c@nnect]{lemma@color}
}{\end{proposition@corollary@lemma}}
% 6> proof environment
\newenvironment{proof}{
    % storage post equation tag
    \setcounter{post@eq@tag}{\theequation}
    \begingroup
    % change formula tag form(need mathtools)
    % ref: https://liam.page/2013/08/23/LaTeX-Formula-Number/ 
    \newtagform{proof@tag}{}{}
    \usetagform{proof@tag}
    \renewcommand{\theequation}{}
    \par\noindent\textbf{\ZLATEX@proof@name\;}
    \ifdefstring{\ZLATEX@lang}{cn}{
        \CJKfamily{fangsong}
    }{\itshape}
}{%
    \hfill$\square$%
    \endgroup
    \setcounter{equation}{\thepost@eq@tag}
}





% ----------------------------------------------------------------------
%                               15.Code print Environment 
% ----------------------------------------------------------------------
\RequirePackage{listings}
\newcounter{code}
\stepcounter{code}
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}
% 15.1 listing Env setting
\lstset{
    aboveskip=3mm,
    belowskip=3mm,
    showstringspaces=false,
    columns=flexible,
    rulecolor=\color{gray},
    backgroundcolor=\color{white},
    numbers=left,
    numbersep=5pt,
    numberstyle=\fontsize{8pt}{8pt}\selectfont\color{gray}\ttfamily,
    breaklines=true,
    postbreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookrightarrow\space}},
    breakatwhitespace=true,
    tabsize=4,
}
% 15.2 normal code Env
\lstnewenvironment{bytes}[1][\f@size]           % setting default code fontsize = \normalsize 
{
    \lstset{%
        frame=tlb,
        frameround=fftt,
        aboveskip=1em,
        basicstyle=\fontsize{#1pt}{#1pt}\selectfont\ttfamily,
    }
}{}
% 15.3 Specific Language's Env 
\lstnewenvironment{code}[2][]{%
    \lstset{%
        basicstyle={\small\ttfamily},
        frame=tb,
        framerule=1pt,
        rulecolor=\color{gray!35},
        backgroundcolor=\color{gray!5},
        numberstyle=\small\color{gray}\ttfamily,
        keywordstyle=\color{blue},
        commentstyle=\color{dkgreen},
        stringstyle=\color{mauve},
        language=#2,
    }
    \stepcounter{code}
}{}





% ----------------------------------------------------------------------
%                               End of 'ZLaTeX' Document Class
% ----------------------------------------------------------------------
% Template logo
\newcommand{\zlatex}{\scalebox{-1.1}[-1]{\raise-.5em\hbox{\textcolor{blue}{$\pi$}}}\LaTeX}
\endinput 
