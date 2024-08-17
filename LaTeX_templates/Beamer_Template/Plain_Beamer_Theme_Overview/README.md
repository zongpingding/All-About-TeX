# LaTeX-Beamer-Theme-Overview

Go to the [Overview](OVERVIEW.md)

This repository contains an overview of many of the
Beamer themes that come with the current TeX Live
distribution.

I have used all themes that can be loaded using \usetheme{}.
Some of the themes complain about missing images, however
I run lualatex in batch mode, so these errors are ignored
during compilation.

Did I miss a theme? Please create an issue to inform me.


# Technical Implementation

For each theme there is a Presentation-<theme>.tex.
In each file I use the command \usetheme{\gettwofromjobname}
to get the <theme> component of the filename to load
the theme.

Using Python I run all Presentation-<theme>.tex files through
pdflatex twice (to create the respective table of content)
and then use imagemagick to create the PNG images of the PDFs.


