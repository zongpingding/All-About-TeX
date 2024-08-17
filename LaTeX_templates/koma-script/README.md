# KOMA-Script 2023/07/07 v3.41 
Copyright [Markus Kohm](mailto:komascript@gmx.info) 1994–2023

This material is subject to the LaTeX Project Public License Version 1.3c. See [`lppl.txt`](lppl.txt) (English) or [`lppl-de.txt`](lppl-de.txt) (German) for the details of that license.

------------------------------------------------------------------------------

KOMA-Script is a versatile bundle of LaTeX2e document classes and packages. The classes are designed as replacements to the standard LaTeX2e classes. Several features have been added to make them more configurable.

------------------------------------------------------------------------------

## Classes and packages in this release:

### `koma-script-source-doc` — internal source documentation class of KOMA-Script
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       koma-script-source-doc is an internal LaTeX class of the
                KOMA-Script bundle. It is an extension of ltxdoc.
                KOMA-Script uses scrdoc for the implementation documentation
                and the documentation of packages that aren't KOMA-Script core
                packages.  The user manual of this class can be generated from
                koma-script-source-doc.dtx.  However average users should not
                need the user manual, because they should never use this
                internal class.
Requires:       ltxdoc   - the LaTeX2e source documentation class
                doc.sty  - at least version 3.0 is needed
                scrartcl - the KOMA-Script article class
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2022-07-08 v0.92 
</pre>
***

### `scraddr` — Package to provide data from scrlttr2's adr-files
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scraddr is a LaTeX package of the KOMA-Script bundle.
                scrlttr2 uses adr-files to create form letters. The scraddr
                package provides commands to read such files and to use the
                data of the address entries not only with the scrlttr2 class
                and not only for form letters.
Requires:       
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2022/01/24 v1.1d 
</pre>
***

### `scrartcl` — versatile class may be used as a drop-in replacement of article
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrartcl is a LaTeX class of the KOMA-Script bundle. It is
                the KOMA-Script drop-in replacement for the standard LaTeX
                article class. It provides all options, environments,
                counters, lengths and commands of the standard LaTeX article
                class, as well as several additional options, environments,
                commands, etc. to make it much more versatile. The default
                layout of scrartcl differs from article, with an emphasis on
                good typography. Nevertheless, by changing the defaults, you
                can achieve a layout very similar to that of the standard
                class.
Requires:       scrkbase - internal KOMA-Script package
                tocbasic - KOMA-Script package
                typearea - KOMA-Script package
Recommended:    scrlayer-scrpage - KOMA-Script package
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrarticle` — wrapper class to scrartcl
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrreport is a very simple wrapper class to scrartcl. It has
                been made, because several younger KOMA-Script users do not
                understand the 8.3 name scheme.

                However it is still recommended to use scrartcl instead of
                scrarticle.
Requires:       scrartcl.cls - KOMA-Script class
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrbase` — basic features for KOMA-Script, e.g. conditionals and key=value
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrbase is a LaTeX package of the KOMA-Script bundle.  It
                provides some basic functions used by KOMA-Script that can
                also be used by authors and users of other classes and
                packages.

                First, it provides extended handling of key=value pairs
                that can be used for run-time options of classes and
                packages. Several packages in a family can share options,
                and all the options in a family can be changed with a
                single command.

                Additional conditions like \ifundefinedorrelax, \ifpdftex,
                \ifVTeX, \ifpdfoutput, \ifstr etc. are provided. Most of
                them can be prevented from being defined and have
                additional internal representations that can be used by
                package or class authors.

                It also provides commands to easily define or change
                language-dependent terms that work not only with babel but
                with other packages like ngerman too.

                It provides some commands for package and class authors
                missing in the LaTeX kernel like \ClassInfoNoLine,
                \PackageInfoNoLine or \l@addto@macro.

                Last but not least, it provides commands for integer
                division and integer modulo operation that can be used,
                for example, inside \numexpr ...\relax or with \ifnum.
