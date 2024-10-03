# l3duild intro
## preface
> This article **DOES NOT** include any material on `dtx` writing or `l3build` for `dtx` files.



## Why we need l3build ?
* when you are developing a complex package or class: there are many commands in it, while that some later commands may affect the previous ones.
Then you shoud make sure the previous commands still work after you add new commands. Thus, you need a **test system**.
* when package(class) `A` relys on package(class) `B`, and you change something in `B`, you should make sure that `A` still works after the change. Thus, you need a **test system** to test functions in `A` as well.


## Setup
### build script
Create a file `build.lua` in the root directory of your project, which specifies the build process


### write test file
Create your test files in `testfiles` directory, this folder can be set in `build.lua` by variable `testfiledir`, the default is `./testfiles`. The default test file extention should be `.lvt`, but i change it to `.tex` in the following Example project.

#### how to enable test ?
Just add file `regression-test.tex` in your test file, then you can use the test commands provided by `l3build`. Some remarks about the `regression-test.tex`:
> Test files are written in a `TEX dialect` using the support file `regression-test.tex`, which should be `\input` at the **very beginning** of each test. Additional customizations to this driver can be included in a local `regression-test.cfg` file, which will be loaded automatically if found.

Here is a test file template:
```latex
\input{regression-test.tex}
\documentclass{article}
\usepackage{expl3}
\START
% your test code here
\ExplSyntaxOff
\END
```

See later for more details about the test commands provided by `l3build`.

> **Warning:** If you use the wrong syntax and using `l3build save <test-file-name>` to generate the `*.tlg` file in your `testfile` dir, then following `l3build check` will pass Even the commands is wrong.


#### commands for test
The `l3build` provides a series of commands for package or class writer to write test. Here i list some mostlt used commands:

* `\START ... \END`: start and end the test
* `\SEPARATOR` inserts a long line of = symbols to break up the log output
* `\TRUE`, `\FALSE`, `\YES`, `\NO` output those strings to the log file.
* `\TEST{⟨title⟩}{⟨contents⟩}` command runs its `⟨contents⟩` in a group and surrounds the generated log lines with some `\SEPARATOR`s and a `⟨title⟩`.
* `\TESTEXP{⟨title⟩}{⟨contents⟩}` surrounds its `⟨contents⟩` with `\TYPE` and formatting to match `\TEST`;
* `\BEGINTEST{⟨title⟩} . . . \ENDTEST` is an environment form of `\TEST`, allowing **verbatim** material, etc. to appear.
* `\ASSERT{⟨arg1⟩}{⟨arg2⟩}` and `\ASSERTSTR{⟨arg1⟩}{⟨arg2⟩}` Test if the full expansion of `⟨arg1⟩` and `⟨arg2⟩` are the same: on a **token** basis in `\ASSERT` and on a **string** basis in `\ASSERTSTR`. Depending on the outcome, record either `PASSED` or `FAILED` in the `.log`.

