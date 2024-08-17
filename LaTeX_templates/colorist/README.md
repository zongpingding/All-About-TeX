<!-- Copyright (C) 2021-2023 by Jinwen XU -->

# `colorist` bundle: write you documents in a colorful way

> **New documentations are being written and are expected to be completed by the end of 2023. In the meantime, only the core code would be included in TeX Live 2023 coming this April (old documentations have been removed from the distribution).**

## Introduction

`colorist` is a collection of styles and classes that helps you to typeset articles and books with a colorful design.

It mainly consists of two parts.

- Main part:
    - `colorist.sty` : interface of the main style
        - `colorist-fancy.sty` : the style "fancy"
        - ... and more styles to come (currently on schedule: "plain", "classical", "modern", "simple", "elegant", "flow", "stream")
    - `colorart.cls` : class for typesetting articles
    - `colorbook.cls` : class for typesetting books

    They can be used with any major TeX engine. Currently they have native
    support to English, French, German, Italian, Portuguese
    (European and Brazilian) and Spanish typesetting.


- Derivative part:
    - `lebhart.cls` : enhanced version of `colorart`
    - `beaulivre.cls` : enhanced version of `colorbook`

    They are similar to the main classes, but have Unicode support, thus can
    only be used with either XeLaTeX or LuaLaTeX. Currently, they have native
    support to Chinese (simplified and traditional), English, French, German,
    Italian, Japanese, Portuguese (European and Brazilian), Russian and Spanish
    typesetting, and also use more beautiful fonts.

### How to get these files
You can get the `.sty` and `.cls` files mentioned above simply by compiling
`colorist.ins`:
```
latex colorist.ins
```
To get the `.tex` source files of the documentation, compile `colorist-doc.ins`:
```
latex colorist-doc.ins
```

## Features

Compared with usual document classes, it has the following features:

- Several carefully designed styles
- Native multi-language support: Chinese (simplified and traditional), English, French, German, Italian, Japanese, Portuguese (European and Brazilian), Russian and Spanish
    > In particular, for simplified Chinese, traditional Chinese and Japanese, the fonts of the corresponding glyphs can be automatically switched
- Ready-to-use theorem-like environments, with clever referencing support
- Support both the standard and the AMS writing fashion
- ... and so much more...


# License

This work is released under the LaTeX Project Public License, v1.3c or later.
