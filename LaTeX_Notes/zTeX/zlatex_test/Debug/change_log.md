# change log
## package dependency
add package 
* `anyfontsize`: fixed font scale 
* `multicols`: multi-cols toc support

remove
* `multitoc` in multi-cols toc support

> The package `microtype` and `csquotes` will automatically load `etoolbox`


## message system
### introduction
Add 3 function for message setup and usage:
```latex
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
```

### readable log
People always complain about the compile log LaTeX given, think it hard to read and understand. To this reason, zLaTeX makes the warning or error message more readable, an example messages made by zLaTeX for `class option`:
```shell
# 1. class option warning
Class zlatex Warning: You use an unknown class option key:'startPage'. Valid
(zlatex)              options are:lang, hyper, fancy, class,
(zlatex)              classOption(<clist>), toc(<key-value>),
(zlatex)              font(<key-value>), layout(<key-value>),
(zlatex)              section(<key-value>), mathSpec(<key-value>),
(zlatex)              bib_index(<key-value>). Assignment Ignored and LaTeX
(zlatex)              default settings substitute.
```

Set an user-friendly interface to handle the exception of these class meta key:
```latex
\cs_new_protected:Npn \zlatex_metakey_msg_warning:nn #1#2 {
  \zlatex_msg_new:nn {option-meta-key}
    {You~use~an~invalid~key~"\l_keys_key_str"~or~key~assign~for~it~in~the~meta~key~"#1",~
    Valid~options~are:#2;~Assignment~Ignored~this~assign~and~LaTeX~default~#1~settings~substitute.}
  \zlatex_msg_warn:n {option-meta-key}
}
\zlatex_define:nn { option / font }{
  config              .bool_gset:N  = \g__zlatex_font_config_bool,
  config              .initial:n    = { false }, 
  unknown             .code:n       = { \zlatex_metakey_warning_msg:nn {font}{config(<bool>:false)} }
}
```

Then the message are something like:
```shell
# 2. class meta key warning
Class zlatex Warning: You use an invalid key "font" or key assign for it in
(zlatex)              the meta key "mathSpec", Valid options
(zlatex)              are:newtx,mtpro2,euler,mathpazo; Assignment Ignored and
(zlatex)              LaTeX default mathSpec settings substitute.


Class zlatex Warning: You use an invalid key "counter" or key assign for it in
(zlatex)              the meta key "mathSpec", Valid options
(zlatex)              are:alias(<bool>:false),envStyle,font(<choice>:newtx,mtpr
o2,euler,mathpazo);
(zlatex)              Assignment Ignored and LaTeX default mathSpec settings
(zlatex)              substitute.


Class zlatex Warning: You use an invalid key "openAll" or key assign for it in
(zlatex)              the meta key "layout", Valid options
(zlatex)              are:margin(<bool>:false),slide,aspect; Assignment
(zlatex)              Ignored and LaTeX default layout settings substitute.
```

### auto correct error 
After updating the message system, it will automatically correct some errors users make.
Below is an example about MathEnv style set error:
```shell 
Class zlatex Warning: MathEnv style:'paris' requires package 'tcolorbox' and
(zlatex)              'tikz', But either of them hasn't been loaded in your
(zlatex)              preamble. Reset to default 'plain' style now.
```


### test source
Here is the source for message system debug:
```latex
\documentclass[
  fancy,
  hyper,
  class=hello,
  classOption={12pt},
  layout={margin, slide, aspect=16|9},
  font=config,
  toc={titlee=CONTENTS},
  mathSpec={
    font=eulerr, 
    counter=world
  },
  font=lm,
  layout=openAll,
  bib_index={Notload},
  % lang=cn,
  hello=world,
]{zlatex}
```

## class option interface
### introduction
Change meta-key level in class option interface, now theese meta key is:
```latex
\zlatex_define:nn { option / font }{
config              .bool_gset:N  = \g__zlatex_font_config_bool,
config              .initial:n    = { false }, 
unknown             .code:n       = { \zlatex_metakey_warning_msg:nn {font}{config(<bool>:false)} }
}
```


