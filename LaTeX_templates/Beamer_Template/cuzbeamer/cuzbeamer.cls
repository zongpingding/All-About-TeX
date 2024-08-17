%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Hao XIE <oaheix@gmail.com> 
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{cuzbeamer}[2019/02/01 v1.0 LaTeX Document Class]%

%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
\RequirePackage{kvoptions}% use key-value options
\SetupKeyvalOptions{
    family=cuz,
    prefix=cuz@option@
}
\DeclareStringOption[dark]{colortheme}[dark]% light or dark (default)
\DeclareStringOption[wide]{pagestyle}[wide]% normal, wide (default) or wider
\DeclareStringOption[left]{titlealignment}[left]% left, center or right (default)
\DeclareBoolOption[true]{minted}% use minted package (default) or not
\DeclareBoolOption[false]{algorithm}% use algorithm package bundle or not (default)
\DeclareBoolOption[false]{pgfplots}% use pgfplots package or not (default)
\DeclareDefaultOption{%
    \PassOptionsToClass{\CurrentOption}{beamer}%
}%
%-
%-> Terminates all options processing
%-
\ProcessKeyvalOptions{cuz}\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\ifxstringequal}{\expandafter\ifstrequal\expandafter}% expansion control
\ifxstringequal{\cuz@option@pagestyle}{normal}{%
    \PassOptionsToClass{aspectratio=43}{beamer}%
}{\ifxstringequal{\cuz@option@pagestyle}{wide}{%
    \PassOptionsToClass{aspectratio=1610}{beamer}%
}{%
    \PassOptionsToClass{aspectratio=169}{beamer}%
}}%
\LoadClass[UTF8,10pt,professionalfont,zihao=false]{ctexbeamer}%
%---------------------------------------------------------------------------%
%->> Theme configuration
%---------------------------------------------------------------------------%
\usetheme{metropolis}%
\RequirePackage{appendixnumberbeamer}% 
\metroset{numbering=fraction}%
\ifxstringequal{\cuz@option@colortheme}{light}{
    \metroset{background=light}%
}{%
    \metroset{background=dark}%
}%
%---------------------------------------------------------------------------%
%->> CJK Languages for different platforms and compilers
%---------------------------------------------------------------------------%
\RequirePackage{expl3}% LaTeX3 programming environment
\ExplSyntaxOn%
\providecommand{\g__ctex_fontset_tl}{}% platform fontset state variable
\edef\cuz@fontset{\g__ctex_fontset_tl}% expanded platform fontset state variable
\ExplSyntaxOff%
%-
%-> Platform fontset <windows>, <mac>, <linux>
%-
\newif\ifcuz@windows \cuz@windowsfalse% 
\newif\ifcuz@mac \cuz@macfalse% 
\newif\ifcuz@linux \cuz@linuxfalse% 
\ifxstringequal{\cuz@fontset}{windows}{
    \cuz@windowstrue%
    % \ctexset{fontset=windowsnew}%
}{\ifxstringequal{\cuz@fontset}{mac}{
    \cuz@mactrue
    % \ctexset{fontset=macnew}%
}{
    \cuz@linuxtrue%
    % \ctexset{fontset=ubuntu}%
}}
%-
%-> LaTeX engine <pdflatex>, <lualatex>, <xelatex>
%-
\newif\ifcuz@pdftex \cuz@pdftexfalse
\newif\ifcuz@xetex \cuz@xetexfalse
\newif\ifcuz@luatex \cuz@luatexfalse
\RequirePackage{ifxetex,ifluatex}% LaTeX engine detection
\ifxetex% XeLaTeX
    \cuz@xetextrue%
\else\ifluatex% LuaLaTeX
    \cuz@luatextrue%
\else% pdfLaTeX, not supported in Linux
    \cuz@pdftextrue%
\fi\fi
\RequirePackage{amsmath,mathtools,amsfonts}%
\ifcuz@pdftex
    \RequirePackage[utf8]{inputenc}% set input encoding, document must use utf-8 encoding
    \RequirePackage[T1]{fontenc}% set font encoding to enable modern font encoding
    \RequirePackage{newtxtext}%
\else
    \RequirePackage{fontspec}% support calling system fonts
    \ifcuz@xetex
        \RequirePackage{xeCJK}% support calling system fonts
    \fi
    \setmainfont{Ubuntu}
    \setsansfont{Ubuntu}
    \setmonofont{Ubuntu Mono}
    % \ifcuz@linux
    %     \setmainfont[NFSSFamily=entextrm]{TeX Gyre Termes}% an alternative of Times New Roman
    %     \setsansfont[NFSSFamily=entextsf]{TeX Gyre Heros}% an alternative of Helvetica
    %     \setmonofont[NFSSFamily=entexttt]{TeX Gyre Cursor}% an alternative of Courier New
    % \else
    %     \ifcuz@windows%
    %         \setmainfont{Palatino Linotype}% Times New Roman
    %         \setsansfont{Palatino Linotype}% Helvetica
    %         \setmonofont{Consolas}%
    %     \else% for mac
    %         \setmainfont{Palatino}% Times New Roman
    %         \setsansfont{Palatino}% Helvetica
    %         \setmonofont{Monaco}%
    %     \fi
    % \fi