Requires:       keyval   - key=value package from the graphics bundle
                scrlfile - KOMA-Script package for file loading 
                           manipulation
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrbook` — versatile class may be used as a drop-in replacement of book
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrbook is a LaTeX class of the KOMA-Script bundle and a
                drop-in replacement for the standard LaTeX book class. It 
                provides all options, environments, commands, etc. of the
                standard LaTeX book class, as well as several additional 
                options, environments, commands, etc. to make it much more
                versatile. The default layout of scrbook differs from book,
                with an emphasis on good typography. Nevertheless, by changing
                the defaults, you can achieve a layout very similar to that
                of the standard class.
Requires:       scrkbase - internal KOMA-Script package
                tocbasic - KOMA-Script package
                typearea - KOMA-Script package
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrdate` — calender date operations, e.g. calculation of the day of the week
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrdate is a LaTeX package of the KOMA-Script bundle. It
                provides several operations with calender dates, e.g., show
                the century or the decade of a year, calculate the day of
                the week of a given calender date, show the current
                calender date in ISO form. It has support for several
                languages, including English, German, French, Italian,
                Spanish, Croatian, Finnish, Norsk, Swedish, Danish, Polish,
                Czech, and Slovak.
Requires:       scrkbase - KOMA-Script package for some basic features.
                scrlfile - KOMA-Script package for file loading
                           manipulation
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrdoc` — deprecated internal source documentation class of KOMA-Script
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrdoc is an internal LaTeX class of the KOMA-Script bundle.
                It is an extension of ltxdoc with version 2 of the doc
                package.  KOMA-Script has used scrdoc for the implementation
                documentation before KOMA-Script 3.36.
Requires:       ltxdoc   - the LaTeX2e source documentation class
                scrartcl - the KOMA-Script article class
License:        LPPL 1.3c or later
State:          deprecated, will be removed soon
Version:        2022/06/24 v0.1j 
</pre>
***

### `scrextend` — make some features of the KOMA-Script classes available for others
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrextend is a LaTeX package of the KOMA-Script bundle. It
                makes some features of the KOMA-Script classes available to
                other classes, i.e., for the standard classes.
Requires:       scrkbase - internal package with some basics of KOMA-Script
                etoolbox - tool-box for LaTeX programming using e-TeX
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrfontsizes` — package to generate a KOMA-Script font size file
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrfontsizes is a LaTeX package of the KOMA-Script bundle.  
                It provides a simple interface to generate KOMA-Script
                font-size files.
Requires:       scrextend - some KOMA-Script features for other classes
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrhack` — patch some isues with other packages
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrhack is a LaTeX package of the KOMA-Script bundle. It
                patches other packages to make them work better and adds new
                features to improve their interaction with KOMA-Script. One
                main feature is to make them work with tocbasic instead of
                KOMA-Script's deprecated float list interface. Currently,
                patches for float.sty, floatrow.sty, (old versions of)
                hyperref, listings, and setspace are available.
Requires:       scrkbase - internal KOMA-Script package with basics
                tocbasic - features for helper files and float environments
                xpatch - extending etoolbox patching commands
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrjura` — contract environment for advocates and scholary persons in law
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrjura is a LaTeX package of the KOMA-Script bundle.  It
                has been made in cooperation with a German lawyer to
                provide environments for contracts, laws, acts or other
                legal purposes. It supports automatic numbering of
                paragraphs and semi-automatic numbering of sentences.
                Currently German and English are supported.
Requires:       scrkbase - internal KOMA-Script package with basics
                tocbasic - features for helper files and float environments
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrkbase` — internal basic features for KOMA-Script classes and packages
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrkbase is an internal KOMA-Script packages that provides
                some features that are common to several KOMA-Script
                classes and packages. Users and class or package authors
                should not use this package directly.
Requires:       scrbase  - KOMA-Script package for some basic features.
                scrlfile - KOMA-Script package for file loading
                           manipulation
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlayer-notecolumn` — control note columns parallel to the main text
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlayer-notecolumn is a LaTeX package of the KOMA-Script
                bundle. It provides an end-user interface to scrlayer to
                define and manage note columns. Those note columns are
                somewhat similar to marginal notes (see the LaTeX
                command \marginpar or packages like notecolumn), but you
                can use several of them. The package provides page breaks
                inside note columns and synchronization points between the
                main text and note columns.

                Like most of the KOMA-Script packages, you can use this
                package not only with KOMA-Script classes but also with
                several other classes, e.g., the standard LaTeX classes.
Requires:       scrlayer.sty
License:        LPPL 1.3c or later
State:          Author maintained, proof of concept
Version:        2023/04/17 v0.3.4032 
</pre>
***

### `scrlayer-scrpage` — controlling page headers and footers
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlayer-scrpage is a LaTeX package of the KOMA-Script
                bundle. It provides an end-user interface to scrlayer to
                define and manage page styles. This end user interface is
                sufficiently compatible to scrpage2 that users should easily
                be able to switch from the old scrpage2 package to the new
                one. Nevertheless, it provides several new features to control
                headers and footers.

                Like most of the KOMA-Script packages, you can use this
                package not only with KOMA-Script classes but also with
                several other classes, e.g., the standard LaTeX classes.
