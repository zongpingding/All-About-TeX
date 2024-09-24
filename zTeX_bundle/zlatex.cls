\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}





% ----------------------------------------------------------------------
%                        zlatex Class Metadata
% ----------------------------------------------------------------------
\ExplSyntaxOn
\tl_const:Nn \c__zlatex_class_name_tl            {zlatex}
\tl_const:Nn \c__zlatex_class_version_tl         {1.1.0}
\tl_const:Nn \c__zlatex_class_date_tl            {2024/09/15}
\tl_const:Nn \c__zlatex_class_description_tl     {A~pre-release~latex3~document~class~for~article,~book,~or~slides.}

\ProvidesExplClass{\c__zlatex_class_name_tl}         % Class name
                  {\c__zlatex_class_date_tl}         % Class Date updated
                  {\c__zlatex_class_version_tl}      % Class Version latest
                  {\c__zlatex_class_description_tl}  % Class Description





% ----------------------------------------------------------------------
%                   zlatex Message system
% ----------------------------------------------------------------------                 
\prop_gput:Nnn \g_msg_module_type_prop { zlatex } { Class }
\cs_new_protected:Npn \zlatex_msg_set:nn #1#2 { 
  \msg_if_exist:nnTF { zlatex }{#1} 
    { \msg_set:nnn { zlatex }{#1}{#2} }
    { \msg_new:nnn { zlatex }{#1}{#2} }
}
\cs_new_protected:Npn \zlatex_msg_warn:n #1 { 
  \msg_warning:nn { zlatex }{#1} 
}
\cs_new_protected:Npn \zlatex_msg_error:n #1 { 
  \msg_error:nn { zlatex }{#1} 
}
% class common options
\zlatex_msg_set:nn {option-unknown}{
  You~use~an~unknown~class~option~key:'\l_keys_key_str'.~Valid~options~are:lang,~
  hyper,~fancy,~class,~classOption(<clist>),~toc(<key-value>),~font(<key-value>),~
  layout(<key-value>),~section(<key-value>),~mathSpec(<key-value>),~bib_index(<key-value>).~
  Assignment~Ignored~and~LaTeX~default~settings~substitute.
}
% meta key warning message
\cs_new_protected:Npn \zlatex_metakey_msg_warning:nn #1#2 {
  \zlatex_msg_set:nn {option-meta-key}
    {You~use~an~invalid~key~"\l_keys_key_str"~or~key~assign~for~it~in~the~meta~key~"#1",~
    Valid~options~are:#2;~Assignment~Ignored~and~zLaTeX~default~#1~settings~substitute.}
  \zlatex_msg_warn:n {option-meta-key}
}





% ----------------------------------------------------------------------
%                             Class Tools
% ----------------------------------------------------------------------
% zlatex dim set interface
\box_new:N \l_zlatex_measure_box
\cs_new_protected:Npn \zlatex_box_set_to:NNn #1#2#3 {
  \hbox_set:Nn \l_zlatex_measure_box {#3}
  \dim_set:Nn #2 {#1 \l_zlatex_measure_box}
  \box_set_eq:NN \l_zlatex_measure_box \c_empty_box
}
\cs_new_protected:Npn \zlatex_set_to_height:Nn { \zlatex_box_set_to:NNn \box_ht:N }
\cs_new_protected:Npn \zlatex_set_to_width:Nn  { \zlatex_box_set_to:NNn \box_wd:N }
\cs_new_protected:Npn \zlatex_set_to_depth:Nn  { \zlatex_box_set_to:NNn \box_dp:N }

% zlatex hook interface
\cs_new_protected:Npn \zlatex_hook_preamble_last:n #1
  { \AddToHook{env/document/before}{#1} }
\cs_new_protected:Npn \zlatex_hook_doc_begin:n #1
  { \AddToHook{begindocument}{#1} }
\cs_new_protected:Npn \zlatex_hook_doc_end:n #1
  { \AddToHook{enddocument}{#1} }

% zlatex key-value setup interface
\cs_new_protected:Npn \zlatex_option_keys_define:n
  { \keys_define:nn { zlatex / option } }
\cs_new_protected:Npn \zlatex_keys_define:nn #1
  { \keys_define:nn { zlatex / #1} }
\cs_new_protected:Npn \zlatex_keys_set:nn #1
  { \keys_set:nn { zlatex / #1 } }





% ----------------------------------------------------------------------
%                              Class Option 
% ----------------------------------------------------------------------
\RequirePackage {l3keys2e}
% setup class options
\zlatex_option_keys_define:n {  
  % basic options
  lang            .str_gset:N   = \g__zlatex_lang_str,
  lang            .initial:n    = { en },
  hyper           .bool_gset:N  = \g__zlatex_hyperref_bool,
  hyper           .initial:n    = { false },
  fancy           .bool_gset:N  = \g__zlatex_fancy_bool,
  fancy           .initial:n    = { false },
  % sub class and options
  class           .str_gset:N   = \g__zlatex_subclass_type_str,
  class           .initial:n    = { article },
  classOption     .clist_gset:N = \g__zlatex_subclass_option_clist,
  classOption     .initial:n    = { oneside, 10pt },
  packageOption   .clist_gset:N = \g__zlatex_package_option_clist,
  % zlatex options meta key 
  toc             .meta:nn      = { zlatex / option / toc }{#1},
  font            .meta:nn      = { zlatex / option / font }{#1},
  layout          .meta:nn      = { zlatex / option / layout }{#1},
  section         .meta:nn      = { zlatex / option / section }{#1},
  mathSpec        .meta:nn      = { zlatex / option / mathSpec }{#1},
  bib_index       .meta:nn      = { zlatex / option / bib_index }{#1},
  unknown         .code:n       = { 
    \zlatex_msg_warn:n {option-unknown} 
  }
}
\zlatex_msg_set:nn {option-language} {
  Current~invalid~language~option~is:~'\g__zlatex_lang_str',zlatex~only~
  support~'en(english)',~and~'cn(chinese)'~till~now.
}

% sub-key for each meta option
\zlatex_keys_define:nn { option / toc }{
  column          .int_gset:N   = \g__zlatex_toc_column_int,
  column          .initial:n    = { 1 },
  title           .code:n       = { \AddToHook{package/babel/after}{\zlatex_hook_doc_begin:n {\renewcommand{\contentsname}{#1}}} },
  title-vspace    .dim_gset:N   = \g__zlatex_toc_title_vspace_dim,
  title-vspace    .initial:n    = { -2em },
  unknown         .code:n       = { 
    \zlatex_metakey_msg_warning:nn {toc}
      {column(<int>:1), title(<tl>:contentname), title-vspace(<dim>:-2em)} 
  }
}
\zlatex_keys_define:nn { option / font }{
  config          .bool_gset:N  = \g__zlatex_font_config_bool,
  config          .initial:n    = { false }, 
  unknown         .code:n       = { 
    \zlatex_metakey_msg_warning:nn {font}
      {config(<bool>:false)} 
  }
}
\zlatex_keys_define:nn { option / layout }{
  margin          .bool_gset:N  = \g__zlatex_margin_bool,
  margin          .initial:n    = { false },
  slide           .bool_gset:N  = \g__zlatex_slide_bool,
  slide           .initial:n    = { false },
  aspect          .tl_gset:N    = \g__zlatex_aspectratio_tl,
  aspect          .initial:n    = { 12|9 },
  unknown         .code:n       = { 
    \zlatex_metakey_msg_warning:nn {layout}
      {margin(<bool>:false), slide, aspect} 
  }
}
\zlatex_keys_define:nn { option / mathSpec }{
  alias           .bool_gset:N  = \g__zlatex_math_alias_bool,
  alias           .initial:n    = { false },
  envStyle        .tl_gset:N    = \g__zlatex_math_env_style_tl,
  envStyle        .initial:n    = { plain },
  font            .choice:,
  font / newtx    .code:n       = { \zlatex_hook_preamble_last:n { \RequirePackage{newtxmath} } },
  font / mtpro2   .code:n       = { \zlatex_hook_preamble_last:n { \RequirePackage[lite, subscriptcorrection, slantedGreek, nofontinfo]{mtpro2} } },
  font / euler    .code:n       = { \zlatex_hook_preamble_last:n { \RequirePackage[OT1, euler-digits]{eulervm} } },
  font / mathpazo .code:n       = { \let\rmbefore\rmdefault\zlatex_hook_preamble_last:n { \RequirePackage{mathpazo} } \let\rmdefault\rmbefore},
  font / unknown  .code:n       = { \zlatex_metakey_msg_warning:nn {mathSpec}{newtx, mtpro2, euler, mathpazo} },
  unknown         .code:n       = { 
    \zlatex_metakey_msg_warning:nn {mathSpec}
      {alias(<bool>:false), envStyle, font(<choice>:newtx,mtpro2,euler,mathpazo)} 
  }
}
\zlatex_keys_define:nn { option / bib_index }{
  load                .bool_gset:N  = \g__zlatex_bib_index_load_bool,
  source              .str_gset:N   = \g__zlatex_bib_source_str,
  source              .initial:n    = { ref.bib },
  backend             .str_gset:N   = \g__zlatex_bib_backend_str,
  backend             .initial:n    = { biber },
  unknown             .code:n       = { 
    \zlatex_metakey_msg_warning:nn {bib_index}
      {load(<bool>:false), source, backend} 
  } 
}

% option setup
\ProcessKeysOptions {zlatex / option}
\NewDocumentCommand{\zlatexSetup}{m}{ \zlatex_keys_set:nn {option}{#1} }

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

% pass clist options main subclass: 'article', 'book', 'ctexbook'
\zlatex_msg_set:nn {option-subclass}{
  subclass~option:"\g__zlatex_subclass_type_str"~is~not~
  accessible,~Valid~options~are:article,~book~and~ctexbook.
}
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
}{\zlatex_msg_error:n {option-subclass}}

% baisc document class and packages option
\str_case:VnF \g__zlatex_lang_str {
  {en} { 
    \sys_if_engine_xetex:TF {
      \zlatex_hook_preamble_last:n {
        \bool_if:NF \g__zlatex_font_config_bool {
          \zlatex_msg_set:nn {compile-engine-pdftex}
            {Current~compile~engine~is~XETEX,~For~better~output,~use~PDFTEX~instead.}
          \zlatex_msg_warn:n {compile-engine-pdftex}
        }
      }
    }{\RequirePackage[utf8]{inputenc}}
    \RequirePackage[T1]{fontenc}
    \RequirePackage[english]{babel}
    \zlatex_hook_preamble_last:n {
      \RequirePackage{csquotes}
      \RequirePackage{microtype}
    }
  }
  {cn} {
    \sys_if_engine_xetex:F {
      \zlatex_msg_set:nn {compile-engine-xetex}
        {Current~compile~engine~is~PDFTEX,~For~chinese~material,~use~XETEX~instead.}
      \zlatex_msg_error:n {compile-engine-xetex}
    }
    \PassOptionsToPackage{quiet}{fontspec}
    \PassOptionsToPackage{no-math}{fontspec}
    \str_if_eq:VnF \g__zlatex_subclass_type_str {ctexbook}{
      \RequirePackage[UTF8, heading]{ctex}
      \linespread{1.3}
    }
  }
}{\zlatex_msg_error:n {option-language}}   





% ----------------------------------------------------------------------
%                               Page Layout 
% ----------------------------------------------------------------------
\RequirePackage{geometry}
\RequirePackage{framed}
\RequirePackage{xcolor}
% document mode
\if@twoside 
  \geometry{a4paper, left=3cm, right=5.5cm, bottom=3.5cm, footskip=1.5cm, marginparsep=1em}
  \bool_if:NTF \g__zlatex_margin_bool {
    \geometry{a4paper, left=2.5cm, right=7.5cm, bottom=3.5cm, footskip=1.5cm, marginparsep=2em}
    \dim_gset:Nn \marginparwidth{14em}
  }{
    \zlatex_msg_set:nn {option-page-margin}
      {No~margin~option~is~only~accessible~in~oneside~layout,~margin~option~is~now~enabled~by~default.}
    \zlatex_msg_warn:n {option-page-margin}
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

% slide mode
\exp_args:NNnx \seq_set_split:Nnn \l_tmpa_seq {|}{\g__zlatex_aspectratio_tl}
\bool_if:NTF \g__zlatex_slide_bool {
  % layout and mark
  \RequirePackage[explicit]{titlesec}
  \RequirePackage{titletoc}
  \geometry {
    papersize={\seq_item:Nn \l_tmpa_seq {1}cm, \seq_item:Nn \l_tmpa_seq {2}cm},
    hmargin=1cm, top=.4cm, includefoot, bottom=5.5pt,
    footskip=\dim_eval:n {1.25em + 5pt}
  }
  \IfClassLoadedTF{book}{
    \let\cleardoublepage\clearpage
    \renewcommand\chaptermark[1]{\markboth{#1}{}}
    \renewcommand\thesection{\arabic{section}}
    \renewcommand\tableofcontents {
      \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
      \section*{\contentsname\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
      \@starttoc{toc}\if@restonecol\twocolumn\fi
      \setcounter{page}{1}
    }
    \zlatex_hook_preamble_last:n {
    \renewcommand\mainmatter{}
    \renewcommand\frontmatter{}
    \titleformat{\chapter}
      {\Huge}{}{0pt}
      {\hspace{0pt}\vfill\centerline{\makebox(0, 0){#1}}\vfill\hspace{0pt}}
      [\thispagestyle{empty}]
    \titleformat{name=\chapter, numberless}
      {\Huge}{}{0pt}
      {\hspace{0pt}\vfill\centerline{\makebox(0, 0){#1}}\vfill\hspace{0pt}}
      [\thispagestyle{empty}]
    }
  }{\relax}
  \renewcommand\sectionmark[1]{\markboth{#1}{}}
  \titleformat{\section}
    {\Large}{}{0pt}
    {
      \textcolor{\tl_use:N \l__zlatex_slide_sec_fg_tl}{
      \tl_use:N \l__zlatex_slide_sec_prefix_tl #1
      \tl_use:N \l__zlatex_slide_sec_suffix_tl}
    }
    [\bool_gset_true:N \g_new_sec_bool]

  % status bar and metadata-item
  \bool_new:N \g_new_sec_bool
  \AddToHook{cmd/chapter/before}{\newpage}
  \AddToHook{cmd/section/before}{\newpage}
  \AddToHook{shipout/firstpage}{\setcounter{page}{0}}
  \AddToHook{shipout/lastpage}{\label{zslide-last-page}}
  \AddToHook{shipout/after}{\bool_gset_false:N \g_new_sec_bool}
  \AddToHook{cmd/tableofcontents/before}{\renewcommand{\contentsname}{Outline}}
  \AddToHook{shipout/background}{
    \_zslide_status_bar:nnnn {(0, -.9em)}{UL}{.5}{1.25em}
    \_zslide_status_bar:nnnn {(.5\paperwidth, -.9em)}{UR}{.5}{1.25em}
    \_zslide_status_bar:nnnn {(0, -\paperheight)}{BL}{.33}{.9em}
    \_zslide_status_bar:nnnn {(.33\paperwidth, -\paperheight)}{BC}{.34}{.9em}
    \_zslide_status_bar:nnnn {(.67\paperwidth, -\paperheight)}{BR}{.33}{.9em}
    \bool_if:NT \g_new_sec_bool {\_zslide_status_bar:nnnn {(0, -2.7em)}{sec}{1}{1.8em}}
  }
  \AddToHook{shipout/foreground}{
    \_slide_status_metadate:nnn {head}{0}  {.5}{ \hfill\_slide_metadate:n {UL}\  }
    \_slide_status_metadate:nnn {head}{.5} {.5}{ \ \_slide_metadate:n {UR}\hfill }
    \_slide_status_metadate:nnn {foot}{0}  {.33}{ \hfill\_slide_metadate:n {BL}\hfill }
    \_slide_status_metadate:nnn {foot}{.33}{.34}{ \hfill\_slide_metadate:n {BC}\hfill }
    \_slide_status_metadate:nnn {foot}{.67}{.33}{ \hfill\_slide_metadate:n {BR}\quad  }
  }
  \cs_new_protected:Npn \_zslide_status_bar:nnnn #1#2#3#4 {
    \ifnum\thepage=0\else
      \put#1 {\textcolor{\tl_use:c {l__zlatex_slide_#2_bg_tl}}{\rule{#3\paperwidth}{#4}}}
    \fi
  }
  \cs_new_protected:Npn \_slide_status_metadate:nnn #1#2#3#4 {
    \ifnum\thepage=0\else\str_case:nn {#1}{ 
      {head} {\put(#2\paperwidth, -.9em+2.5pt) {\hbox~ to~ #3\paperwidth {#4}}}
      {foot} {\put(#2\paperwidth, -\paperheight+2.5pt) {\hbox~ to~ #3\paperwidth {#4}}}
    }\fi
  }

  % zslide metadata setup
  \AddToHook{cmd/maketitle/before}{
    \let\zslideTitle\@title
    \let\zslideAuthor\@author
    \let\zslideDate\@date
  }
  \zlatex_keys_define:nn { slide }{
    sec            .meta:nn   = { zlatex / slide / sec }{#1},
    sec / prefix   .tl_set:N  = \l__zlatex_slide_sec_prefix_tl,
    sec / prefix   .initial:n = {},
    sec / suffix   .tl_set:N  = \l__zlatex_slide_sec_suffix_tl,
    sec / suffix   .initial:n = {},
    sec / bg       .tl_set:N  = \l__zlatex_slide_sec_bg_tl,
    sec / bg       .initial:n = { zslideIII },
    sec / fg       .tl_set:N  = \l__zlatex_slide_sec_fg_tl,
    sec / fg       .initial:n = { zslideMain },
    UL             .meta:nn   = { zlatex / slide / UL }{#1},
    UL / text      .tl_set:N  = \l__zlatex_slide_UL_text_tl,
    UL / text      .initial:n = { Section\ \thesection },
    UL / bg        .tl_set:N  = \l__zlatex_slide_UL_bg_tl,
    UL / bg        .initial:n = { zslideMain },
    UL / fg        .tl_set:N  = \l__zlatex_slide_UL_fg_tl,
    UL / fg        .initial:n = { zslideII },
    UR             .meta:nn   = { zlatex / slide / UR }{#1},
    UR / text      .tl_set:N  = \l__zlatex_slide_UR_text_tl,
    UR / text      .initial:n = { {\ifnum\arabic{subsection}=0\else Subsection\ \thesubsection\fi} },
    UR / bg        .tl_set:N  = \l__zlatex_slide_UR_bg_tl,
    UR / bg        .initial:n = { zslideII },
    UR / fg        .tl_set:N  = \l__zlatex_slide_UR_fg_tl,
    UR / fg        .initial:n = { zslideMain },
    BL             .meta:nn   = { zlatex / slide / BL }{#1},
    BL / text      .tl_set:N  = \l__zlatex_slide_BL_text_tl,
    BL / text      .initial:n = { \zslideAuthor },
    BL / bg        .tl_set:N  = \l__zlatex_slide_BL_bg_tl,
    BL / bg        .initial:n = { zslideMain },
    BL / fg        .tl_set:N  = \l__zlatex_slide_BL_fg_tl,
    BL / fg        .initial:n = { zslideII },
    BC             .meta:nn   = { zlatex / slide / BC }{#1},
    BC / text      .tl_set:N  = \l__zlatex_slide_BC_text_tl,
    BC / text      .initial:n = { \zslideTitle },
    BC / bg        .tl_set:N  = \l__zlatex_slide_BC_bg_tl,
    BC / bg        .initial:n = { zslideIII },
    BC / fg        .tl_set:N  = \l__zlatex_slide_BC_fg_tl,
    BC / fg        .initial:n = { zslideMain },
    BR             .meta:nn   = { zlatex / slide / BR }{#1},
    BR / text      .tl_set:N  = \l__zlatex_slide_BR_text_tl,
    BR / text      .initial:n = { \zslideDate\quad \thepage/\pageref{zslide-last-page} },
    BR / bg        .tl_set:N  = \l__zlatex_slide_BR_bg_tl,
    BR / bg        .initial:n = { zslideII },
    BR / fg        .tl_set:N  = \l__zlatex_slide_BR_fg_tl,
    BR / fg        .initial:n = { zslideMain },
    unknown        .code:n    = { 
      \zlatex_metakey_msg_warning:nn {slide}{
        sec(<key-value>:prefix, suffix, bg, fg)
        UL(<key-value>:text, bg, fg), UR(<key-value>:text, bg, fg),
        BL(<key-value>:text, bg, fg), BC(<key-value>:text, bg, fg),
        BR(<key-value>:text, bg, fg)
      }
    }
  }
  \cs_new_protected:Npn \_slide_metadate:n #1 {
    {\scriptsize\textcolor{\tl_use:c {l__zlatex_slide_#1_fg_tl}}
      {\tl_use:c {l__zlatex_slide_#1_text_tl}}}
  }

  % slide toc interface
  \let\zslideTocPage\contentspage
  % bug: cat let an alias fot '\thecontentslabel'
  \NewDocumentCommand{\zslideToclabelSet}{om}{
    \zlatex_set_to_width:Nn \l_tmpa_dim {#2}
    \IfNoValueTF {#1}{\dim_set:Nn \l_tmpb_dim {\l_tmpa_dim}}
      {\dim_set:Nn \l_tmpb_dim {\l_tmpa_dim + #1}}
    \contentslabel[#2]{\dim_use:N \l_tmpb_dim}
  }
  \zlatex_keys_define:nn { slide / toc }{
    leftmargin              .meta:nn   = { zlatex / slide / toc / leftmargin }{#1},
    leftmargin / chapter    .dim_set:N = \l__zlatex_slide_toc_leftmargin_chapter_dim,
    leftmargin / chapter    .initial:n = { 2em },
    leftmargin / section    .dim_set:N = \l__zlatex_slide_toc_leftmargin_section_dim,
    leftmargin / section    .initial:n = { 4em },
    leftmargin / subsection .dim_set:N = \l__zlatex_slide_toc_leftmargin_subsection_dim,
    leftmargin / subsection .initial:n = { 6em },
    label                   .meta:nn   = { zlatex / slide / toc / label }{#1},
    label / chapter         .tl_set:N  = \l__zlatex_slide_toc_label_chapter_tl,
    label / chapter         .initial:n = { \zslideToclabelSet[.25em]{\thecontentslabel.} },
    label / section         .tl_set:N  = \l__zlatex_slide_toc_label_section_tl,
    label / section         .initial:n = { \zslideToclabelSet{\DLE} },
    label / subsection      .tl_set:N  = \l__zlatex_slide_toc_label_subsection_tl,
    label / subsection      .initial:n = { \zslideToclabelSet[.5em]{\zslidesubsecIcon} },
    suffix                  .meta:nn   = { zlatex / slide / toc / suffix }{#1},
    suffix / chapter        .tl_set:N  = \l__zlatex_slide_toc_suffix_chapter_tl,
    suffix / chapter        .initial:n = {  },
    suffix / section        .tl_set:N  = \l__zlatex_slide_toc_suffix_section_tl,
    suffix / section        .initial:n = {  },
    suffix / subsection     .tl_set:N  = \l__zlatex_slide_toc_suffix_subsection_tl,
    suffix / subsection     .initial:n = {  },
    unknown                 .code:n    = { 
      \zlatex_metakey_msg_warning:nn {slide}{
        {leftmargin(<key-value>:chapter[<dim>:2em], section[<dim>:4em], subsection[<dim>:6em]), 
        label(<key-value>:chapter[<tl>:thechapter;hbox:1em], section[<tl>:thesection;hbox:1em], 
          subsection[<tl>:thesubsection;hbox:2em]),
        after(<key-value>:chapter[tl:<empty>], section[tl:<empty>], subsection[tl:<empty>])}
      } 
    }
  }
  \clist_map_inline:nn {chapter, section, subsection}{
    \titlecontents{#1}
      [\dim_use:c {l__zlatex_slide_toc_leftmargin_#1_dim}]
      {\vspace*{\fill}}{\tl_use:c {l__zlatex_slide_toc_label_#1_tl}}
      {}{\tl_use:c {l__zlatex_slide_toc_suffix_#1_tl}}
  }
  \RequirePackage{ascii}
  \setcounter{tocdepth}{2}
  \def\zslidesubsecIcon{\rule[1.5pt]{3pt}{3pt}}
  \AddToHook{cmd/@starttoc/before}{\vspace*{\fill}}
  \AddToHook{cmd/@starttoc/after}{\vspace*{\stretch{3}}}

  % slide mode setup interface
  \NewDocumentCommand{\zslideSetup}{om}{
    \IfNoValueTF {#1}{
      \zlatex_keys_set:nn { slide }{#2}
    }{
      \zlatex_keys_set:nn { slide / #1 }{#2}
    }
  }

  % slide mode init options
  \zlatex_hook_preamble_last:n {\pagestyle{empty}}
  \renewcommand{\familydefault}{\sfdefault}
  \definecolor{zslideMain}{HTML}{a30000}
  \definecolor{zslideII}{HTML}{e0e0e0}
  \definecolor{zslideIII}{HTML}{f0f0f0}
}{\newcommand\zslideSetup[1]{}}

% fancy page settings
\bool_if:NF \g__zlatex_slide_bool {
  \RequirePackage{fancyhdr}
  \fancypagestyle{fancy}{
    \fancyhf{}  
    \dim_gset:Nn \headheight{15pt}
    \renewcommand{\headrule}{\hrule width\textwidth}
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
  \fancypagestyle{plain}{
    \fancyhf{}  
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\headrule}{}
    \fancyfoot[C]{\thepage}
  }
}

% front/main matter
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
}{
  \bool_if:NF \g__zlatex_slide_bool 
    {\zlatex_hook_preamble_last:n {\pagestyle{fancy}}}
}





% ----------------------------------------------------------------------
%                        Math package and hyperref
% ----------------------------------------------------------------------
\RequirePackage{amsfonts, amsmath}          
\RequirePackage{amsthm}
\RequirePackage{esint} 
\zlatex_hook_preamble_last:n {
\bool_if:NT \g__zlatex_bib_index_load_bool {            
  \str_case:Vn \g__zlatex_bib_backend_str {
    {bibtex}{\RequirePackage[backend=bibtex]{biblatex}}
    {biber}{\RequirePackage[backend=biber]{biblatex}}
  }
  \exp_args:Nx \addbibresource{\str_use:N \g__zlatex_bib_source_str}
}}
\bool_if:NT \g__zlatex_hyperref_bool {
  \RequirePackage{hyperref}
}
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
}{\zlatex_msg_error:n {option-language}}





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
\zlatex_keys_define:nn {color}{
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
  unknown         .code:n       =  { 
    \zlatex_metakey_msg_warning:nn {color}
      {link, cite, url, chapter, chapter-rule, axiom, definition, 
      theorem, lemma, corollary, proposition, remark} 
    }
}
\NewDocumentCommand{\zlatexColorSetup}{m}{
  \zlatex_keys_set:nn {color}{#1}
  \bool_if:NTF \g__zlatex_hyperref_bool {
    \hypersetup {
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
\zlatex_msg_set:nn {mathenv-name}
  {An~unexpected~math~env~name~in~multichoice~key:'\l_keys_key_tl',~there~is~no~internal~config~for~it.}
\str_case:VnTF \g__zlatex_lang_str { 
  {en}{
    \zlatex_keys_define:nn {math-env}{
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
      math-env / unknown      .code:n = {
        \zlatex_msg_error:n {mathenv-name}
      },
    }
  }
  {cn}{
    \zlatex_keys_define:nn {math-env}{
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
      math-env / unknown      .code:n = {
        \zlatex_msg_error:nn {mathenv-name}
      },
    }
  }
}{\zlatex_keys_set:nn {math-env}{ 
  math-env={ axiom, definition, theorem, lemma, corollary, proof, 
  proposition, remark, exercise, example, solution, problem } }
}{\zlatex_msg_error:nn {option-lang}}

% math env's style
\newtheoremstyle{zlatexMathEnv}
  {2pt}{2pt}{}
  {0pt}{\bfseries}{}
  {.25em}{\thmname{#1}~ \thmnumber{#2}~ \thmnote{(#3)}}
\theoremstyle{zlatexMathEnv}

% theorem-like env declaration
\NewDocumentCommand{\zlatexMathEnvStyle}{m}{
  \tl_gset:Nn \g__zlatex_math_env_style_tl {#1}
  \zlatex_msg_set:nn {mathEnv-dependency}{
    MathEnv~style:'#1'~requires~package~'tcolorbox'~and~'tikz',~and~either~of~
    which~hasn't~been~loaded~in~your~preamble.~Reset~to~default~'plain'~style~now.
  }
  \clist_if_in:nnT {shadow, paris} {#1} {
    \@ifpackageloaded{tcolorbox}{\relax}{
      \tl_gset:Nn \g__zlatex_math_env_style_tl {plain}
      \zlatex_msg_warn:n {mathEnv-dependency}
    }
  }
}
\seq_new:N \l_tcb_flag_seq
\seq_set_from_clist:Nn \l_tcb_flag_seq {shadow, paris}
\zlatex_hook_preamble_last:n {
\seq_if_in:NVT \l_tcb_flag_seq \g__zlatex_math_env_style_tl {
  \@ifpackageloaded{tcolorbox}{\relax}{
    \RequirePackage[many]{tcolorbox}
  }
}}
% Hook for Math Env Style
\NewDocumentCommand{\zlatexMathEnvStyleNew}{mm}{
  \AddToHook{zlatex/math/envstyle/begin}{#1}
  \AddToHook{zlatex/math/envstyle/end}{#2}
  \ActivateGenericHook{zlatex/math/envstyle/begin}
  \ActivateGenericHook{zlatex/math/envstyle/end}
  \tl_gset:Nn \g__zlatex_math_env_style_tl {HOOK}
}
\zlatex_msg_set:nn {mathEnv-style}{
  You~use~an~incorrect~MathEnv~style:~'\g__zlatex_math_env_style_tl',~All~valid~
  MathEnv~are:'plain',~'leftbar',~'background',~'fancy',~'shadow',~'paris'.
}
\DeclareDocumentEnvironment{zlatexTheoremLikeFrame}{O{axiom}}{
  \def\TempColor{\tl_use:c {l__zlatex_#1_color_tl}}
  \str_case:VnF \g__zlatex_math_env_style_tl {
    {plain}{  
      \def\FrameCommand{}
      \MakeFramed {\advance\hsize-\width \FrameRestore}
    }
    {leftbar}{
      \def\FrameCommand{{\color{\TempColor}\vrule~ width~ 3pt}\hspace{5pt}}
      \MakeFramed {\advance\hsize-\width \FrameRestore}
    }
    {background}{
      \def\FrameCommand{\colorbox{\TempColor!10}}
      \MakeFramed {\advance\hsize-\width \FrameRestore}
    }
    {fancy}{
      \def\FrameCommand{{\color{\TempColor}\vrule~ width~ 3pt}\colorbox{\TempColor!10}}
      \MakeFramed{\advance\hsize-\width \FrameRestore}
    }
    {shadow}{
      \begin{tcolorbox}[
        enhanced~ jigsaw, breakable,
        top=1.5pt,  bottom=1.5pt,
        left=3pt,   right=3pt,
        boxrule=0pt, sharp~ corners,
        drop~ fuzzy~ shadow,
        colback={\TempColor!10}, 
        borderline~ west={3pt}{0pt}{\TempColor}
      ]
    }
    {paris}{
      \begin{tcolorbox}[
        enhanced,   breakable,
        top=1.5pt,  bottom=1.5pt,
        left=3pt,   right=3pt,
        boxrule=0pt,    sharp~ corners,
        colback=gray!5, drop~ fuzzy~ shadow,
        overlay={
          \draw[\TempColor, line~ width=0.2pt] (frame.north~ west)--(frame.north~ east);
          \draw[\TempColor, line~ width=3pt] ([yshift=1.5pt]frame.north~ west) -- +(2.5cm, 0);
        }
      ]  
    }
    {HOOK}{\UseHook{zlatex/math/envstyle/begin}}
  }{\zlatex_msg_error:n {mathEnv-style}}
}{
  \str_case:Vn \g__zlatex_math_env_style_tl {
    {HOOK}{\UseHook{zlatex/math/envstyle/end}}
    {paris}{\end{tcolorbox}}
    {shadow}{\end{tcolorbox}}
    {plain}{\endMakeFramed}
    {leftbar}{\endMakeFramed}
    {background}{\endMakeFramed}
    {fancy}{\endMakeFramed}
  }
}

% loop to create math env, setup \cref
\clist_map_inline:Nn \g__zlatex_theoremlike_envs_clist {
  % theorem create
  \newtheorem{zlatex#1}{\tl_use:c {zlatex#1Name}}[section]

  % env create (use the above Styles)
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
  }{\zlatex_msg_error:n {option-lang}}
}

% proof-like env decalration
\NewDocumentEnvironment{zlatexProofLikeFrame}{O{}}{
  \def\FrameCommand{}
  \MakeFramed {\advance\hsize-\width \FrameRestore}
}{\endMakeFramed}
\renewcommand{\qedsymbol}{\ensuremath{\blacksquare}}
\clist_map_inline:Nn \g__zlatex_prooflike_envs_clist {
  \DeclareDocumentEnvironment{#1}{O{}}{
    \begin{zlatexProofLikeFrame}[]
    {\noindent{\bfseries\tl_use:c {zlatex#1Name}:}}
    \tl_set:Nn \l__arg_one_tl {#1}
  }{\str_if_eq:VnTF \l__arg_one_tl {proof}{\hfill\qedsymbol\par}{\par}\end{zlatexProofLikeFrame}}
}

% math related cmds alias
\zlatex_hook_preamble_last:n {
\bool_if:NT \g__zlatex_math_alias_bool {
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
}}





% ----------------------------------------------------------------------
%                        ToC, Titles and Cover Style
% ----------------------------------------------------------------------
% main ToC interface
\AddToHook{cmd/@starttoc/before}{\vspace*{\dim_use:N \g__zlatex_toc_title_vspace_dim}}
\zlatex_hook_preamble_last:n {
\int_compare:nNnT {\g__zlatex_toc_column_int} > {1} {
  \RequirePackage{multicol}
  \AddToHook{cmd/@starttoc/before}{\begin{multicols}
    {\int_use:N \g__zlatex_toc_column_int}}
  \AddToHook{cmd/@starttoc/after}{\end{multicols}}
}}
% partial ToC
\RequirePackage{titletoc}
\NewDocumentCommand\stopPartToc{mm}{
  \int_compare:nNnTF {#2}<{1}
    {\relax}{\stopcontents[#1]}
}
\NewDocumentCommand{\partialToc}{O{2}}{
  % toc depth
  \setcounter{tocdepth}{#1} 
  \titlecontents{psection}[2em]
    {} {\contentslabel{2em}} {} {\titlerule*[1pc]{.}\contentspage}
  \titlecontents{psubsection}[4.5em]
    {} {\contentslabel{2.5em}} {} {\titlerule*[1pc]{.}\contentspage}
  \titlecontents{psubsubsection}[5.5em]
    {} {\contentslabel{0em}} {} {\titlerule*[1pc]{.}\contentspage}
  % print partial Toc
  \IfClassLoadedTF{book}{ 
    \startcontents[chapters]
    \printcontents[chapters]{p}{1}{}
    \AddToHook{cmd/chapter/before}{\stopPartToc{chapters}{\thechapter}}
  }{
    \startcontents[sections]
    \printcontents[sections]{p}{1}{}
    \AddToHook{cmd/section/before}{\stopPartToc{section}{\thesection}}
  }
}

% chapter head style
\newif\ifFancyChapter
\zlatex_hook_preamble_last:n {
\bool_if:NTF \g__zlatex_font_config_bool {
  \RequirePackage{fontspec}
  \newfontfamily{\Cinzel}{CinzelRegular.ttf}[
    BoldFont=CinzelBold.ttf,
    ItalicFont=SabonItalic.ttf
  ]
}{\def\Cinzel{\relax}}}
\IfClassLoadedTF{book}{
  \bool_if:NTF \g__zlatex_fancy_bool {
    \RequirePackage[explicit]{titlesec}
    \RequirePackage{anyfontsize}
    \FancyChaptertrue
    % numbered chapter format
    \titleformat{\chapter}[display]
    {\huge}{}
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
        {\normalsize\scalebox{4}{\thechapter}\numSuffix{\thechapter}};
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
        \parbox[t]{.3\paperwidth}{\fontsize{10pt}{15pt}
          \selectfont\Cinzel\itshape\z@leftContent}
      };
      \node[anchor=north~ west, inner~ sep=0pt] at ($(stripES)+(-3em+.45em+.3\paperwidth, -1em)$){
        \parbox[t]{\dimeval{.45\paperwidth-.45em}}{
          \fontsize{10pt}{15pt}\selectfont\z@rightContent}
      };
      % saying block
      \coordinate (sayingWN) at ($(current~ page.south~ west)+(0, .3\paperheight)$); 
      \shade[top~ color=white, bottom~ color=zchapColor!25] (sayingWN) 
        rectangle ++(1\paperwidth, 5pt);
      \shade[top~ color=zchapColor!25, bottom~ color=white] ($(sayingWN)+(0em, -.15\paperheight)$) 
        rectangle ++(1\paperwidth, -5pt);
      \node at ($(sayingWN)+(.5\paperwidth, -0.075\paperheight)$) {
        \parbox[t][][r]{.75\paperwidth}{\fontsize{15pt}{22.5pt}\selectfont
          \MakeUppercase{\Cinzel\z@saying\\\hspace*{\fill}{\itshape\normalsize\z@sayauthor}}}
      };
    \end{tikzpicture}}[\thispagestyle{empty}\clearpage]
    % unnumbered chapter format
    \titleformat{name=\chapter, numberless}
      {\bfseries\Huge}
      {}{0pt}{#1}
  }{
    \RequirePackage{titlesec}
    \FancyChapterfalse
    % numbered chapter format
    \titleformat{\chapter}[display]
      {\bfseries\huge\color{black}}
      {\flushright\Large\color{\tl_use:N \l__zlatex_chapter_color_tl}
      \MakeUppercase{\chaptertitlename}\hspace{1ex}
      {\scalebox{2.5}{\thechapter}}}
      {10pt}
      {\color{\tl_use:N \l__zlatex_chapter_rule_color_tl}\titlerule\vspace{1ex}}
    % unnumbered chapter format
    \titleformat{name=\chapter, numberless}
      {\bfseries\Huge}
      {}{0pt}{}
  }
  % chapter space
  \titlespacing{\chapter}{0pt}{-30pt}{40pt}
}{\relax}

% find number suffix: 1 -> st, 2 -> nd, ...
\prop_new:N \g_arabix_suffix_prop
\prop_set_from_keyval:Nn \g_arabix_suffix_prop {
  1=st, 2=nd, 3=rd, 11=th, 12=th, 13=th, 0=th, _=th
} 
\NewDocumentCommand\numSuffix{m}{
  \int_compare:nTF {11 <= #1 <= 13}
    {\prop_item:Ne \g_arabix_suffix_prop {#1}}
    {\int_compare:nTF {\int_mod:nn {#1}{10} > 3}
      {\prop_item:Ne \g_arabix_suffix_prop {_}}
      {\prop_item:Ne \g_arabix_suffix_prop {\int_mod:nn {#1}{10}}}
    }
}

% fancy chapter default material
\ExplSyntaxOff\ifFancyChapter
  % default settings
  \newcommand{\z@subtitle}{Subtitle}
  \newcommand{\z@saying}{SAYING}
  \newcommand{\z@sayauthor}{-- Author}
  \newcommand{\z@rightContent}{Right Content}
  \newcommand{\z@leftContent}{\includegraphics[width=1\linewidth]{example-image-duck}\\[.5em]Figure Description}
  % users' interface
  \NewDocumentCommand{\zsubtitle}{m}{\renewcommand\z@subtitle{#1}}
  \NewDocumentCommand{\zchapterSaying}{O{}m}{\renewcommand\z@saying{#2}\renewcommand\z@sayauthor{#1}}
  \NewDocumentCommand{\zchapterLContent}{m}{\renewcommand\z@leftContent{#1}}
  \NewDocumentCommand{\zchapterRContent}{m}{\renewcommand\z@rightContent{#1}}
\else 
  \NewDocumentCommand{\zsubtitle}{m}{\relax}
  \NewDocumentCommand{\zchapterSaying}{O{}m}{\relax}
  \NewDocumentCommand{\zchapterLContent}{m}{\relax}
  \NewDocumentCommand{\zchapterRContent}{m}{\relax}
\fi\ExplSyntaxOn

% title page
\let\orimaketitle\maketitle
\def\Maketitle{
  \newgeometry{margin=1in}
  \orimaketitle
  \restoregeometry
}
\bool_if:NTF \g__zlatex_slide_bool {
  \renewcommand\maketitle{
    \bool_if:NT \g__zlatex_hyperref_bool {
      \phantomsection
      \hypertarget{zslide-title-page}{}
    }
    \null\vfill\begin{center}
      \begin{tabular}{c}{\huge\zslideTitle}\\[2em]
      \zslideAuthor\\[2em]\zslideDate\end{tabular}
      \vspace{\stretch{2}}\end{center}
    \thispagestyle{empty}\setcounter{page}{0}
    \newpage
  }
}{
  \renewcommand{\maketitle}{
    \thispagestyle{empty}
    \begin{center}\vfill\vspace*{40pt}
    \rule{6pt}{80pt}
    \begin{tabular}[b]{l}
      {\huge\bfseries\@title}\\[5em]
      {\Large\bfseries\@author}
    \end{tabular}
    \par\vfill{\Large\textcolor{gray}{\@date}}
    \end{center}
    \restoregeometry
  }
}





% ----------------------------------------------------------------------
%                       Graphics and Iteration item  
% ----------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{sidenotes}
\graphicspath{
  {./figure/}{./figures/}{./image/}{./images/}
  {./Pictures/}{./picture/}{./Pics/}{./pics/}
  {./graphics/}{./graphic/}
}
\renewcommand{\labelitemii}{\(\circ\)}
\renewcommand{\labelitemiii}{\(\diamond\)}
% equation number style
\counterwithin{equation}{section}
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