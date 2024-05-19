main.pdf: main.tex Pic1.pdf 
	pdflatex main.tex

Pic1.pdf: Pic1.tex 
	xelatex --shell-escape Pic1.tex

clean:
	rm *.aux *.log 

Clean:
	rm *.aux *.log *.pdf
