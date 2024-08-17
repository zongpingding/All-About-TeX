DIR="$( cd "$( dirname "$0" )" && pwd )"
cd $DIR

latex colorist.ins
latex colorist-doc.ins

cd ./colorist
latexmk -xelatex -silent colorist-doc.tex

cd ../lebhart
latexmk -xelatex -silent lebhart-doc-cn.tex
latexmk -xelatex -silent lebhart-doc-en.tex
latexmk -xelatex -silent lebhart-doc-fr.tex

cd ../beaulivre
latexmk -xelatex -silent beaulivre-doc-cn.tex
latexmk -xelatex -silent beaulivre-doc-en.tex
latexmk -xelatex -silent beaulivre-doc-fr.tex
