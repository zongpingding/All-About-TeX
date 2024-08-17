$pdf_mode = 1;
$pdflatex = 'pdflatex -file-line-error -interaction=errorstopmode -shell-escape %O %S';
$xelatex = 'xelatex -file-line-error -interaction=errorstopmode -no-pdf -shell-escape %O %S';
$xdvipdfmx = 'xdvipdfmx -q -E -o %D %O %S';
$bibtex_use = 1.5;
$force_mode = 1;
$go_mode = 1;
$clean_ext = 'synctex.gz acn acr snm alg aux bbl xdv bcf nav blg brf fdb_latexmk glg glo gls idx ilg ind ist lof log lot out run.xml toc dvi';

add_cus_dep('glo', 'gls', 0, 'glo2gls');
sub glo2gls {
    system("makeindex -s gglo.ist -o \"$_[0].gls\" \"$_[0].glo\"");
}
push @generated_exts, "glo", "gls";

add_cus_dep('nlo', 'nls', 0, 'nlo2nls');
sub nlo2nls {
    system("makeindex -s nomencl.ist -o \"$_[0].nls\" \"$_[0].nlo\"");
}
push @generated_exts, "nlo", "nls";