Requires:       scrlayer.sty
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlayer` — defining layers and controlling page headers and footers
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlayer is a LaTeX package of the KOMA-Script bundle.
                Users may already be familiar with a type of layer from
                packages like eso-pic or textpos. scrlayer is another package
                that provides background and foreground layers, but unlike
                those other packages, these layers are part of the page-style
                definition. With this package, you can easily switch between
                the layers used by switching the page style.

                In short, the page-style interface of scrlayer provides
                commands to define page styles based on a stack of layers and
                to manage those layer stacks. 

                Nevertheless, using the layers directly is recommended for
                advanced users only. End-user interfaces for beginners or
                average users are provided by additional packages, that
                load scrlayer on their own, e.g., scrlayer-scrpage.
Requires:       scrkbase.sty
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrletter` — wrapper class to scrartcl class + scrletter package
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrletter is a wrapper class to class scrartcl with package
                scrletter. Is has been made, to provide a letter class, that
                also supports features like sections and floats.
Requires:       scrartcl.cls  – KOMA-Script class
                scrletter.sty – KOMA-Script package
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrletter` — letter extention to KOMA-Script classes
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrletter provides the features of the letter class scrlttr2
                when using the KOMA-Script classes scrartcl, scrreprt, and
                scrbook, or the standard classes article, report, and book.
Requires:       scrkbase - internal KOMA-Script package
                typearea - KOMA-Script package
                scrlayer-scrpage - KOMA-Script package
Recommended:    marvosym - package by Martin Vogel providing symbols
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlfile-hook-3.34` — internal subpackage of scrlfile
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlfile-hook-3.34 is an internal subpackage of scrlfile to
                be used with LaTeX from version 2020-10-01, but before
                version 2021-11-15.
Requires:       scrlogo.sty
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlfile-hook` — internal subpackage of scrlfile
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlfile-hook is an internal subpackage of scrlfile to be
                be used with LaTeX from version 2021-11-15 on.
Requires:       scrlogo.sty
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlfile-pacholdlatex` — internal subpackage of scrlfile
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlfile-patcholdlatex is an internal subpackage of scrlfile
                to be be used with LaTeX up to version 2010-04-01.
Requires:       scrlogo.sty
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlfile` — control of package dependencies
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlfile is a LaTeX package of the KOMA-Script bundle. It
                provides the ability to execute commands before or after
                loading files, classes, or packages. It can even
                automatically load one file, class, or package in place of
                another or prevent a package from being loaded. It also
                provides the ability to execute commands before or after
                closing the main aux file during \end{document}. It has
                been used by the KOMA-Script classes for more than a
                decade.
Requires:       scrlfile-hook.sty, scrlfile-patcholdlatex.sty, scrlogo.sty
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlogo` — print the KOMA-Script logo
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlogo is a LaTeX package of the KOMA-Script bundle. It
                provides the command \KOMAScript to print the official
                KOMA-Script logo.
Requires:
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrlttr2` — versatile letter class with separation of text area and note paper
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrlttr2 is a letter class for LaTeX2e that allows
                definition of several letterheads and text area settings
                that are independent from the letterhead. So you can use
                not only the KOMA-Script package typearea but even packages
                like geometry to define the text area and the margins.

                The positions of the elements of the letterhead can be
                changed by so called pseudo-lengths. This makes it possible
                to adjust scrlttr2 not only to local conventions and paper
                sizes but also to a corporate brand identity.

                Several predefined sets of parameters, called
                letter-class-option or lco files are part of the
                KOMA-Script bundle: two German letters, Swiss letters, US
                letters, Japanese letters, and French letters.  More can be
                found on CTAN or the KOMA-Script homepage as separate
                packages.

                Additional lco-files for different letterheads can be found
                on the KOMA-Script homepage, e.g., one demonstration file
                for a letterhead similar to that of Washington State
                University.
Requires:       scrkbase - internal KOMA-Script package
                typearea - KOMA-Script package
Recommended:    marvosym - package by Martin Vogel providing symbols
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrreport` — wrapper class to scrreprt
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrreport is a very simple wrapper class to scrreprt. It has
                been made, because several younger KOMA-Script users do not
                understand the 8.3 name scheme.

                However it is still recommended to use scrreprt instead of
                scrreport.