\fi
\RequirePackage[libertine,liby,libaltvw]{newtxmath}% load after math packages
%---------------------------------------------------------------------------%
%->> Some code to be executed at the beginning of the document
%---------------------------------------------------------------------------%
\AtBeginDocument{
    \makeatletter
    %-
    %-> The university logo in the title page
    %-
    \ifxstringequal{\cuz@option@colortheme}{light}{%
        \titlegraphic{\hfill\includegraphics[width=0.28\textwidth]{cuzlogo}}%
    }{%
        \titlegraphic{\hfill\includegraphics[width=0.28\textwidth]{cuzlogo-brown}}%
    }%
    \makeatother
}
%---------------------------------------------------------------------------%
%->> New environments and macros for convenience
%---------------------------------------------------------------------------%
\RequirePackage{calc}% arithmetic calculation
%-
%-> The new standout environment for standout frames
%-
\newenvironment{standout}[1][]{%
    \begin{frame}[standout]{#1}
}{%
    \end{frame}
}%
%-
%-> The new fragile environment for fragile frames
%-
\newenvironment{fragile}[1][]{%
    %- the environment option tells beamer to look the new name "fragile",
    %- instead of the original name "frame"
    \begin{frame}[fragile,environment=fragile]{#1}
}{%
    \end{frame}
}%
%-
%-> The new algorithmx environment for algorithms
%-
\ifcuz@option@algorithm
    \newenvironment{algorithmx}[2][]{%
        \begin{algorithm}[H]
            \caption{#2}%\label{#1}
            \begin{algorithmic}[1]
    }{%
            \end{algorithmic}
        \end{algorithm}
    }%
\fi
%-
%-> The new bicolumns macro for two columns environment
%-> NOTE:
%-> 1. This command MUST be used within the fragile environment,
%-> 2. NO extra character is allowed in the same line of "{" and "}" of the
%->    last two arguments, not even a comment!!
%-> WRONG:
%->     \bicolumns[0.5]{left}{right}
%-> RIGHT:
%->     \bicolumns[0.5]{
%->         left
%->     }{
%->         right
%->     }
%-
\newlength{\cuz@leftwidth}
\newlength{\cuz@rightwidth}
\newcommand{\bicolumns}{%
    \begingroup
    \let\do\@makeother\dospecials
    \catcode`\{=1
    \catcode`\}=2
    \endlinechar`\^^J
    \bicolumns@implement
}
\newcommand{\bicolumns@implement}[3][0.618]{
    \endgroup
    \setlength{\cuz@leftwidth}{#1\textwidth}
    \setlength{\cuz@rightwidth}{\textwidth-\cuz@leftwidth}
    \begin{columns}[T,onlytextwidth]
        \begin{column}{\cuz@leftwidth}
            \scantokens{#2\noexpand}%
            \expandafter\cuz@cleanup%
        \end{column}
        % \vrule{}% vertical line between two columns
        \begin{column}{\cuz@rightwidth}
            \scantokens{#3\noexpand}%
            \cuz@cleanup%
        \end{column}
    \end{columns}
}
\def\cuz@cleanup#1^^J{#1}
%---------------------------------------------------------------------------%
%->> Useful packages for some basic elements
%---------------------------------------------------------------------------%
\RequirePackage{ctable,multirow,multicol}% captions in tables (using booktabs)
\RequirePackage{caption}% extra caption features
\graphicspath{{./images/}}% set the default graphic path
\ifcuz@option@minted%
    \RequirePackage{minted}%
    \ifxstringequal{\cuz@option@colortheme}{light}{%
        \usemintedstyle{friendly}%
    }{%
        \usemintedstyle{monokai}%
    }%
    \setminted{%
        autogobble,% automatically remove the spaces to the left of the code
        linenos=true,% show line numbers
        fontsize=\footnotesize,% smaller font size
        % escapeinside=@@,% insert latex code between @ and @
        frame=lines,% frame styles: none or lines
        % numbers=both,% show line numbers on: left, right, both or none
        mathescape=true,% insert math code
    }%
    \setmintedinline{%
        fontsize=\normalsize,
    }%
\fi
\RequirePackage{tikz-uml}% tikz-uml for diagrams (class, use case,
                         % state transitions, sequence and component)
\ifxstringequal{\cuz@option@colortheme}{light}{
    \tikzumlset{%
        % text=white,
        % draw=white,
        % fill class=black!80,
        % fill template=blue!80,
        % fill note=darkgray!100,
        % fill package=black!80,
        font=\bfseries\ttfamily\tiny
    }
}{
    \tikzumlset{%
        text=white,
        draw=white,
        fill class=black!80,
        fill template=blue!80,
        fill note=darkgray!100,
        fill package=black!80,
        font=\bfseries\ttfamily\tiny
    }
}
\usetikzlibrary{%
    intersections,
    through,
    shapes.geometric,
    shapes.misc,
    positioning,
    calc,
    arrows,
    graphs,
    math
}
\ifxstringequal{\cuz@option@colortheme}{light}{
    \tikzstyle{terminal} = [
        rounded rectangle, thin,
        font = \ttfamily\footnotesize, 
        draw = black!50,
        text = black,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{nonterminal} = [
        rectangle, thin,
        font = \ttfamily\footnotesize,
        draw = black!50,
        text = black,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{status box} = [
        rounded rectangle, very thin,
        font = \tiny,
        draw = red!50!black!50,
        top color = black, bottom color = red!20!black!50,
        text = black,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{motion box} = [
        rectangle, minimum size = 3mm, very thin,
        font = \ttfamily\tiny,
        draw = blue!50!black!50,
        top color = black, bottom color = blue!20!black!50,
        text = black,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{comment box} = [
        rectangle, very thin,
        font = \ttfamily\footnotesize,
        text = black!70,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{point} = [ circle, inner sep = 0pt, minimum size = 0pt ] %
    \tikzstyle{skip loop} = [ to path = { -- ++(#1, 0) |- (\tikztotarget) } ]%
    \tikzstyle{hv path} = [ to path = { -| (\tikztotarget) } ] %
    \tikzstyle{vh path} = [ to path = { |- (\tikztotarget) } ] %
    \tikzstyle{every new ->} = [ shorten >= 1pt ] %
    \tikzstyle{graphs/every graph} = [ edges = rounded corners ] %
    \tikzstyle{every picture} += [remember picture]
    \tikzstyle{na} = [baseline = -.5ex]
}{
    \tikzstyle{terminal} = [
        rounded rectangle, thin,
        font = \ttfamily\footnotesize, 
        draw = black!50,
        text = white,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{nonterminal} = [
        rectangle, thin,
        font = \ttfamily\footnotesize,
        draw = black!50,
        text = white,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{status box} = [
        rounded rectangle, very thin,
        font = \tiny,
        draw = red!50!black!50,
        top color = black, bottom color = red!20!black!50,
        text = white,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{motion box} = [
        rectangle, minimum size = 3mm, very thin,
        font = \ttfamily\tiny,
        draw = blue!50!black!50,
        top color = black, bottom color = blue!20!black!50,
        text = white,
        text height = .7ex, text depth = .1ex
    ]%
    \tikzstyle{comment box} = [
        rectangle, very thin,
        font = \ttfamily\footnotesize,
        text = black!30,
        text height = 1.4ex, text depth = .25ex
    ]%
    \tikzstyle{point} = [ circle, inner sep = 0pt, minimum size = 0pt ] %
    \tikzstyle{skip loop} = [ to path = { -- ++(#1, 0) |- (\tikztotarget) } ]%
    \tikzstyle{hv path} = [ to path = { -| (\tikztotarget) } ] %
    \tikzstyle{vh path} = [ to path = { |- (\tikztotarget) } ] %
    \tikzstyle{every new ->} = [ shorten >= 1pt ] %
    \tikzstyle{graphs/every graph} = [ edges = rounded corners ] %
    \tikzstyle{every picture} += [remember picture]
    \tikzstyle{na} = [baseline = -.5ex]
}
\ifcuz@option@algorithm%
    \RequirePackage{algpseudocode,algorithm,algorithmicx}% algorithm support
    \algrenewcommand\ALG@beginalgorithmic{\footnotesize}% font size of algorithms
    \algrenewcommand\algorithmiccomment[2][\scriptsize\ttfamily]{
        {#1\hfill\(\triangleright\) #2}% font size of comments in algorithms
    }
    \captionsetup[algorithm]{font=footnotesize}% font size of algorithm captions
\fi%
\ifcuz@option@pgfplots%
    \usepackage{pgfplots}
    \usepgfplotslibrary{dateplot}
\fi%
%---------------------------------------------------------------------------%
%->> Customize the alignment of elements at the cover page
%---------------------------------------------------------------------------%
\setbeamertemplate{title}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \linespread{1.0}%
    \inserttitle%
    \par%
    \vspace*{0.5em}%
}
\setbeamertemplate{subtitle}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \insertsubtitle%
    \par%
    \vspace*{0.5em}%
}
\newcommand{\email}[1]{\gdef\cuz@email{#1}}%
\setbeamertemplate{author}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \vspace*{2em}%
    \insertauthor%
    \par%
    {\scriptsize \href{mailto:\cuz@email}{\itshape \cuz@email}}%
    \par%
    \vspace*{0.25em}%
}
\setbeamertemplate{date}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \insertdate%
    \par%
}
\setbeamertemplate{institute}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \vspace*{0.02em}%
    \insertinstitute%
    \par%
}
%---------------------------------------------------------------------------%
\endinput%
