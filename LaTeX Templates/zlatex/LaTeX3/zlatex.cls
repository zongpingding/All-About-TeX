\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}





% ----------------------------------------------------------------------
%                       zlatex document class Metadata
% ----------------------------------------------------------------------
\ExplSyntaxOn
\tl_const:Nn \c__zlatex_class_name_tl            {zlatex}
\tl_const:Nn \c__zlatex_class_version_tl         {0.5}
\tl_const:Nn \c__zlatex_class_date_tl            {2024/04/16}
\tl_const:Nn \c__zlatex_class_description_tl     {a~latex3~document~class}

\ProvidesExplClass{\c__zlatex_class_name_tl}         % Class
                  {\c__zlatex_class_date_tl}         % Date
                  {\c__zlatex_class_version_tl}      % Version
                  {\c__zlatex_class_description_tl}  % Description





% ----------------------------------------------------------------------
%                              Class Option 
% ----------------------------------------------------------------------
\RequirePackage {l3keys2e}
\cs_new_protected:Npn \zlatex_define_option:n
    { \keys_define:nn { zlatex / option } }
\cs_new_protected:Npn \zlatex_define:nn #1
    { \keys_define:nn { zlatex / #1} }
\cs_new_protected:Npn \zlatex_set:nn #1
    { \keys_set:nn { zlatex / #1 } }
\cs_new_protected:Npn \zlatex_load_after:n #1
  { \AtBeginDocument {#1} }

% setup option for class 
\zlatex_define_option:n {
    % language
    lang                  .str_gset:N   =  \g__zlatex_lang_str,
    lang                  .initial:n    =  { en },
    % page layout
    layout                .str_gset:N   =  \g__zlatex_layout_str,
    layout                .initial:n    =  { twoside },
    % margin option
    margin                .bool_gset:N  =  \g__zlatex_margin_bool,
    margin                .initial:n    =  { true },
    % font size
    font-size             .str_gset:N   =  \g__zlatex_fontsize_str,
    font-size             .initial:n    =  { 10pt },
    % math env type
    math-env-theme         .tl_gset:N    =  \g__zlatex_math_env_theme_tl,
    math-env-theme         .initial:n    =  { leftbar },
    % math alias
    math-alias            .bool_gset:N  =  \g__zlatex_math_alias_bool,
    math-alias            .initial:n    =  { false },
    % math-fonts
    math-font             .choice:,
    math-font / newtx     .code:n       =  { \zlatex_load_after:n { \RequirePackage{newtxmath} } },
    math-font / mtpro2    .code:n       =  { \zlatex_load_after:n { \RequirePackage[lite, subscriptcorrection, slantedGreek, nofontinfo]{mtpro2} } },
    math-font / euler     .code:n       =  { \zlatex_load_after:n { \RequirePackage[OT1, euler-digits]{eulervm} } },
    math-font / unknown   .code:n       =  {
        \msg_new:nnn {zlatex}{option-mathfont}{Current~math~font~option~is~:~'#1'~,default~math-font~substitute.}
        \msg_warning:nn {zlatex}{option-mathfont}
    },
    % bib source
    bib-source            .str_gset:N   =  \g__zlatex_bib_source_str,
    bib-source            .initial:n    = { ref.bib },
    % toc setting
    toc                   .multichoice:,
    toc / 2column         .code:n       =  { \zlatex_load_after:n { \RequirePackage[toc]{multitoc} } },
    toc / rename          .code:n       =  { 
        \str_case:Vn \g__zlatex_lang_str {
            {en}{ \zlatex_load_after:n {\renewcommand{\contentsname}{\hfill\bfseries\huge Contents \hfill}} }
            {cn}{ \zlatex_load_after:n {\renewcommand{\contentsname}{\hfill\bfseries\huge 目录     \hfill}} }
        }{}
    },
    toc / unknown         .code:n       =  {
        \msg_new:nnn {zlatex}{option-toc}{Current~toc~option~is~:~'#1'~,default~toc~settings~substitute.}
        \msg_warning:nn {zlatex}{option-toc}
    },
}
\ProcessKeysOptions {zlatex / option}

% pass a clist options to 'book' 
\clist_new:N \g__zlatex_book_options_clist
\clist_gput_right:Nx \g__zlatex_book_options_clist { \g__zlatex_layout_str, \g__zlatex_fontsize_str }

% setup messages for engin an language
\prop_gput:Nnn \g_msg_module_type_prop { zlatex } { Class }
\msg_new:nnn {zlatex}{compile-engine-pdftex}{Current~compile~engine~is~XETEX,~use~PDFTEX~instead.}
\msg_new:nnn {zlatex}{compile-engine-xetex }{Current~compile~engine~is~PDFTEX,~use~XETEX~instead.}
\msg_new:nnn {zlatex}{option-language}{Current~language~option~is:~'\g__zlatex_lang_str',~which~is~invalid.}

% baisc document class and packages option
\str_case:VnF \g__zlatex_lang_str{
    {en} { 
        \sys_if_engine_xetex:TF 
            {\msg_warning:nn {zlatex}{compile-engine-pdftex}}
            {\RequirePackage[utf8]{inputenc}}
        \LoadClass[\clist_use:Nn \g__zlatex_book_options_clist{,}]{book} 
        \RequirePackage[T1]{fontenc}
        \RequirePackage[english]{babel} 
    }
    {cn} {
        \sys_if_engine_xetex:TF {}{\msg_error:nn {zlatex}{compile-engine-xetex}}
        \PassOptionsToPackage{quiet}{fontspec}
        \PassOptionsToPackage{no-math}{fontspec}
        \LoadClass[\clist_use:Nn \g__zlatex_book_options_clist{,}]{book}
        % ctex should after 'book' class (or use 'scheme=plain', which chang nothing)
        \RequirePackage[UTF8, heading]{ctex}
        \linespread{1.3}
    }
}{\msg_error:nn {zlatex}{option-language}}   





% ----------------------------------------------------------------------
%                               Page Layout 
% ----------------------------------------------------------------------
\RequirePackage{framed}
\RequirePackage{geometry}
% page layout 
\str_case:VnF \g__zlatex_layout_str {
    {twoside}{
        \geometry{a4paper, left=3cm, right=5.5cm, bottom=3.5cm, footskip=1.5cm, marginparsep=1em}
        \bool_if:NTF \g__zlatex_margin_bool {}{
            \msg_new:nnn {zlatex}{option-page-margin}{No~margin~option~is~only~accessible~in~oneside~layout,~margin~option~is~now~enabled~by~default.} 
            \msg_warning:nn {zlatex}{option-page-margin}
        }
    }
    {oneside}{
        \bool_if:NTF \g__zlatex_margin_bool {
            \geometry{a4paper, left=3cm, right=5.5cm, bottom=3.5cm, footskip=1.5cm, marginparsep=1em}
            \dim_gset:Nn \marginparwidth{9.25em}
        }{
            \geometry{a4paper, left=3cm, right=3cm, bottom=3.5cm, footskip=1.5cm, marginparsep=1em}
            \renewcommand{\marginpar}[1]{\leftbar\noindent#1\endleftbar}
        }
    }
}{}

% fancy page settings
\RequirePackage{fancyhdr}
\fancypagestyle{fancy}{
    \fancyhf{}  
    \dim_gset:Nn \headheight{15pt}
    \renewcommand{\headrule}{\hrule width\textwidth}
    \msg_new:nnn {zlatex}{option-page-layout}{Current~page~layout~option~is~:'\clist_item:Nn \g__zlatex_book_options_clist{1}',~which~is~invalid.}
    \str_case:VnF \g__zlatex_layout_str{
        {twoside}{
            \fancyhead[EL]{\leftmark}
            \fancyhead[ER]{\thepage}
            \fancyhead[OL]{\thepage}
            \fancyhead[OR]{\rightmark}
        }
        {oneside}{
            \fancyhead[L]{\thepage}
            \fancyhead[R]{\rightmark}
        }
    }{\msg_error:nn {zlatex}{option-page-layout}}
}
\fancypagestyle{plain}{
    \fancyhf{}  
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\headrule}{}
    \fancyfoot[C]{\thepage}
}

% front and main matter cmds
\renewcommand\frontmatter{%
    \cleardoublepage
    \pagestyle{plain}
    \@mainmatterfalse
    \pagenumbering{Roman}
}
\renewcommand\mainmatter{%
    \cleardoublepage
    \pagestyle{fancy}
    \@mainmattertrue
    \pagenumbering{arabic}
}





% ----------------------------------------------------------------------
%                        Math package and hyperref
% ----------------------------------------------------------------------
\RequirePackage{amsfonts, amsmath}          
\RequirePackage{amsthm}             
\RequirePackage{xcolor}
\RequirePackage[backend=biber]{biblatex}
\exp_args:Nx \addbibresource{\str_use:N \g__zlatex_bib_source_str}
\RequirePackage{indextools}
\RequirePackage{hyperref}
\RequirePackage[nameinlink]{cleveref}

% figure and table prefix for \cref 
\str_case:VnF \g__zlatex_lang_str {
    {en}{
        \crefname{figure}{figure}{figures}
        \crefname{table}{table}{tables}
        \crefname{equation}{equation}{equations}
    }
    {cn}{
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
    % hyperref set up (may change in future)
    \hypersetup{
        colorlinks = true,
        urlcolor   = \tl_use:N \l__zlatex_url_color_tl,
        linkcolor  = \tl_use:N \l__zlatex_link_color_tl,
        citecolor  = \tl_use:N \l__zlatex_cite_color_tl,
    }
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
\msg_new:nnn {zlatex}{mathenv-lang}{Current~math~envs~language~option~is~:~'#1'~,which~is-invalid.~default~'en'~substitute.}
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
{\msg_error:nn {zlatex}{mathenv-lang}}

% math env's style
\newtheoremstyle{zlatexMathEnv}
    {2pt}{2pt}{}
    {0pt}{\bfseries}{}
    {.25em}{\thmname{#1}~ \thmnumber{#2}~ \thmnote{(#3)}}
\theoremstyle{zlatexMathEnv}

% theorem-like env declaration
\msg_new:nnn {zlatex}{mathenv-type}{Current~math~env~is~:~'#1'~,only~'none',~'leftbar',~'background'~types~are-valid.}
\str_case:VnF \g__zlatex_math_env_theme_tl {
    {none}{
        \NewDocumentEnvironment{zlatexTheoremLikeFrame}{O{}}{\vspace*{5pt}}{\vspace*{5pt}}
    }
    {leftbar}{
        \NewDocumentEnvironment{zlatexTheoremLikeFrame}{O{black}}{
            \def\FrameCommand{{\color{#1}\vrule width 3pt}\hspace{5pt}}
            \MakeFramed {\advance\hsize-\width \FrameRestore}
        }{\endMakeFramed}
    }
    {all}{
        \NewDocumentEnvironment{zlatexTheoremLikeFrame}{O{black}}{
            \def\FrameCommand{{\color{#1}\vrule width 3pt}\colorbox{#1!10}}
            \MakeFramed{\advance\hsize-\width \FrameRestore}
        }{\endMakeFramed}
    }
}{\msg_error:nn {zlatex}{mathenv-type}}

% loop to create math env, setup \cref
\clist_map_inline:Nn \g__zlatex_theoremlike_envs_clist {
    % theorem create
    \newtheorem{zlatex#1}{\tl_use:c {zlatex#1Name}}[section]

    % env create (3 types: 'leftbar', 'none' and 'backgroud')
    \NewDocumentEnvironment{#1}{O{}}{
        \begin{zlatexTheoremLikeFrame}[\tl_use:c {l__zlatex_#1_color_tl}]
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
    }{\msg_error:nn {zlatex}{mathenv-lang}}
}

% proof-like env decalration
\renewcommand{\qedsymbol}{\ensuremath{\blacksquare}}
\clist_map_inline:Nn \g__zlatex_prooflike_envs_clist{
    \DeclareDocumentEnvironment{#1}{O{}}{
        {\noindent{\bfseries\tl_use:c {zlatex#1Name}:}}
        \tl_set:Nn \l__arg_one_tl {#1}
    }{\str_if_eq:VnTF \l__arg_one_tl{proof}{\hfill\qedsymbol\par}{\par}}
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
\NewDocumentCommand{\partialToC}{O{}}{
    \setcounter{tocdepth}{2}  
    \titlecontents{psection}[2.3em]
        {} {\contentslabel{2.3em}} {} {\titlerule*[1pc]{.}\contentspage}
    \titlecontents{psubsection}[5em]
        {} {\contentslabel{3.2em}} {} {\titlerule*[1pc]{.}\contentspage}
    % print ToC
    \vspace*{-2em}
    \startcontents[chapters]
    \printcontents[chapters]{p}{1}{}
}

% chapter head style
\RequirePackage{titlesec}
\titleformat{\chapter}[display]
    {\bfseries\huge\color{black}}
    {\flushright\Large\color{\tl_use:N \l__zlatex_chapter_color_tl}
    \MakeUppercase{\chaptertitlename}\hspace{1ex}
    {\fontsize{60}{60}\selectfont\thechapter}}
    {10pt}
    {\color{\tl_use:N \l__zlatex_chapter_rule_color_tl}\titlerule\vspace{1ex}}
% chapter space
\titlespacing{\chapter}{0pt}{-30pt}{40pt}
\titleformat{name=\chapter, numberless}
    {\normalfont\bfseries\Huge}
    {}{0pt}{}

% title page
\renewcommand{\maketitle}{
\begin{titlepage}
    \vfill\vspace*{40pt}
    \noindent\hspace*{134pt}\rule[-75pt]{6pt}{95pt}{\hspace*{10pt}\leavevmode\parbox[t]{25em}{\fontsize{25}{25}\selectfont\bfseries\@title}}\par
    \vspace*{-15pt}
    \noindent\hspace*{150pt}{\leavevmode\parbox[t]{30em}{\Large\bfseries\@author}}\par
    \vfill
    \noindent\hspace*{150pt}{\Large\textcolor{gray}{\@date}}
\end{titlepage}} 

% reset counter command
\NewDocumentCommand{\zlatexUpdateCounterAfter}{mm}{\@addtoreset{#1}{#2}}





% ----------------------------------------------------------------------
%                           Optional commands
% ----------------------------------------------------------------------
% zlatex class options debug
\newcommand{\zlatexOptions}{
    \textbf{Class~Options:}~
    \str_use:N \g__zlatex_lang_str~-~
    \clist_use:Nn \g__zlatex_book_options_clist{~-~}
    \par
}
% write cmd verbatim to output
\NewDocumentCommand\zlatexVerb{m}{
    \texttt{\tl_to_str:n {#1}}
}