> * Command `\START` tolds the test system that the `useful` part of the `.log` has started (for that there is lots of material in a raw log that you don't want). and `\END` tells the system that the `useful` part of the `.log` has ended. (You can use `\OMIT ... \TIMO` to ignore parts of the log as well)
> * `\TYPE` is used to write material to the `.log` file, like LaTeX `\typeout`, but it allows **long** input. 

An example of these commands:
```latex
\TEST{bool_set,~lazy~evaluation}{
  \bool_set:Nn \l_tmpa_bool
  {
    \int_compare_p:nNn 1=1 && \bool_lazy_any_p:n
    {
      { \int_compare_p:nNn 2=3 }
      { \int_compare_p:nNn 4=4 }
      { \int_compare_p:nNn 1=\ERROR } % is skipped
    }
    && \int_compare_p:nNn 2=2
  }
  \bool_if:NTF \l_tmpa_bool \TRUE \FALSE
}
```

the output (compiled by `pdflatex` not `l3build`):
``` latex
==========================================
TEST 8: bool_set, lazy evaluation
==========================================
TRUE
==========================================
```

#### test box 
There is an example from official documentation:
```latex
\input{regression-test.tex}
\documentclass{article}
\usepackage{expl3}
\START
\ExplSyntaxOn
    \box_new:N \l_tmp_box
    \hbox_set:Nn \l_tmp_box {hello~ \emph{world}~ $a=b+c$}
    \box_show:N \l_tmp_box
\ExplSyntaxOff
\END
```

will generate:
```shell
START-TEST-LOG

This is a generated file for the l3build validation system.

Don't change this file in any respect.

> \box52=
\hbox(6.94444+0.83333)x91.35481
.\OT1/cmr/m/n/10 h
.\OT1/cmr/m/n/10 e
.\OT1/cmr/m/n/10 l
.\OT1/cmr/m/n/10 l
.\OT1/cmr/m/n/10 o
.\glue 3.33333 plus 1.66666 minus 1.11111
.\OT1/cmr/m/it/10 w
.\OT1/cmr/m/it/10 o
.\OT1/cmr/m/it/10 r
.\OT1/cmr/m/it/10 l
.\OT1/cmr/m/it/10 d
.\kern 1.03334
.\glue 3.33333 plus 1.66666 minus 1.11111
.\mathon
.\OML/cmm/m/it/10 a
.\glue(\thickmuskip) 2.77771 plus 2.77771
.\OT1/cmr/m/n/10 =
.\glue(\thickmuskip) 2.77771 plus 2.77771
.\OML/cmm/m/it/10 b
.\glue(\medmuskip) 2.22217 plus 1.11108 minus 2.22217
.\OT1/cmr/m/n/10 +
.\glue(\medmuskip) 2.22217 plus 1.11108 minus 2.22217
.\OML/cmm/m/it/10 c
.\mathoff

! OK.
<argument> \l_tmp_box 
                      
l.43     \box_show:N \l_tmp_box
                               

END-TEST-LOG

 )
(see the transcript file for additional information)
No pages of output.
```



#### test entire page 
A simple example:
```latex
\input{regression-test.tex}
\documentclass{article}
\usepackage{expl3}
\START
\showoutput
% Test content here
\vfil\break
\END
```

This code will generate a pdf, the output log:
```shell 
START-TEST-LOG

This is a generated file for the l3build validation system.

Don't change this file in any respect.


END-TEST-LOG

 )
No pages of output.
```


#### output normalization
Eliminate the differences between different systems. Consist of 2 parts:
* removing ignoring lines
    * Lines before the `\START`, after the `\END `and within `\OMIT/\TIMO` blocks
    * Entirely blank lines, including those consisting only of spaces.
    * Lines starting `\openin` or `\openout`.
    * lines loading  `*.fd` files.
* modify others to give consistent test output
    * Removal spaces at the start of lines
    * Removal of ./ at start of file names.
    * ... etc

> see the documentation for more details




### test reference
There are many test goals (kinds), in the following example project, we use the `log-based test`. The default extention of your test file is `.lvt`.

> l3build doc: A standard test will run the file ⟨name⟩.lvt using one or more engines, but will not carry out any additional processing.

What if we want a complex test goal ? See the `l3build doc`, it says that:
> Regression tests check whether changes introduced in the code modify the test output. Especially while developing a complex package there is not yet a baseline to save a test goal with. It might then be easier to formulate the expected effects and outputs of tests directly. To achieve this, you may create an `.lve` instead of a `.tlg` file.

if the `.tlg` file not exsit, `l3build check` will throw an error:
```shell
Error: failed to find any reference or expectation file for test1!
```

How to setup the (default) test reference ? Create and Save your `test reference` by running:
```shell
l3build save <test-file-name>
```

Then a `<test-file-name>.tlg` file will be created in your `testfiledir`. The `⟨name⟩.tlg` file is then used in all subsequent checks against the `⟨name⟩.lvt` test.


### run tests
Run the tests by running `l3build check <tlg-file-name>` or `l3build check`, then the test files will be compared with the saved reference 


## Example
### project structure
The initial project structure:
```shell
├── build.lua
├── testfiles
│   └── test1.tex
└── TESTpkg.sty
```

The build file `build.lua`:
```lua
-- package Identity
module = "TESTpkg"
sourcefiles = {"TESTpkg.sty"}

-- check opts
checkengines = {"pdftex"}
lvtext = ".tex"
```

See problem [Impossible to run l3build tests](https://tex.stackexchange.com/q/680682/294585), that nowadays, you don't need 
```lua 
kpse.set_program_name ("kpsewhich")
dofile(kpse.lookup("l3build.lua"))
```

in your `build.lua`, the test package is `TESTpkg.sty`:
```latex
\NeedsTeXFormat{LaTeX2e}[2018-04-01]
\RequirePackage{expl3}
\ProvidesExplPackage{TESTpkg}{2024-09-16}{2024A}{Test package for l3build}


\NewDocumentCommand{\cmdA}{o}{
  FIRST~ Argument~ is:~#1
}
```

The first test file: `test1.tex`
```latex
\documentclass{article}
% load regression test tools
\input{regression-test.tex}

% load your package
\usepackage{TESTpkg}


\begin{document}
\START
\TEST{command~cmdA~Test}{\cmdA[ARG-ONE]}
\END
\end{document}
```

### save test reference
The first run of `l3build save test1` print log:
```shell
$ l3build save test1
Creating and copying test1.tlg
This is pdfTeX, Version 3.141592653-2.6-1.40.26 (TeX Live 2024/Arch Linux) (preloaded format=pdflatex)
 restricted \write18 enabled.
 (./ascii.tcx)
entering extended mode
LaTeX2e <2023-11-01> patch level 1
L3 programming layer <2024-02-20>
(./test1.tex (/usr/share/texmf-dist/tex/latex/base/article.cls
Document Class: article 2023/05/17 v1.4n Standard LaTeX document class
(/usr/share/texmf-dist/tex/latex/base/size10.clo)) (/usr/share/texmf-dist/tex/latex/l3build/regression-test.tex{/var/lib/texmf/fonts/map/pdftex/updmap/pdftex.map}) (./TESTpkg.sty (/usr/share/texmf-dist/tex/latex/l3kernel/expl3.sty (/usr/share/texmf-dist/tex/latex/l3backend/l3backend-pdftex.def)))
No file test1.aux.

START-TEST-LOG


This is a generated file for the l3build validation system.

Don't change this file in any respect.


============================================================
TEST 1: command~cmdA~Test
============================================================
============================================================


END-TEST-LOG

 )
No pages of output.
Transcript written on test1.log.
```

After this first run of `l3build save`, your project structure will be:
```shell
├── build
│   ├── local
│   ├── result
│   ├── test
│   │   ├── ascii.tcx
│   │   ├── test1.log
│   │   ├── test1.pdftex.aux
│   │   ├── test1.tex
│   │   ├── test1.tlg
│   │   └── TESTpkg.sty
│   └── unpacked
│       └── TESTpkg.sty
├── build.lua
├── testfiles
│   ├── test1.tex
│   └── test1.tlg
└── TESTpkg.sty
```


### running test
The first run of `l3build check test1` print log:
```shell
 > l3build check test1
Running checks on
  test1 (1/1)
This is pdfTeX, Version 3.141592653-2.6-1.40.26 (TeX Live 2024/Arch Linux) (preloaded format=pdflatex)
 restricted \write18 enabled.
 (./ascii.tcx)
entering extended mode
LaTeX2e <2023-11-01> patch level 1
L3 programming layer <2024-02-20>
(./test1.tex (/usr/share/texmf-dist/tex/latex/base/article.cls
Document Class: article 2023/05/17 v1.4n Standard LaTeX document class
(/usr/share/texmf-dist/tex/latex/base/size10.clo)) (/usr/share/texmf-dist/tex/latex/l3build/regression-test.tex{/var/lib/texmf/fonts/map/pdftex/updmap/pdftex.map}) (./TESTpkg.sty (/usr/share/texmf-dist/tex/latex/l3kernel/expl3.sty (/usr/share/texmf-dist/tex/latex/l3backend/l3backend-pdftex.def)))
No file test1.aux.

START-TEST-LOG


This is a generated file for the l3build validation system.

Don't change this file in any respect.


============================================================
TEST 1: command~cmdA~Test
============================================================
============================================================


END-TEST-LOG

 )
No pages of output.
Transcript written on test1.log.

  All checks passed
```

Or you can simply run `l3build check`:
```shell 
$ l3build check
Running checks on
  test1 (1/1)

  All checks passed
```

### If something change ?
#### change the package
If i change the command `\cmdA` in package `TESTpkg.sty` to:
```latex
\NewDocumentCommand{\cmdA}{om}{
  FIRST~ Argument~ is:~#1
}
```

then run `l3build check`, you will get:
```shell
$ l3build check
Running checks on
  test1 (1/1)
          --> failed


  Check failed with difference files
  - ./build/test/test1.pdftex.diff
```

deep into the file `./build/test/test1.pdftex.diff`, you will see:
```shell
*** ./build/test/test1.tlg	2024-09-16 16:21:01.131042370 +0800
--- ./build/test/test1.pdftex.log	2024-09-16 16:21:01.543042372 +0800
***************
*** 3,6 ****
  ============================================================
  TEST 1: command~cmdA~Test
  ============================================================
! ============================================================
--- 3,6 ----
  ============================================================
  TEST 1: command~cmdA~Test
  ============================================================
! Bad grouping: 2!
```

#### change the test file
If we change the test file to:
```latex 
\documentclass{article}
% load regression test tools
\input{regression-test.tex}

% load your package
\usepackage{TESTpkg}


\begin{document}
\START
\TEST{command~cmdA~Test}{\cmdA[ARG-ONE]Change-Here}
\END
\end{document}
```

this test still pass.

### remove temporary
Use `l3build clean` to remove the test tempoaray files. 



## l3build check mechanism
### file extention
`.lvt(est)`: Extension of log-based test files. `.tlg` will be its `reference or expectation file` and will be generated.
`.lve(xpectation)`: Extension of auto-generating test file output, 
`.pvt`: Extension of PDF-based test files, `.tpf` will be its `reference or expectation file` and will be generated.


There are some different test systems examples below.

> We don't pack tests inside source files, like `docstrip`.

### syntax base test system
`l3build check` will automatically check the syntax error, if the latter macro causes a syntax error. The output log will be like:
```shell 
--- 3,6 ----
  ============================================================
  TEST 1: command~cmdA~Test
  ============================================================
! Bad grouping: 2!
```

in the file `test1.pdftex.diff` as the before Test Example.



### log base test system
The test system use the file `*.tlg` to check, that is, if the original log is:
```shell
This is a generated file for the l3build validation system.
Don't change this file in any respect.
============================================================
TEST 1: LVTtest
============================================================
TRUE
============================================================
```

If we change it to:
```shell 
This is a generated file for the l3build validation system.
Don't change this file in any respect.
============================================================
TEST 1: LVTtest
============================================================
FALSE
============================================================
```

Then the `l3build check` will throw an `check fail`. To better understand the `log basis test`, there is a simple example:
```latex
% LVTtest.lvt
...
\START
\TEST{LVT Test}{
  hbox_set:Nn \l_tmpa_box {\cmdA[ARG-ONE]}
  \typeout{hello}
}
\END
```

and the original `LVTtest.tlg` file is:
```shell
This is a generated file for the l3build validation system.
Don't change this file in any respect.
============================================================
TEST 1: LVTtest
============================================================
TRUE
============================================================
```

Absolutely, the check will fail, but if we change the `LVTtest.lvt` to:
```latex
% LVTtest.lvt
...
\START
\TEST{LVT Test}{
  hbox_set:Nn \l_tmpa_box {\cmdA[ARG-ONE]}
  \typeout{TRUE}
}
\END
```

the check will pass. The other show command like `\box_show:N`, `\tl_show:N` works silimar to `\typeout`. 



### pdf base test system
The test system use the file `*.tpf` to check. An simple example, create a file `PVTtest.pvt` as:
```latex 
\input{regression-test.tex}
\documentclass{minimal}
\begin{document}

\begin{verbatim}
   ZZZ
\end{verbatim}

\end{document}
```

then after save it reference by `l3build save PVTtest`, `PVTtest.tpf` will be create in both `testfiledir/` and `build/test/`, the content like:
```shell 
%PDF-1.5
%����
3 0 obj
<<
/Length 49        
>>
stream
BT
/F37 9.9626 Tf 87.691 759.927 Td [(ZZZ)]TJ
ET
endstream
endobj
2 0 obj
<<
/Type /Page
/Contents 3 0 R
/Resources 1 0 R
/MediaBox [0 0 595.276 841.89]
/Parent 5 0 R
>>
endobj
...
```

If i change the `PVTtest.pvt` to:
```latex 
\input{regression-test.tex}
\documentclass{minimal}
\begin{document}

\begin{verbatim}
   ZZ
\end{verbatim}

\end{document}
```

the chech will fail, the log is:
```shell
Running checks on
  LVTtest (1/2)
  PVTtest (2/2)
          --> failed


  Check failed with difference files
  - ./build/test/PVTtest.pdftex.diff
```

the diff file contains:
```shell 
*** ./build/test/PVTtest.tpf	2024-09-16 18:39:04.155042603 +0800
--- ./build/test/PVTtest.pdftex.pdf	2024-09-16 18:39:04.567042596 +0800
***************
*** 2,12 ****
  %����
  3 0 obj
  <<
! /Length 49        
  >>
  stream
  BT
! /F37 9.9626 Tf 87.691 759.927 Td [(ZZZ)]TJ
  ET
  endstream
  endobj
--- 2,12 ----
  %����
  3 0 obj
  <<
! /Length 48        
  >>
  stream
  BT
! /F37 9.9626 Tf 87.691 759.927 Td [(ZZ)]TJ
  ET
  endstream
  endobj
***************
```

If we change `ZZ` back to `ZZZ`, the check passes. There are some normalization to make `l3build check` to work:
* Replacement of binary streams by the marker `[BINARY STREAM]`
* Replacement of `/ID` values by `ID-STRING`
* Removal of `blank lines` and comment `%%` lines 

Some remarks about the `pdf-based test`:
> * To allow platform-independence, PDF-based tests must use only Type 1 or Open-
Type fonts: Type3 fonts are system-dependent. 
> * PDF files are engine-specific, thus one
.tpf file should be stored per engine to be tested.


## multiple sets of tests
### project structure
Use different sets tests for different engines, for example. The project structure:
```shell
├── build.lua
├── config-TU.lua
├── testfiles
│   ├── LVTtest.lvt
│   └── PVTtest.pvt
├── testfiles-TU
│   └── TUtest.lvt
└── TESTpkg.sty
```

The `build.lua`:
```lua
-- package Identity
module = "TESTpkg"
sourcefiles = {"TESTpkg.sty"}

-- check opts
checkengines = {"pdftex"}
checkconfigs = {"build", "config-TU"}
```

The `config-TU.lua`:
```lua 
stdengine = "xetex"
checkengines = {"xetex", "luatex"}
checksearch = true
testfiledir = "testfiles-TU"
```

The newly added file `TUtest.ltv` is:
```latex
\documentclass{article}
\usepackage{fontspec}

\begin{document}
Hello world
\end{document}
```

### set up .tlg files
For the standard configuration, the default testfiledir `testfiles`, use command:
```shell 
l3build save LVTtest
l3build save PVTtest
```

to generate the `.tlg` files. For the non-standard configuration, the  `testfiles-TU` folder, use command:
```shell
l3build save -c config-TU TUtest
```

to generate the `.tlg` files. The output log is:
```shell
Creating and copying TUtest.tlg
This is XeTeX, Version 3.141592653-2.6-0.999996 (TeX Live 2024/Arch Linux) (preloaded format=xelatex)
 restricted \write18 enabled.
entering extended mode
LaTeX2e <2023-11-01> patch level 1
L3 programming layer <2024-02-20>
(./TUtest.lvt (/usr/share/texmf-dist/tex/latex/base/article.cls
Document Class: article 2023/05/17 v1.4n Standard LaTeX document class
(/usr/share/texmf-dist/tex/latex/base/size10.clo)) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec.sty (/usr/share/texmf-dist/tex/latex/l3packages/xparse/xparse.sty (/usr/share/texmf-dist/tex/latex/l3kernel/expl3.sty (/usr/share/texmf-dist/tex/latex/l3backend/l3backend-xetex.def))) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec-xetex.sty (/usr/share/texmf-dist/tex/latex/base/fontenc.sty) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec.cfg)))
No file TUtest.aux.
(/usr/share/texmf-dist/tex/latex/base/ts1cmr.fd) [1] (./TUtest.aux) )
Output written on TUtest.xdv (1 page, 500 bytes).
Transcript written on TUtest.log.
```

Then the project structure will be:
```shell
├── build
│   ├── local
│   ├── result
│   ├── test
│   │   ├── ascii.tcx
│   │   ├── PVTtest.log
│   │   ├── PVTtest.pdf
│   │   ├── PVTtest.pdftex.aux
│   │   ├── PVTtest.pvt
│   │   ├── PVTtest.tpf
│   │   └── TESTpkg.sty
│   ├── test-config-TU
│   │   ├── ascii.tcx
│   │   ├── TESTpkg.sty
│   │   ├── TUtest.log
│   │   ├── TUtest.lvt
│   │   ├── TUtest.tlg
│   │   ├── TUtest.xdv
│   │   └── TUtest.xetex.aux
│   └── unpacked
│       └── TESTpkg.sty
├── build.lua
├── config-TU.lua
├── testfiles
│   ├── LVTtest.lvt
│   ├── LVTtest.tlg
│   ├── PVTtest.pvt
│   └── PVTtest.tpf
├── testfiles-TU
│   ├── TUtest.lvt
│   └── TUtest.tlg
└── TESTpkg.sty
```

### run test
Then you can run the test:
```shell
l3build check 
```

the output log:
```shell
$ l3build check
Running l3build with target "check" and configuration "build"
Running checks on
  LVTtest (1/2)
  PVTtest (2/2)

  All checks passed

Running l3build with target "check" and configuration "config-TU"
Running checks on
  TUtest (1/1)

  All checks passed
```

For a single check for non-standard configuration, use:
```shell
l3build check -c config-TU TUtest
```

The output log:
```shell 
 > l3build check -c config-TU TUtest
Running checks on
  TUtest (1/1)
This is XeTeX, Version 3.141592653-2.6-0.999996 (TeX Live 2024/Arch Linux) (preloaded format=xelatex)
 restricted \write18 enabled.
entering extended mode
LaTeX2e <2023-11-01> patch level 1
L3 programming layer <2024-02-20>
(./TUtest.lvt (/usr/share/texmf-dist/tex/latex/base/article.cls
Document Class: article 2023/05/17 v1.4n Standard LaTeX document class
(/usr/share/texmf-dist/tex/latex/base/size10.clo)) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec.sty (/usr/share/texmf-dist/tex/latex/l3packages/xparse/xparse.sty (/usr/share/texmf-dist/tex/latex/l3kernel/expl3.sty (/usr/share/texmf-dist/tex/latex/l3backend/l3backend-xetex.def))) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec-xetex.sty (/usr/share/texmf-dist/tex/latex/base/fontenc.sty) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec.cfg)))
No file TUtest.aux.
(/usr/share/texmf-dist/tex/latex/base/ts1cmr.fd) [1] (./TUtest.aux) )
Output written on TUtest.xdv (1 page, 500 bytes).
Transcript written on TUtest.log.
This is LuaHBTeX, Version 1.18.0 (TeX Live 2024/Arch Linux)
 restricted system commands enabled.
LaTeX2e <2023-11-01> patch level 1
L3 programming layer <2024-02-20>
(./TUtest.lvt (/usr/share/texmf-dist/tex/latex/base/article.cls
Document Class: article 2023/05/17 v1.4n Standard LaTeX document class
(/usr/share/texmf-dist/tex/latex/base/size10.clo)) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec.sty (/usr/share/texmf-dist/tex/latex/l3packages/xparse/xparse.sty (/usr/share/texmf-dist/tex/latex/l3kernel/expl3.sty (/usr/share/texmf-dist/tex/latex/l3backend/l3backend-luatex.def))) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec-luatex.sty (/usr/share/texmf-dist/tex/latex/base/fontenc.sty) (/usr/share/texmf-dist/tex/latex/fontspec/fontspec.cfg)))
No file TUtest.aux.
(/usr/share/texmf-dist/tex/latex/base/ts1cmr.fd) [1{/var/lib/texmf/fonts/map/pdftex/updmap/pdftex.map}] (./TUtest.aux))
 406 words of node memory still in use:
   3 hlist, 1 vlist, 1 rule, 2 glue, 3 kern, 1 glyph, 4 attribute, 48 glue_spec, 4 attribute_list, 1 write nodes
   avail lists: 2:22,3:4,4:1,5:23,6:2,7:50,9:18
</usr/share/texmf-dist/fonts/opentype/public/lm/lmroman10-regular.otf>
Output written on TUtest.pdf (1 page, 3288 bytes).
Transcript written on TUtest.log.

  All checks passed
```

or using command:
```shell
l3build check -c config-TU
Running checks on
  TUtest (1/1)

  All checks passed
```


## Reference
* [l3build: A testing and building system for LaTeX](https://github.com/latex3/l3build)
* [demo pkg: How to use l3build and not die trying :)](https://github.com/pablgonz/demopkg-jw)
* [tabularray: Typeset tabulars and arrays with LaTeX3](https://github.com/lvjr/tabularray/)
* [Example for test files using l3build](https://tex.stackexchange.com/q/329743/294585)