### \zlatexSetup Vs class option
In class option setup, you can't using `\` in the value, that means you can use any command during the options passing. Thus the following code will cause error:
```latex
\documentclass[
  toc={title=\textbf{CONTENTS}},
]{zlatex}
```

while in the preamble ~~or after `\begin{document}`~~ you can use command `\zlatexSetup` to setup your you options with `\` and so on, like the following:
```latex 
\zlatexSetup{
  toc={
        title=\hfill\large\normalfont CONTENTS {\sffamily\small NEW}\hfill
    }
}
```

> * `\zlatexSetup` can be only used in preamble now

Some tips:
* Some options can only be declared in preamble, like: `fancy`, `class`


|        Option      | class option | \zlatexSetup |
| :----------------: | :----------: | :----------: |
| lang               | :white_check_mark: | :x: |
| hyper              | :white_check_mark: | :x: |
| fancy              | :white_check_mark: | :x: |
| class              | :white_check_mark: | :x: |
| classOption        | :white_check_mark: | :x: |
| packageOption      | :white_check_mark: | :x: |
| toc                | :white_check_mark: | :white_check_mark: |
| font               | :white_check_mark: | :white_check_mark: |
| layout             | :white_check_mark: | :x: |
| section            | :white_check_mark: | :white_check_mark: |
| mathSpec           | :white_check_mark: | :white_check_mark: |
| bib_index          | :white_check_mark: | :white_check_mark: |

> See below `\zslideSetup` for more info.


## slide mode
zLaTeX now provides command `\zslideSetup` for slide mode setup, command args spec:
```latex
\zslideSetup[<sub-key>]{<key-value list>}
```

### basic settings
For common item setup, like `slide theme`, `slide metadata`, an simple example:
```latex
\usepackage{pifont}
\definecolor{ColorA}{HTML}{1abc9c}
\definecolor{ColorB}{HTML}{8e44ad}
\definecolor{ColorC}{HTML}{341f97}
\zslideSetup{
  sec = {bg=ColorC, fg=white, prefix=\ding{73}\ },
  UL = {bg = ColorA, text=UL-TEXT\textcolor{white}{WHITE}, fg=ColorB},
  BC = {text={\hyperlink{zslide-title-page}{\zslideTitle}}},
}
```

### ToC settings
For toc setup, a example like:
```latex
\setcounter{tocdepth}{3}
\zslideSetup[toc]{
  leftmargin = {
    chapter=2em,
    section=4em, 
  },
  suffix = {
    section=\dotfill\textcolor{blue}{\textbf{\zslideTocPage}}
  },
  label = {
    chapter=\contentslabel{8em}, 
    section=\zslideToclabelSet[3em]{\color{green}\thecontentslabel},
    subsection=\zslideToclabelSet{\thecontentslabel}
  },
}
```


## title format
### chapter
Scale the `\thechapter` to 2.5 instead of the original 4. Remove the additional `\makeatlette`, `\makeatother` commands


### ToC 
Add `title`, `column` and `title-vspace` options to toc setting interface. The original `\contentname` lies the `\section*{}`, definition as below:
```latex 
\renewcommand\tableofcontents {
  \if@twocolumn\@restonecoltrue\onecolumn\else\@restonecolfalse\fi
  \section*{\contentsname\@mkboth{\MakeUppercase\contentsname}{\MakeUppercase\contentsname}}
  \begin{multicols}{3}
  \@starttoc{toc}
  \end{multicols}
  \if@restonecol\twocolumn\fi
  \setcounter{page}{1}
}
```

## TODO
- [x] Handle warning about `csquote` with `babel` and `minted`.
- [x] Set default `hyperref` and `biblatex` a group, Don't loading them by default
- [x] remove `fancyhdr` dependency in slide mode, use `\AddToHook{shipout/background}` instead
- [ ] implement the `package-option` interface