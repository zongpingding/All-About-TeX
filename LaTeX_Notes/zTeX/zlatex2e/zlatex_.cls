\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}





% ----------------------------------------------------------------------
%                       zlatex document class Metadata
% ----------------------------------------------------------------------
\ExplSyntaxOn
% zlatex class info
\tl_const:Nn \c__zlatex_class_name_tl            {zlatex}
\tl_const:Nn \c__zlatex_class_version_tl         {1.0.0}
\tl_const:Nn \c__zlatex_class_date_tl            {2024/06/12}
\tl_const:Nn \c__zlatex_class_description_tl     {A~pre-release~latex3~document~class}

\ProvidesExplClass{\c__zlatex_class_name_tl}         % Class
                  {\c__zlatex_class_date_tl}         % Date
                  {\c__zlatex_class_version_tl}      % Version
                  {\c__zlatex_class_description_tl}  % Description

% class message type
\prop_gput:Nnn \g_msg_module_type_prop { zlatex } { Class }
\msg_new:nnn {zlatex}{option-language}{Current~invalid~language~option~is:~'\g__zlatex_lang_str',zlatex~only~support~'en,~ cn'~now.}





% ----------------------------------------------------------------------
%                              Class Option 
% ----------------------------------------------------------------------
\RequirePackage {l3keys2e}
% key-value alias
\cs_new_protected:Npn \zlatex_define_option:n
  { \keys_define:nn { zlatex / option } }
