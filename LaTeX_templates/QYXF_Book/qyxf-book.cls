% --------------------------
% qyxf-book 钱院学辅书籍模板
% 如不清楚含义，请勿随意更改
% --------------------------

\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\newcommand{\styversion}{3.1.0}
\newcommand{\styname}{qyxf-book}
\ProvidesClass{qyxf-book}
  [2020/09/11 v3.1.0 Qian Yuan Xue Fu book template]
\typeout{The book template provided by Qian Yuan Xue Fu}

% 设定 key-val 选项
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family = QYXF, prefix = QYXF@}

% 选项定制与处理
\DeclareStringOption[basic]{colorscheme}[basic]
\DeclareStringOption{primary}
\DeclareStringOption{secondary}
\DeclareBoolOption[true]{xits}
\DeclareVoidOption{noCJKfont}{\PassOptionsToClass{fontset=none}{ctexbook}}

% 已废弃选项提示
\DeclareVoidOption{color}{\ClassWarning{\styname}{The option `color' is deprecated. Use `colorscheme' instead}}
\DeclareVoidOption{parskip}{\ClassWarning{\styname}{The option `parskip' is deprecated}}
\DeclareVoidOption{decoration}{\ClassWarning{\styname}{The option `decoration' is deprecated, due to the lack of `pgfornament' package in TeX Live 2020}}
\DeclareVoidOption{sourcefont}{\ClassWarning{\styname}{The option `sourcefont' is deprecated. Please customize your fonts by commands of `fontspec' and `xeCJK' package}}
\DeclareVoidOption{plain}{\ClassWarning{\styname}{The option `sourcefont' is deprecated}}
\DeclareVoidOption{opensource}{\ClassWarning{\styname}{The option `opensource' is deprecated}}

% 处理选项
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*

% 载入文类
\PassOptionsToPackage{no-math}{fontspec}
\PassOptionsToPackage{CJKmath = true}{xeCJK}
\LoadClass{ctexbook}

% 西文字体处理
\RequirePackage{amsmath}
\ifQYXF@xits
  \setmainfont{XITS}
  \setsansfont{TeX Gyre Heros}[Scale=0.93]
  \RequirePackage{unicode-math}
  \setmathfont{XITS Math}
\fi
\RequirePackage{hologo}

% 正文样式设置
\RequirePackage[normalem]{ulem}

% 脚注样式调整
\renewcommand{\thefootnote}{\textbf{(\arabic{footnote})}}

% 浮动体（图表）处理
\RequirePackage{graphicx}
\graphicspath{{./figure/}{./pic/}{./image}}
\setlength{\textfloatsep}{6pt plus 2pt minus 4pt}
\setlength{\intextsep}{6pt plus 2pt minus 2pt}
\RequirePackage{longtable,booktabs}
\RequirePackage{tikz}
\usetikzlibrary{calc,backgrounds,shadows}
\RequirePackage[many]{tcolorbox}

% caption 样式设定
\RequirePackage{caption}
\DeclareCaptionFormat{colored}{\small{\bfseries\color{\CaptionColor}#1} #3}
\captionsetup{
  format = colored,
  skip = 1ex
}

% 处理配色方案
\RequirePackage{etoolbox}
\ifdefempty{\QYXF@primary}{\relax}{\newcommand{\PrimaryColor}{\QYXF@primary}}
\ifdefempty{\QYXF@secondary}{\relax}{\newcommand{\SecondaryColor}{\QYXF@secondary}}

% color scheme 默认值

% for titles amd text
\newcommand{\TitleColor}{black}
\newcommand{\ListColor}{black}
\newcommand{\CaptionColor}{black}
\newcommand{\LinkColor}{black}
\newcommand{\MiscColor}{black}
% for boxes
\newcommand{\BoxBackground}{white}
\newcommand{\BoxFrame}{black!75}
\newcommand{\BoxTitleColor}{white}
\newcommand{\BoxTitleBackground}{black!50}
\newcommand{\BoxColor}{black}
\newcommand{\AlertBackground}{white}
\newcommand{\AlertColor}{black}
\newcommand{\AlertFrame}{black}
\newcommand{\AlertTitleBackground}{black}
\newcommand{\AlertTitleColor}{white}
% for theorems
\newcommand{\DefineBackground}{white}
\newcommand{\DefineFrame}{black!40}
\newcommand{\DefineColor}{black}
\newcommand{\TheoremBackground}{black!10}
\newcommand{\TheoremFrame}{black!80}
\newcommand{\TheoremColor}{black}

% 读取 color scheme
\RequirePackage{xstring}
\IfEqCase{\QYXF@colorscheme}{%
  {basic}{\relax}% Basic theme
  {black}{% BLack theme (bicolor)
    % main colors
    \providecommand\PrimaryColor{black}
    % for titles amd text
    \renewcommand\TitleColor{\PrimaryColor}
    \renewcommand\ListColor{\PrimaryColor}
    \renewcommand\CaptionColor{\PrimaryColor}
    \renewcommand\LinkColor{\PrimaryColor}
    \renewcommand\MiscColor{\PrimaryColor}
    % for boxes
    \renewcommand\BoxBackground{white}
    \renewcommand\BoxTitleColor{\PrimaryColor}
    \renewcommand\BoxTitleBackground{white}
    \renewcommand\BoxFrame{\PrimaryColor}
    \renewcommand\AlertTitleColor{white}
    \renewcommand\AlertTitleBackground{\PrimaryColor}
    % for theorems
    \renewcommand\DefineFrame{\PrimaryColor}
    \renewcommand\TheoremBackground{white}
    \renewcommand\TheoremFrame{\PrimaryColor}
  }%
  {rbb}{% Red-Blue-Black theme (tricolor)
    % main colors
    \providecommand\PrimaryColor{blue}
    \providecommand\SecondaryColor{red}
    % for titles amd text
    \renewcommand\TitleColor{\PrimaryColor}
    \renewcommand\ListColor{\PrimaryColor}
    \renewcommand\CaptionColor{\PrimaryColor}
    \renewcommand\LinkColor{\SecondaryColor}
    \renewcommand\MiscColor{\PrimaryColor}
    % for boxes
    \renewcommand\BoxBackground{white}
    \renewcommand\BoxFrame{\PrimaryColor}
    \renewcommand\BoxTitleBackground{\PrimaryColor}
    \renewcommand\AlertColor{\SecondaryColor}
    \renewcommand\AlertFrame{\SecondaryColor}
    \renewcommand\AlertTitleBackground{\SecondaryColor}
    % for theorems
    \renewcommand\DefineFrame{black}
    \renewcommand\TheoremBackground{white}
    \renewcommand\TheoremFrame{\PrimaryColor}
  }%
  {bootstrap-v4}{% Bootstrap V4 theme
    % for titles amd text
    \renewcommand\TitleColor{black!85}
    \renewcommand\ListColor{blue!50!cyan}
    \renewcommand\CaptionColor{cyan!80!olive}
    \renewcommand\LinkColor{blue!67!green!}
    \renewcommand\MiscColor{blue!50!cyan}
    % for boxes
    \renewcommand\BoxBackground{cyan!20!white}
    \renewcommand\BoxFrame{blue!30!teal}
    \renewcommand\BoxTitleBackground{blue!55!cyan}
    \renewcommand\BoxColor{blue!45!teal!80!black}
    \renewcommand\AlertBackground{red!10!white}
    \renewcommand\AlertColor{red!40!black!90!white}
    \renewcommand\AlertFrame{red!75!teal}
    \renewcommand\AlertTitleBackground{red!80!cyan}
    % for theorems
    \renewcommand\DefineBackground{green!8!white!94!black}
    \renewcommand\DefineFrame{green!10!white!90!black}
    \renewcommand\DefineColor{green!40!black!90!white}
    \renewcommand\TheoremBackground{-blue!20!black!96!green}
    \renewcommand\TheoremFrame{-blue!30!black!90!green}
    \renewcommand\TheoremColor{red!57!green!90!black}
  }%
}[\ClassWarning{\styname}{Color scheme `\QYXF@colorscheme' not found, `basic' theme is used then.}]

% tcolorbox 样式设定
\tcbset{
  enhanced,
  noparskip,
  after = \noindent,
  colback = \BoxBackground,
  title filled,
  colbacktitle = \BoxTitleBackground,
  colframe = \BoxFrame,
  coltitle = \BoxTitleColor,
  coltext = \BoxColor,
  fonttitle = \bfseries,
  arc = 0.25em,
  boxrule = 0.5pt,
  toptitle = 0.75em,
  bottomtitle = 0.75em,
  boxsep = 0pt,
  left = 1.25em,
  right = 1.25em,
  top = 1.25em,
  bottom = 1.25em,
  drop fuzzy shadow,
  breakable
}

% 引导命令
\newcommand{\exercise}[1]{\noindent\textbf{\color{\MiscColor}练习 #1}\ }
\newcommand{\solve}[1][解]{\noindent\textbf{\color{\MiscColor}#1}\ }
\newcommand{\analysis}[1][分析]{\noindent\emph{\color{\MiscColor}#1}\ }

% 定理环境及样式设定
\newtheorem{theorem}{定理}
\newtheorem{lemma}[theorem]{引理}
\newtheorem{define}{定义}
\BeforeBeginEnvironment{theorem}{\begin{tcolorbox}[colback=\TheoremBackground,colframe=\TheoremFrame,coltext=\TheoremColor]}
\AfterEndEnvironment{theorem}{\end{tcolorbox}}
\BeforeBeginEnvironment{lemma}{\begin{tcolorbox}[colback=\TheoremBackground,colframe=\TheoremFrame,coltext=\TheoremColor]}
\AfterEndEnvironment{lemma}{\end{tcolorbox}}
\BeforeBeginEnvironment{define}{\begin{tcolorbox}[colback=\DefineBackground,colframe=\DefineFrame,coltext=\DefineColor]}
\AfterEndEnvironment{define}{\end{tcolorbox}}
\newtcolorbox{note}{title={注记}}
\newtcolorbox{alert}{
  title = {警告},
  colback = \AlertBackground,
  colframe = \AlertFrame,
  colbacktitle = \AlertTitleBackground,
  coltitle = \AlertTitleColor,
  coltext = \AlertColor
}

% 页面设置
\RequirePackage{geometry}
\geometry{margin = 1in}
\setlength{\footskip}{30pt}
\setlength{\headheight}{15pt}

% 链接设置
\RequirePackage[unicode]{hyperref}
\hypersetup{
  breaklinks,
  unicode,
  linktoc = all,
  bookmarksnumbered = true,
  bookmarksopen = true,
  pdfborder = {0 0 0},
  linktocpage,
  pageanchor = true
}
\hypersetup{
  colorlinks = true,
  linkcolor = \LinkColor,
  anchorcolor = \MiscColor,
  urlcolor = \LinkColor,
  citecolor = \MiscColor
}

% 章节标题与目录样式
\RequirePackage{titlesec,titletoc}
\ctexset{section={name={\S,}}}
\titleformat{\chapter}[block]{\color{\TitleColor}\centering\bfseries\fontsize{2.25em}{1.2ex}}{\CTEXthechapter}{1em}{}
\titleformat*{\section}{\color{\TitleColor}\fontsize{1.75em}{1.225ex}\bfseries\centering}
\titleformat*{\subsection}{\color{\TitleColor}\fontsize{1.5em}{1.43ex}\bfseries}
\titleformat*{\subsubsection}{\color{\TitleColor}\fontsize{1.25em}{1.4ex}\bfseries}
\titleformat*{\paragraph}{\color{\TitleColor}\bfseries}
\titleformat*{\subparagraph}{\color{\TitleColor}}
\titlespacing{\chapter}{0pt}{*1}{*4}
\titlecontents{chapter}[24pt]{\hspace{-2pc}\filright}
              {\normalsize\bfseries\contentspush{\thecontentslabel\ }}
              {}{\bfseries\titlerule*[8pt]{.}\contentspage}
\titlecontents{section}[20pt]{\filright}
              {\contentspush{\thecontentslabel\ }}
              {}{\titlerule*[8pt]{.}\contentspage}
\titlecontents{subsection}[18pt]{\hspace{2pc}\filright}
              {\contentspush{\thecontentslabel\ }\itshape}
              {}{\titlerule*[8pt]{}\contentspage}
\setcounter{tocdepth}{2}

% 页眉页脚设置
\newcommand{\footerbox}{%
  {\color{\MiscColor}\bfseries\thepage}\\[-\baselineskip]
  \uline{\hphantom{\@footorginfo}}\\
  \@footorginfo}
\RequirePackage{fancyhdr}
\fancyhead[EC]{\itshape\nouppercase\leftmark}
\fancyhead[OC]{\itshape\nouppercase\rightmark}
\fancyhead[EL,OR]{}
\fancyhead[ER,OL]{}
\fancyfoot[C]{\footerbox}
\fancypagestyle{plain}{%
  \fancyhf{}
  \fancyfoot[C]{\footerbox}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}

% 列表样式设置
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{pifont}
\setlist{nosep, partopsep=0.5ex}
\setlist[itemize,1]{label={\color{\ListColor}\ding{228}}, left=0.8em}
\setlist[itemize,2]{label={\color{\ListColor}\ding{111}}, left=2.8em}
\setlist[itemize,3]{label={\color{\ListColor}\ding{109}}, left=4.8em}
\setlist[enumerate,1]{label={\color{\ListColor}\textbf{\arabic*}.}, left=0.8em}
\setlist[enumerate,2]{label={\color{\ListColor}{\arabic*}.}, left=2.8em}
\setlist[enumerate,3]{label={\color{\ListColor}({\arabic*})}, left=4.8em}
\setlist[description]{style=nextline, font=\color{\ListColor}\bfseries}

% 参考文献定制
\RequirePackage[square,numbers]{natbib}
\renewcommand{\citenumfont}[1]{{\color{\LinkColor}#1}}
\renewcommand{\bibnumfmt}[1]{{\color{\ListColor}[#1]}}
\AtBeginEnvironment{thebibliography}{\addcontentsline{toc}{chapter}{\bibname}}

% 杂项
\RequirePackage{lastpage}
\RequirePackage{appendix}
\ctexset{appendix={number={\Roman{chapter}}}}

% 若干 metadata
\newcommand{\@subtitle}{}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\@typo}{}
\newcommand{\typo}[1]{\gdef\@typo{#1}}
\newcommand{\@cover}{}
\newcommand{\cover}[1]{\gdef\@cover{#1}}
\newcommand{\@orginfo}{%
  \textit{钱学森书院学业辅导中心}\\[1ex]
  \textsc{Xi'an Jiaotong University}}
\newcommand{\org}[1]{\gdef\@orginfo{#1}}
\newcommand{\@footorginfo}{\textsc{Qian Yuan Xue Fu}}
\newcommand{\footorg}[1]{\gdef\@footorginfo{#1}}
\newcommand{\@licenseinfo}{%
本作品采用%
\href{https://creativecommons.org/licenses/by-nc-nd/4.0/}%
{\bfseries CC BY-NC-ND 4.0 协议}进行许可。
使用者可以在给出作者署名及资料来源的前提下对本作品进行转载，%
但不得对本作品进行修改，亦不得基于本作品进行二次创作，%
不得将本作品运用于商业用途。}
\newcommand{\license}[1]{\gdef\@licenseinfo{#1}}

% 已废弃的 metadata
\newcommand{\version}[1]{\ClassWarning{\styname}{The metadata item `version' is deprecated}}
\newcommand{\sourcepage}[1]{\ClassWarning{\styname}{The metadata item `sourcepage' is deprecated}}

% 封面样式重定义
\newcommand{\titlefont}{\Huge\bfseries}
\newcommand{\subtitlefont}{\huge\itshape}
\newcommand{\authorfont}{\LARGE\itshape}
\newcommand{\datefont}{\Large}
\renewcommand*{\maketitle}{%
  \begin{titlepage}
  \null
  \begin{center}\large
  \begin{tcolorbox}[blanker,borderline west={1mm}{0pt}{\BoxFrame},%
  left=20pt,top=1ex,bottom=1ex,after skip=0pt,no shadow]
  {\color{\TitleColor}\titlefont\@title}
  \ifdefempty\@subtitle{}{\\[1ex]{\color{\TitleColor}\subtitlefont\@subtitle}}
  \end{tcolorbox}
  \begin{tcolorbox}[blanker,borderline west={1mm}{0pt}{\TitleColor},%
  left=20pt,top=2ex,bottom=1ex,before skip=0pt,after skip=0pt,no shadow]
  {\authorfont\@author}\\\datefont\@date
  \end{tcolorbox}
  \vfil\@cover\vfil
  \vbox{\@orginfo}
  \end{center}
  \vfilneg
  \end{titlepage}
  \thispagestyle{empty}
  \newpage
  \hypersetup{pageanchor=true}
  \null\vfill
  \begin{tcolorbox}[title={\bfseries 作品信息}]
  \begin{itemize}
    \item \textbf{标题：}\@title{}\ifdefempty\@subtitle{}{: \textit{\@subtitle}}
    \item \textbf{作者：}\@author%
    \ifdefempty{\@typo}{}{\item \textbf{校对排版：}\@typo}
    \item \textbf{出品时间：}\@date
    \item \textbf{总页数：}\pageref{LastPage}
  \end{itemize}
  \end{tcolorbox}
  \ifdefempty\@licenseinfo{}{%
    \begin{tcolorbox}[title={\bfseries 许可证说明}]
    \@licenseinfo
    \end{tcolorbox}}
  \newpage
  \pagestyle{fancy}}
\AtBeginDocument{%
  \hypersetup{
    pageanchor=false,
    pdfauthor=\@author,
    pdftitle=\@title,
    pdfsubject={\@author: \@title\ifdefempty{\@subtitle}{}{ - \textit{\@subtitle}}},
    pdfkeywords={qyxf, book},
    pdfcreator={XeLaTeX with \styname\ v\styversion\ \ifdefempty{\@typo}{}{(by \@typo)}}
  }}

% 目录样式重定义
\renewcommand\tableofcontents{%
\pagestyle{empty}
\begin{center}%
\normalfont\LARGE\bfseries\contentsname%
\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}
\end{center}
\vskip 3ex%
{\setlength\parskip{0pt}\@starttoc{toc}}
\cleardoublepage
\pagestyle{fancy}
\setcounter{page}{1}
}

% 修正配色方案重定义问题
\newcommand{\selectcolor}{
  \hypersetup{
    linkcolor = \LinkColor,
    anchorcolor = \MiscColor,
    urlcolor = \LinkColor,
    citecolor = \MiscColor
  }
  \tcbset{
    colback = \BoxBackground,
    colbacktitle = \BoxTitleBackground,
    colframe = \BoxFrame,
    coltitle = \BoxTitleColor,
    coltext = \BoxColor
  }
}

\endinput