Requires:       scrreprt.cls - KOMA-Script class
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrreprt` — versatile class may be used as a drop-in replacement of report
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrreprt is the KOMA-Script drop-in replacement for the
                standard LaTeX report class. It provides all options,
                environments, counters, lengths, and commands of the standard
                LaTeX report class, as well as several additional options,
                environments, commands, etc., to make it much more versatile.
                The default layout of scrreprt differs from that of report,
                with an emphasis on good typography. Nevertheless, by changing
                the defaults, you can achieve a layout very similar to that of
                the standard class.
Requires:       scrkbase - internal KOMA-Script package
                tocbasic - KOMA-Script package
                typearea - KOMA-Script package
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `scrtime` — show the time of the LaTeX run
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       scrtime is a LaTeX package of the KOMA-Script bundle.  It
                provides only some small features to show the time of the
                LaTeX run.
Requires:       scrkbase - internal package with some basics of KOMA-Script
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `tocbasic` — Management of tables and lists of contents using helper files
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       tocbasic is a LaTeX package of the KOMA-Script bundle.  The
                main purpose of package tocbasic is to provide features for
                authors of classes and packages to create their own tables or
                lists of contents like the list of figures and the list of
                tables, and thereby allow other classes or packages some
                measure of control over these. For example, the tocbasic
                package delegates control of the language for all these tables
                and lists of contents to the babel package. Thus changes of
                language will be automatically reflected inside all these
                tables and lists of contents. Using tocbasic will free
                authors of classes and packages from the burden of
                implementing of such features.

                KOMA-Script itself uses tocbasic not only for the table of
                contents but also for the lists of figures and tables
                mentioned previously.
Requires:       scrbase  - KOMA-Script package for some basic features.
License:        LPPL 1.3c or later
State:          Author maintained
Version:        2023/07/07 v3.41 
</pre>
***

### `typearea` — Calculating typeing area and margins depending on typographic rules
<pre>
Maintainer:     Markus Kohm
E-Mail:         komascript@gmx.info
Abstract:       Many LaTeX classes, including the standard classes, present 
                the user with the largely fixed configuration of margins
                and type area.  With the standard classes, the choice is
                limited to selecting a font size. There are separate packages,
                such as geometry, which give the user complete control over,
                but also full responsibility for, setting the type area and
                margins.

                KOMA-Script takes a somewhat different approach with its
                typearea package. Users are offered ways to adjust the design
                and algorithms based on established typographic standards,
                making it easier for them to make good choices.
Requires:       scrkbase - internal basic features for KOMA-Script packages
License:        LPPL 1.3c or later
State:          Autor maintained
Version:        2023/07/07 v3.41 
</pre>
***

## Installation:

We highly recommend installing the latest official release via the package manager of the TeX distribution you are using. For example, for Vanilla TeX Live this would be `tlmgr` or `tlshell` or `tlcockpit`. For MiKTeX it would be `MiKTeX Console`. Linux users who use the TeX Live of their Linux distribution will often find KOMA script in one of the many TeX Live supplementary packages. In Debian, for example, it is in `texlive-latex-recommended`.

If the package manager does not offer the desired KOMA-Script version, you can find [various versions in the KOMA-Script Project](https://komascript.de/current). There is also the installation from a TDS archive explained.

From KOMA-Script sources of a [release on SourceForge](https://sourceforge.net/p/koma-script/code/HEAD/tree/tags/) one can build and even install KOMA-Script with the help of `l3build`. More details can be found in the instructions for `l3build`.

If you want to generate KOMA-Script step by step from the sources, first run `tex scrmain.ins`. This will generate a larger number of files with the extensions `.cls`, `.sty`, `.lco`, `.clo` and `.hak`. All these files are needed for KOMA-Script to work properly. They have to be copied either into the document directory of your LaTeX project or into a directory of one of your TEXMF search trees. In the TEXMF search tree further actions may be necessary. Consult the instructions of your TeX distribution. After the correct installation of these files, the manual is to be generated. To do this, change to the subdirectory `/doc` and first run `pdflatex scrguide-en.tex` there. Then repeat the runs of `bibtex scrguide-en`, `makeindex scrguide-en`, `pdflatex scrguide-en.tex` min. four times. This way you get a form of the English user manual with a simplified index. The German user manual can be generated in the same way by substituting `scrguide-en` for `scrguide-de`.

If you like to have the implementation documentation of KOMA-Script as a PDF, first create the required class `koma-script-source-doc.cls` with `tex koma-script-source-doc.dx`. This class can then be used to generate the implementation documentation of this class with repeated calls to `lualatex-dev koma-script-source-doc.dtx` and `mkindex koma-script-source-doc`. Correspondingly, the documentation of the other KOMA-Script components can be generated.