\cs_new_protected:Npn \zlatex_define:nn #1
  { \keys_define:nn { zlatex / #1} }
\cs_new_protected:Npn \zlatex_set:nn #1
  { \keys_set:nn { zlatex / #1 } }
\cs_new_protected:Npn \zlatex_load_after:n #1
  { \AtBeginDocument {#1} }

% setup options for class
\zlatex_define_option:n {
  % fancy to load 'tikz', 'tcolorbox' etc,.
  fancy           .bool_gset:N  =  \g__zlatex_fancy_bool,
  fancy           .initial:n    =  { false },
  % zlatex language
  lang            .str_gset:N   =  \g__zlatex_lang_str,
  lang            .initial:n    =  { en },
  hyper           .bool_gset:N  =  \g__zlatex_hyperref_bool,
  hyper           .initial:n    =  { false },
  % class and options
  class           .str_gset:N   = \g__zlatex_subclass_type_str,
  class           .initial:n    = { article },
  classOption     .clist_gset:N = \g__zlatex_subclass_option_clist,
  classOption     .initial:n    = { oneside, 10pt },
  % zlatex options meta key 
  layout          .meta:nn      = {zlatex / layout}{#1},
  mathSpec        .meta:nn      = {zlatex / mathSpec}{#1},
  font            .meta:nn      = {zlatex / font}{#1},
  bib             .meta:nn      = {zlatex / bib}{#1},
  % toc setup
  toc             .multichoice:,
  toc / 2column   .code:n       =  { \zlatex_load_after:n { \RequirePackage[toc]{multitoc} } },
  toc / redef     .code:n       =  { 
    \str_case:VnF \g__zlatex_lang_str {
      {en}{ \zlatex_load_after:n {\renewcommand{\contentsname}{\hfill\bfseries\huge Contents \hfill}} }
      {cn}{ \zlatex_load_after:n {\renewcommand{\contentsname}{\hfill\bfseries\huge 目录     \hfill}} }
    }{\msg_error:nn {zlatex}{option-language}}
  },
  toc / unknown.code:n          =  {
    \msg_new:nnn {zlatex}{option-toc}{Current~toc~option~is~:~'#1'~,default~toc~settings~substitute.}
    \msg_warning:nn {zlatex}{option-toc}
  },
}

% sub-key for each option
\zlatex_define:nn {layout}{
  margin              .bool_gset:N  = \g__zlatex_margin_bool,
  margin              .initial:n    = { false },
  slide               .bool_gset:N  = \g__zlatex_slide_bool,
  slide               .initial:n    = { false },
  aspect              .tl_gset:N    = \g__zlatex_aspectratio_tl,
  aspect              .initial:n    = { 12|9 },
}
\zlatex_define:nn {mathSpec}{
  alias               .bool_gset:N  = \g__zlatex_math_alias_bool,
  alias               .initial:n    = { false },
  envStyle            .tl_gset:N    = \g__zlatex_math_env_style_tl,
  envStyle            .initial:n    = { plain },
  font                .choice:,
  font / newtx        .code:n       = { \zlatex_load_after:n { \RequirePackage{newtxmath} } },
  font / mtpro2       .code:n       = { \zlatex_load_after:n { \RequirePackage[lite, subscriptcorrection, slantedGreek, nofontinfo]{mtpro2} } },
  font / euler        .code:n       = { \zlatex_load_after:n { \RequirePackage[OT1, euler-digits]{eulervm} } },
  font / mathpazo     .code:n       = { \let\rmbefore\rmdefault\zlatex_load_after:n { \RequirePackage{mathpazo} } \let\rmdefault\rmbefore},
  font / unknown      .code:n       = {
    \msg_new:nnn {zlatex}{option-mathfont}{Current~math~font~option~is~:~'#1'~,default~math-font~substitute.}
    \msg_warning:nn {zlatex}{option-mathfont}
  },
}
\zlatex_define:nn {font}{ }
\zlatex_define:nn {bib}{
  source              .str_gset:N   =  \g__zlatex_bib_source_str,
  source              .initial:n    =  { ref.bib },
  backend             .str_gset:N   =  \g__zlatex_bib_backend_str,
  backend             .initial:n    =  { biber },
}

% option setup
\ProcessKeysOptions {zlatex / option}

% handle fancy option
\newif\ifloadtikz
\bool_if:NTF \g__zlatex_fancy_bool {
  \RequirePackage[many]{tcolorbox}
  \loadtikztrue
}{\loadtikzfalse}
\ExplSyntaxOff\ifloadtikz
  \RequirePackage{tikz}
  \usetikzlibrary{calc}
\fi\ExplSyntaxOn
\NewDocumentCommand{\zlatexSetup}{m}{
  \zlatex_set:nn {option}{#1}
}

% pass clist options main subclass: 'article', 'book', 'ctexbook'
\str_case:VnF \g__zlatex_subclass_type_str {
  {article}{
    \PassOptionsToClass{\g__zlatex_subclass_option_clist}{ article }
    \LoadClass{article}
  }
  {book}{
    \PassOptionsToClass{\g__zlatex_subclass_option_clist}{ book }
    \LoadClass{book}   
  }
  {ctexbook}{
    \str_set:Nn \g__zlatex_lang_str {cn}
    \PassOptionsToClass{\g__zlatex_subclass_option_clist}{ ctexbook }
    \PassOptionsToPackage{quiet}{fontspec}
    \LoadClass{ctexbook}    
  }
}{\relax}

% baisc document class and packages option
\msg_new:nnn {zlatex}{compile-engine-pdftex}{Current~compile~engine~is~XETEX,~use~PDFTEX~instead.}
\msg_new:nnn {zlatex}{compile-engine-xetex }{Current~compile~engine~is~PDFTEX,~use~XETEX~instead.}
\str_case:VnF \g__zlatex_lang_str {
  {en} { 
    \sys_if_engine_xetex:TF 
      {\msg_warning:nn {zlatex}{compile-engine-pdftex}}
      {\RequirePackage[utf8]{inputenc}}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[english]{babel}
    \RequirePackage{microtype}
  }
  {cn} {
    \sys_if_engine_xetex:TF {}{\msg_error:nn {zlatex}{compile-engine-xetex}}
    \PassOptionsToPackage{quiet}{fontspec}
    \PassOptionsToPackage{no-math}{fontspec}
    \str_if_eq:VnF \g__zlatex_subclass_type_str {ctexbook}{
      \RequirePackage[UTF8, heading]{ctex}
      \linespread{1.3}
    }
  }
}{\msg_error:nn {zlatex}{option-language}}   




% ----------------------------------------------------------------------
%                               Page Layout 
% ----------------------------------------------------------------------
\RequirePackage{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{framed}
\RequirePackage{xcolor}
% page layout 
% document mode
\if@twoside 
  \geometry{a4paper, left=3cm, right=5.5cm, bottom=3.5cm, footskip=1.5cm, marginparsep=1em}
  \bool_if:NTF \g__zlatex_margin_bool {
    \geometry{a4paper, left=2.5cm, right=7.5cm, bottom=3.5cm, footskip=1.5cm, marginparsep=2em}
    \dim_gset:Nn \marginparwidth{14em}
  }{
    \msg_new:nnn {zlatex}{option-page-margin}{No~margin~option~is~only~accessible~in~oneside~layout,~margin~option~is~now~enabled~by~default.} 
    \msg_warning:nn {zlatex}{option-page-margin}
  }
\else 
  \bool_if:NTF \g__zlatex_margin_bool {
    \geometry{a4paper, left=2.5cm, right=7.5cm, bottom=3.5cm, footskip=1.5cm, marginparsep=2em}
    \dim_gset:Nn \marginparwidth{14em}
  }{
    \geometry{a4paper, left=3cm, right=3cm, bottom=3.5cm, footskip=1.5cm, marginparsep=1em}
    \renewcommand{\marginpar}[1]{\leftbar\noindent#1\endleftbar}
  }
\fi
% slide mode (only in 'oneside' mode)
\exp_args:NNnx \seq_set_split:Nnn \l_tmpa_seq {|}{\g__zlatex_aspectratio_tl}
\bool_if:NTF \g__zlatex_slide_bool {
  \RequirePackage{lastpage}
  \definecolor{slideRed}{HTML}{a30000}
  \definecolor{slideGray}{HTML}{e0e0e0}
  \definecolor{slideWhite}{HTML}{f0f0f0}
  % hook shipout
  \RequirePackage{eso-pic}
  \AddToShipoutPictureBG {
    \AtPageUpperLeft {
      \textcolor{slideRed}{\rule[-1.25em]{.5\paperwidth}{1.25em}}
      \textcolor{slideGray}{\rule[-1.25em]{.5\paperwidth}{1.25em}}
    }
    \AtPageLowerLeft {
      \textcolor{slideRed}{\rule{.35\paperwidth}{1.25em}}
      \textcolor{slideWhite}{\rule{.3\paperwidth}{1.25em}}
      \textcolor{slideGray}{\rule{.35\paperwidth}{1.25em}}
    }
  }
  % layout and mark
  \RequirePackage{titling}
  \IfClassLoadedTF{book}{
    \renewcommand\chaptermark[1]{\markboth{#1}{}}
  }{\relax}
  \renewcommand\sectionmark[1]{\markboth{#1}{}}
  \geometry {
    papersize={\seq_item:Nn \l_tmpa_seq {1}cm, \seq_item:Nn \l_tmpa_seq {2}cm},
    hmargin=1cm,
    vmargin=.65cm,
    head=0.52cm,
    foot=12pt,
    headsep=5pt,
    footskip=15pt
  }
  % init slide mode
  \zlatex_load_after:n {\pagestyle{fancy}}
}{\relax}

% fancy page settings
\cs_if_exist_use:NF \theauthor{
  \newcommand{\theauthor}{}
  \newcommand{\thetitle}{}
  \newcommand{\thedate}{}
}
\fancypagestyle{fancy}{
  \fancyhf{}  
  \dim_gset:Nn \headheight{15pt}
  \renewcommand{\headrule}{\hrule width\textwidth}
  % slide mode
  \bool_if:NTF \g__zlatex_slide_bool {
    \def\headrule{}
    \fancyhead[L]{\hbox to .42\paperwidth{\hss\sffamily\textcolor{white}{Section \ \thesection}\;}}
    \fancyhead[R]{\hbox to .42\paperwidth{\;\sffamily\textcolor{slideRed}{\leftmark}\hss}}
    \fancyfoot[L]{\sffamily\textcolor{white}{\theauthor}}
    \fancyfoot[C]{\sffamily\textcolor{slideRed}{\thetitle}}
    \fancyfoot[R]{\sffamily\textcolor{slideRed}{\hbox to .25\paperwidth{\hfill\thedate\kern2.5em\thepage/\pageref{LastPage}}}}
  }{
  % doc mode
    \if@twoside
      \fancyhead[EL]{\leftmark}
      \fancyhead[ER]{\thepage}
      \fancyhead[OL]{\thepage}
      \fancyhead[OR]{\rightmark}
    \else
      \IfClassLoadedTF{book}{
        \fancyhead[L]{\thepage}
        \fancyhead[R]{\rightmark}
      }{
        \fancyhead[L]{\thepage}
        \fancyhead[R]{\leftmark}
      }
    \fi
  }
}
\fancypagestyle{plain}{
  \fancyhf{}  
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\headrule}{}
  \fancyfoot[C]{\thepage}
}

% front and main matter cmds in book class
\IfClassLoadedTF{book}{
  \renewcommand\frontmatter{
    \cleardoublepage
    \pagestyle{plain}
    \@mainmatterfalse
    \pagenumbering{Roman}
  }
  \renewcommand\mainmatter{
    \cleardoublepage
    \pagestyle{fancy}
    \@mainmattertrue
    \pagenumbering{arabic}
  }
}{\relax}





% ----------------------------------------------------------------------
%                        Math package and hyperref
% ----------------------------------------------------------------------
\RequirePackage{amsfonts, amsmath}          
\RequirePackage{amsthm}
\RequirePackage{esint}             
\str_case:VnF \g__zlatex_bib_backend_str {
  {bibtex}{\RequirePackage[backend=bibtex]{biblatex}}
  {biber}{\RequirePackage[backend=biber]{biblatex}}
}{\relax}
\exp_args:Nx \addbibresource{\str_use:N \g__zlatex_bib_source_str}
\RequirePackage{indextools}
\bool_if:NTF \g__zlatex_hyperref_bool {
  \RequirePackage{hyperref}
}{\relax}
\RequirePackage[nameinlink]{cleveref}

% figure and table prefix for \cref 
\str_case:VnF \g__zlatex_lang_str {
  {en}{
    \IfClassLoadedTF{book}{
      \crefname{part}{part}{parts}
      \crefname{chapter}{chapter}{chapters}
    }{\relax}
    \crefname{section}{section}{sections}
    \crefname{subsection}{subsection}{subsections}
    \crefname{figure}{figure}{figures}
    \crefname{table}{table}{tables}
    \crefname{equation}{equation}{equations}
  }
  {cn}{
    \IfClassLoadedTF{book}{
      \crefname{part}{部分}{部分}
      \crefname{chapter}{章}{章}
    }{\relax}
    \crefname{section}{节}{节}
    \crefname{subsection}{小节}{小节}
    \crefname{figure}{图}{图}
    \crefname{table}{表}{表}
    \crefname{equation}{方程}{方程}
  }
}{\msg_error:nn {zlatex}{option-language}}





% ----------------------------------------------------------------------
%                           Math Environments 
% ----------------------------------------------------------------------
% pre-defined color
\definecolor{mathaxiomColor}{HTML}{000000}
\definecolor{mathdefinitionColor}{HTML}{bdc3c7}
\definecolor{maththeoremColor}{HTML}{27ae60}
\definecolor{mathlemmaColor}{HTML}{2980b9}
\definecolor{mathcorollaryColor}{HTML}{8e44ad}
\definecolor{mathpropositionColor}{HTML}{f39c12}
\definecolor{mathremarkColor}{HTML}{c92a2a}
\definecolor{RoyalRed}{RGB}{157,16, 45}
\definecolor{zchapColor}{HTML}{7f8184}

% color spec for zlatex
\zlatex_define:nn {color}{
  % structure color
  link            .tl_set:N     =  \l__zlatex_link_color_tl,
  link            .initial:n    =  { purple },
  cite            .tl_set:N     =  \l__zlatex_cite_color_tl,
  cite            .initial:n    =  { blue },
  url             .tl_set:N     =  \l__zlatex_url_color_tl,
  url             .initial:n    =  { RoyalRed  },
  chapter         .tl_set:N     =  \l__zlatex_chapter_color_tl,
  chapter         .initial:n    =  { RoyalRed },  
  chapter-rule    .tl_set:N     =  \l__zlatex_chapter_rule_color_tl,
  chapter-rule    .initial:n    =  { black },
  % math envs      color
  axiom           .tl_set:N     =  \l__zlatex_axiom_color_tl,
  axiom           .initial:n    =  { mathaxiomColor },
  definition      .tl_set:N     =  \l__zlatex_definition_color_tl,
  definition      .initial:n    =  { mathdefinitionColor },
  theorem         .tl_set:N     =  \l__zlatex_theorem_color_tl,
  theorem         .initial:n    =  { maththeoremColor },
  lemma           .tl_set:N     =  \l__zlatex_lemma_color_tl,
  lemma           .initial:n    =  { mathlemmaColor },
  corollary       .tl_set:N     =  \l__zlatex_corollary_color_tl,
  corollary       .initial:n    =  { mathcorollaryColor },
  proposition     .tl_set:N     =  \l__zlatex_proposition_color_tl,
  proposition     .initial:n    =  { mathpropositionColor },
  remark          .tl_set:N     =  \l__zlatex_remark_color_tl,
  remark          .initial:n    =  { mathremarkColor },
}
\NewDocumentCommand{\zlatexColorSetup}{m}{
  \zlatex_set:nn {color}{#1}
  \bool_if:NTF \g__zlatex_hyperref_bool {
    \hypersetup{
      colorlinks = true,
      urlcolor   = \tl_use:N \l__zlatex_url_color_tl,
      linkcolor  = \tl_use:N \l__zlatex_link_color_tl,
      citecolor  = \tl_use:N \l__zlatex_cite_color_tl,
    }
  }{\relax}
}
\zlatexColorSetup{link=purple, cite=blue, url=RoyalRed}

% framed env for user interface
\cs_new_protected:Npn \zlatexFramed:nn #1#2 {
  \DeclareDocumentEnvironment{#1}{O{#2}}{
    \def\FrameCommand{{\color{##1}\vrule width 3pt}\colorbox{##1!10}}
    \MakeFramed{\advance\hsize-\width\FrameRestore}\noindent   
  }{\endMakeFramed}
}
\NewDocumentCommand\zlatexFramed{mO{black}}{
  \zlatexFramed:nn {#1}{#2}
}

% theorem/proof-like envs list 
\clist_gset:Nn \g__zlatex_theoremlike_envs_clist  { 
  axiom, definition, theorem, 
  lemma, corollary,  proposition, remark 
}
\clist_gset:Nn \g__zlatex_prooflike_envs_clist  { 
  proof,    exercise, example, 
  solution, problem,  
}

% math envs' name accrodingt to language
\msg_new:nnn {zlatex}{mathenv-name}{Current~math~env~name~is~:~'#1'~,which~is-invalid.}
\str_case:VnTF \g__zlatex_lang_str { 
  {en}{
    \zlatex_define:nn {math-env}{
      math-env                .multichoice:,
      math-env / axiom        .code:n = { \tl_gset:cn {zlatex#1Name}{Axiom} },
      math-env / definition   .code:n = { \tl_gset:cn {zlatex#1Name}{Definition} },
      math-env / theorem      .code:n = { \tl_gset:cn {zlatex#1Name}{Theorem} },
      math-env / lemma        .code:n = { \tl_gset:cn {zlatex#1Name}{Lemma} },
      math-env / corollary    .code:n = { \tl_gset:cn {zlatex#1Name}{Corollary} },
      math-env / proposition  .code:n = { \tl_gset:cn {zlatex#1Name}{Proposition} },
      math-env / remark       .code:n = { \tl_gset:cn {zlatex#1Name}{Remark} },
      math-env / proof        .code:n = { \tl_gset:cn {zlatex#1Name}{Proof} },
      math-env / exercise     .code:n = { \tl_gset:cn {zlatex#1Name}{Exercise} },
      math-env / example      .code:n = { \tl_gset:cn {zlatex#1Name}{Example} },
      math-env / solution     .code:n = { \tl_gset:cn {zlatex#1Name}{Solution} },
      math-env / problem      .code:n = { \tl_gset:cn {zlatex#1Name}{Problem} },
      math-enc / unknown      .code:n = {
        \msg_error:nn {zlatex}{mathenv-name}
      },
    }
  }
  {cn}{
    \zlatex_define:nn {math-env}{
      math-env                .multichoice:,
      math-env / axiom        .code:n = { \tl_gset:cn {zlatex#1Name}{公理} },
      math-env / definition   .code:n = { \tl_gset:cn {zlatex#1Name}{定义} },
      math-env / theorem      .code:n = { \tl_gset:cn {zlatex#1Name}{定理} },
      math-env / lemma        .code:n = { \tl_gset:cn {zlatex#1Name}{引理} },
      math-env / corollary    .code:n = { \tl_gset:cn {zlatex#1Name}{推论} },
      math-env / proposition  .code:n = { \tl_gset:cn {zlatex#1Name}{命题} },
      math-env / remark       .code:n = { \tl_gset:cn {zlatex#1Name}{注记} },
      math-env / proof        .code:n = { \tl_gset:cn {zlatex#1Name}{证明} },
      math-env / exercise     .code:n = { \tl_gset:cn {zlatex#1Name}{练习} },
      math-env / example      .code:n = { \tl_gset:cn {zlatex#1Name}{示例} },
      math-env / solution     .code:n = { \tl_gset:cn {zlatex#1Name}{解} },
      math-env / problem      .code:n = { \tl_gset:cn {zlatex#1Name}{问题} },
      math-enc / unknown      .code:n = {
        \msg_error:nn {zlatex}{mathenv-name}
      },
    }
  }
}{\zlatex_set:nn {math-env}{math-env={axiom, definition, theorem, lemma, corollary, proposition, remark, proof, exercise, example, solution, problem}}}
{\msg_error:nn {zlatex}{option-lang}}

% math env's style
\newtheoremstyle{zlatexMathEnv}
  {2pt}{2pt}{}
  {0pt}{\bfseries}{}
  {.25em}{\thmname{#1}~ \thmnumber{#2}~ \thmnote{(#3)}}
\theoremstyle{zlatexMathEnv}

% theorem-like env declaration
\msg_new:nnn {zlatex}{mathenv-type}{Current~math~env~is~:~'\str_use:N \g__zlatex_math_env_style_tl'~,only~'plain',~'leftbar',~'background',~'fancy'~types~are-valid.}
\NewDocumentCommand{\zlatexMathEnvStyle}{m}{
  \tl_gset:Nn \g__zlatex_math_env_style_tl {#1}
}
\str_if_eq:VnT \g__zlatex_math_env_style_tl{shadow}{
  \@ifpackageloaded{tcolorbox}{\relax}{
    \RequirePackage[many]{tcolorbox}
  }
}
\DeclareDocumentEnvironment{zlatexTheoremLikeFrame}{O{axiom}}{
  \def\TempColor{\tl_use:c {l__zlatex_#1_color_tl}}
  \typeout{TempColor: \TempColor}
  \str_case:VnF \g__zlatex_math_env_style_tl {
    {plain}{  
      \def\FrameCommand{}
      \MakeFramed {\advance\hsize-\width \FrameRestore}
    }
    {leftbar}{
      \def\FrameCommand{{\color{\TempColor}\vrule width 3pt}\hspace{5pt}}
      \MakeFramed {\advance\hsize-\width \FrameRestore}
    }
    {background}{
      \def\FrameCommand{\colorbox{\TempColor!10}}
      \MakeFramed {\advance\hsize-\width \FrameRestore}
    }
    {fancy}{
      \def\FrameCommand{{\color{\TempColor}\vrule width 3pt}\colorbox{\TempColor!10}}
      \MakeFramed{\advance\hsize-\width \FrameRestore}
    }
    {shadow}{
      \begin{tcolorbox}[
        top=1.5pt,
        bottom=1.5pt,
        left=3pt,
        right=3pt,
        boxrule=0pt,
        sharp~ corners,
        enhanced~ jigsaw,
        drop~ fuzzy~ shadow,
        breakable,
        colback={\TempColor!10}, 
        borderline~ west={3pt}{0pt}{\TempColor}
      ]
    }
  }{\msg_error:nn {zlatex}{mathenv-type}}
}{
  \str_case:VnF \g__zlatex_math_env_style_tl {
    {shadow}{\end{tcolorbox}}
    {plain}{\endMakeFramed}
    {leftbar}{\endMakeFramed}
    {background}{\endMakeFramed}
    {fancy}{\endMakeFramed}
  }{\msg_error:nn {zlatex}{mathenv-type}}
}

% loop to create math env, setup \cref
\clist_map_inline:Nn \g__zlatex_theoremlike_envs_clist {
  % theorem create
  \newtheorem{zlatex#1}{\tl_use:c {zlatex#1Name}}[section]

  % env create (3 types: 'leftbar', 'none' and 'backgroud')
  \NewDocumentEnvironment{#1}{O{}}{
    \begin{zlatexTheoremLikeFrame}[#1]
    \begin{zlatex#1}[##1]
  }{\end{zlatex#1}\end{zlatexTheoremLikeFrame}}

  % cref settings
  \cs_generate_variant:Nn \exp_args:Nnnx {Nxxx}
  \str_case:VnF \g__zlatex_lang_str {
    {en}{
      \crefname{zlatex#1}{#1}{#1s}
      \creflabelformat{zlatex#1}{##2(##1)##3}
    }
    {cn}{
      \exp_args:Nxxx \crefname{zlatex#1}{\tl_use:c {zlatex#1Name}}{\tl_use:c {zlatex#1Name}}
      \creflabelformat{zlatex#1}{##2(##1)##3}
    }
  }{\msg_error:nn {zlatex}{option-lang}}
}

% proof-like env decalration
\NewDocumentEnvironment{zlatexProofLikeFrame}{O{}}{
  \def\FrameCommand{}
  \MakeFramed {\advance\hsize-\width \FrameRestore}
}{\endMakeFramed}
\renewcommand{\qedsymbol}{\ensuremath{\blacksquare}}
\clist_map_inline:Nn \g__zlatex_prooflike_envs_clist{
  \DeclareDocumentEnvironment{#1}{O{}}{
    \begin{zlatexProofLikeFrame}[]
    {\noindent{\bfseries\tl_use:c {zlatex#1Name}:}}
    \tl_set:Nn \l__arg_one_tl {#1}
  }{\str_if_eq:VnTF \l__arg_one_tl{proof}{\hfill\qedsymbol\par}{\par}\end{zlatexProofLikeFrame}}
}

% equation number style
\counterwithin{equation}{section}

% math related cmds alias
\bool_if:NTF \g__zlatex_math_alias_bool{
  \RequirePackage{amssymb, mathtools}
  \RequirePackage{bm}          
  % Math Font 
  \newcommand{\dd}{\mathrm{d}}
  \newcommand{\C}[1]{\ensuremath{\mathcal{#1}}}
  \let\ss\S
  \renewcommand{\S}[1]{\ensuremath{\mathscr{#1}}}
  \newcommand{\B}[1]{\ensuremath{\mathbb{#1}}}
  \newcommand{\FF}[1]{\ensuremath{\mathbf{#1}}}
  \newcommand{\F}[1]{\ensuremath{\bm{#1}}}
  \newcommand{\R}[1]{\ensuremath{\mathrm{#1}}}
  \newcommand{\K}[1]{\ensuremath{\mathfrak{#1}}}
  % Math Arrow 
  \newcommand{\lr}{\ensuremath{\longrightarrow}}
  \let\LL\ll
  \renewcommand{\ll}{\ensuremath{\longleftarrow}}
  \newcommand{\equ}{\ensuremath{\Longleftrightarrow}\,}
  \newcommand{\sr}{\ensuremath{\longmapsto}}
  \newcommand{\lrr}[2][]{\ensuremath{\xRightarrow[#1]{#2}}}
  \renewcommand{\lll}[2][]{\ensuremath{\xLeftarrow[#1]{#2}}}
  \newcommand{\ns}{\ensuremath{\varnothing}}
  \newcommand{\A}{\ensuremath{\forall}}
  % Math Operator
  \newcommand{\alt}{\ensuremath{\mathrm{Alt}\;}}
  \newcommand{\sgn}{\ensuremath{\mathrm{sgn}\;}}
  \newcommand{\curl}{\ensuremath{\mathrm{curl}\;}}
  \newcommand{\grad}{\ensuremath{\mathrm{grad}\;}}
  \newcommand{\trace}{\ensuremath{\mathrm{trace}\;}}
  \renewcommand{\div}{\ensuremath{\mathrm{div}\;}}
}{}





% ----------------------------------------------------------------------
%                          Graphics and Item  
% ----------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{sidenotes}
\graphicspath{
  {./figure/}{./figures/}{./image/}{./images/}
  {./Pictures/}{./picture/}{./Pics/}{./pics/}
  {./graphics/}{./graphic/}
}
\renewcommand{\labelitemii}{\(\circ\)}
\renewcommand{\labelitemiii}{\(\diamond\)}





% ----------------------------------------------------------------------
%                        ToC, Titles and Cover Style
% ----------------------------------------------------------------------
% partial ToC
\RequirePackage{titletoc}
\NewDocumentCommand\stopPartToc{mm}{
  \int_compare:nNnTF {#2}<{1}
    {\relax}{\stopcontents[#1]}
}
\NewDocumentCommand{\partialToc}{O{2}}{
  % depth setup
  \setcounter{tocdepth}{#1} 
  \titlecontents{psection}[2em]
    {} {\contentslabel{2em}} {} {\titlerule*[1pc]{.}\contentspage}
  \titlecontents{psubsection}[4.5em]
    {} {\contentslabel{2.5em}} {} {\titlerule*[1pc]{.}\contentspage}
  \titlecontents{psubsubsection}[5.5em]
    {} {\contentslabel{0em}} {} {\titlerule*[1pc]{.}\contentspage}
  % print pToc
  \IfClassLoadedTF{book}{ 
    \startcontents[chapters]
    \printcontents[chapters]{p}{1}{}
    \pretocmd{\chapter}{
      \stopPartToc{chapters}{\thechapter}
    }{}{}
  }{
    \startcontents[sections]
    \printcontents[sections]{p}{1}{}
    \pretocmd{\section}{
      \stopPartToc{sections}{\thesection}
    }{}{}
  }
}

% chapter head style
\IfClassLoadedTF{book}{
  \newif\ifFancyChapter
  \bool_if:NTF \g__zlatex_fancy_bool {
    \RequirePackage[explicit]{titlesec}
    \FancyChaptertrue
    % numbered chapter format
    \makeatletter
    \titleformat{\chapter}[display]
    {\normalfont\huge\sffamily}{}
    {20pt}{
    \begin{tikzpicture}[overlay, remember~ picture]%
      % mark nodes (need 'calc' library)
      \coordinate (A) at ($(current~ page.north~ west)+(.125\paperwidth, 0pt)$);
      \coordinate (stripES) at ($(A)+(3em, -.25\paperheight)$);
      % chapter head
      \fill[zchapColor] (A) rectangle (stripES);
      \draw[draw=zchapColor] (stripES)++(.25em, 4em)   -- ++(.75\paperwidth-3.25em, 0pt);
      \draw[draw=zchapColor] (stripES)++(.25em, 1.5pt) -- ++(.75\paperwidth-3.25em, 0pt);
      \draw[draw=zchapColor] (stripES)++(.25em, 0em)   -- ++(.75\paperwidth-3.25em, 0pt);
      % chapter title and index
      \node[anchor=south, color=white] at ($(stripES)+(-1.5em, 0em)$)
        {\normalfont\normalsize\scalebox{4}{\thechapter}\Suffixnum{\thechapter}};
      \node[anchor=south~ west, inner~ sep=0pt, 
            yshift=4.25em, xshift=.25em, 
            font=\Large\bfseries, color=zchapColor
        ] at (stripES) {\z@subtitle};
      \node[anchor=south~ west, inner~ sep=0pt,
            yshift=1.5em, xshift=.25em,
            font=\Cinzel\Huge\bfseries, color=zchapColor
        ] at (stripES) {#1};
      % parbox insert
      \node[anchor=north~ west, inner~ sep=0pt] at ($(stripES)+(-3em, -1em)$){
        \parbox[t]{.3\paperwidth}{\normalfont\fontsize{10pt}{15pt}
          \selectfont\Cinzel\itshape\z@leftContent}
      };
      \node[anchor=north~ west, inner~ sep=0pt] at ($(stripES)+(-3em+.45em+.3\paperwidth, -1em)$){
        \parbox[t]{\dimeval{.45\paperwidth-.45em}}{
          \normalfont\fontsize{10pt}{15pt}\selectfont\z@rightContent}
      };
      % saying block
      \coordinate (sayingWN) at ($(current~ page.south~ west)+(0, .3\paperheight)$); 
      \shade[top~ color=white, bottom~ color=zchapColor!25] (sayingWN) 
        rectangle ++(1\paperwidth, 5pt);
      \shade[top~ color=zchapColor!25, bottom~ color=white] ($(sayingWN)+(0em, -.15\paperheight)$) 
        rectangle ++(1\paperwidth, -5pt);
      \node at ($(sayingWN)+(.5\paperwidth, -0.075\paperheight)$) {
        \parbox[t][][r]{.75\paperwidth}{\normalfont\fontsize{15pt}{22.5pt}\selectfont
          \MakeUppercase{\Cinzel\z@saying\\\hspace*{\fill}{\itshape\normalsize\z@sayauthor}}}
      };
    \end{tikzpicture}}[\thispagestyle{empty}\clearpage]
    \makeatother
    % unnumbered chapter format
    \titleformat{name=\chapter, numberless}
      {\normalfont\bfseries\Huge}
      {}{0pt}{#1}
  }{
    \RequirePackage{titlesec}
    \FancyChapterfalse
    % numbered chapter format
    \titleformat{\chapter}[display]
      {\bfseries\huge\color{black}}
      {\flushright\Large\color{\tl_use:N \l__zlatex_chapter_color_tl}
      \MakeUppercase{\chaptertitlename}\hspace{1ex}
      {\scalebox{4}{\thechapter}}}
      {10pt}
      {\color{\tl_use:N \l__zlatex_chapter_rule_color_tl}\titlerule\vspace{1ex}}
    % unnumbered chapter format
    \titleformat{name=\chapter, numberless}
      {\normalfont\bfseries\Huge}
      {}{0pt}{}
  }
  % chapter space
  \titlespacing{\chapter}{0pt}{-30pt}{40pt}
}{\relax}

% find number suffix: 1 -> st, 2 -> nd, ...
\tl_const:Nn \c_numSufix_i {st}
\tl_const:Nn \c_numSufix_ii {nd}
\tl_const:Nn \c_numSufix_iii {rd}
\tl_const:Nn \c_numSufix_ {th}
\clist_const:Nn \c_numSpecialSufix_clist {11, 12, 13}
\NewDocumentCommand\Suffixnum{m}{
  \clist_if_in:NnTF \c_numSpecialSufix_clist {#1}
  {th}{
    \int_compare:nNnTF {\int_mod:nn {#1}{10}}{>}{3}
    {th}
    {\tl_use:c {c_numSufix_\int_to_roman:n {\int_mod:nn {#1}{10}}}}
  }
}

% fancy chapter default material
\ExplSyntaxOff
\makeatletter
\ifFancyChapter
  % default settings
  \newcommand{\z@subtitle}{An Introduction to Mathematical Logic}
  \newcommand{\z@saying}{Mathematical logic has always been closely connected with the philosophy of mathematics.}
  \newcommand{\z@sayauthor}{-- Joseph R. Shoenfield}
  \newcommand{\z@leftContent}{
    \includegraphics[width=1\linewidth]{example-image-duck}\\[.5em]
    We add two words of caution. First, if two different syntactical variables
    occur in the same context, they do not necessarily represent different expressions.
  }
  \newcommand{\z@rightContent}{
    Logic is the study of reasoning; and mathematical logic is the study of the 
    type of reasoning done by mathematicians. To discover the proper approach to 
    mathematical logic, we must therefore examine the methods of the mathematician.\\
    The conspicuous feature of mathematics, as opposed to other sciences, is
    the use of proofs instead of observations. A physicist may prove physical laws
    from other physical laws; but he usually regards agreement with observation as
    the ultimate test of a physical law. A mathematician may, on occasions, use
    observation; for example, he may measure the angles of many triangles and
    conclude that the sum of the angles is always 180$^\circ$. However, he will 
    accept this as a law of mathematics only when it has been proved.
  }
  % users' interface
  \NewDocumentCommand{\zsubtitle}{m}{
    \renewcommand\z@subtitle{#1}
  }
  \NewDocumentCommand{\zchapterSaying}{O{}m}{
    \renewcommand\z@saying{#2}
    \renewcommand\z@sayauthor{#1}
  }
  \NewDocumentCommand{\zchapterLContent}{m}{
    \renewcommand\z@leftContent{#1}
  }
  \NewDocumentCommand{\zchapterRContent}{m}{
    \renewcommand\z@rightContent{#1}
  }
\else 
  \NewDocumentCommand{\zsubtitle}{m}{\relax}
  \NewDocumentCommand{\zchapterSaying}{O{}m}{\relax}
  \NewDocumentCommand{\zchapterLContent}{m}{\relax}
  \NewDocumentCommand{\zchapterRContent}{m}{\relax}
\fi
\makeatother
\ExplSyntaxOn

% title page
\let\orimaketitle\maketitle
\def\Maketitle{
  \newgeometry{margin=1in}
  \orimaketitle
  \restoregeometry
}
\makeatletter
\bool_if:NTF \g__zlatex_slide_bool {
  \let\orithepage\thepage
  \renewcommand\maketitle{
    \Maketitle
    \def\thepage{}
    \setcounter{page}{0}
    \newpage
    \let\thepage\orithepage
  }
}{
  \renewcommand{\maketitle}{
    \bool_if:NTF \g__zlatex_hyperref_bool {\hypersetup{pageanchor=false}}{\relax}
    \newgeometry{margin=1in}
    \begin{titlepage}
      \vfill\vspace*{40pt}
      \noindent\hspace*{134pt}\rule[-75pt]{6pt}{95pt}
      {\hspace*{10pt}\leavevmode\parbox[t]{25em}{\fontsize{25}{25}\selectfont\bfseries\@title}}\par
      \vspace*{-15pt}
      \noindent\hspace*{150pt}{\leavevmode\parbox[t]{30em}{\Large\bfseries\@author}}\par
      \vfill
      \noindent\hspace*{150pt}{\Large\textcolor{gray}{\@date}}
    \end{titlepage}
    \restoregeometry
    \bool_if:NTF \g__zlatex_hyperref_bool {\hypersetup{pageanchor=true}}{\relax}
  }
} 
\makeatother

% reset counter command
\NewDocumentCommand{\zlatexCounterWith}{mm}{\@addtoreset{#1}{#2}}





% ----------------------------------------------------------------------
%                           Optional commands
% ----------------------------------------------------------------------
% zlatex class options debug
\newcommand{\zlatexOptions}{
  \textbf{Class~Options:}~
  \str_use:N \g__zlatex_lang_str~-~
  \clist_use:Nn \g__zlatex_subclass_option_clist{~-~}
  \par
}
% verbatim cs ('F' to remove space)
\NewDocumentCommand{\zlatexVerb}{O{T}m}{
  \str_set:Nn \l_tmpa_str { #2 } 
  \tl_if_eq:nnT {#1}{F}{
    \str_replace_all:Nnn \l_tmpa_str {~}{} 
  }
  \texttt{\l_tmpa_str}
}