SOURCES = Home.md Installation-instructions.md References-and-additional-resources.md \
		The-XMI-MSIM-API-list-of-functions.md User-guide.md

OBJECTS = Home.tex Installation-instructions.tex References-and-additional-resources.tex \
		The-XMI-MSIM-API-list-of-functions.tex User-guide.tex


all: $(SOURCES) $(OBJECTS)
	@echo "Building documentation"	
	pdflatex xmimsim-manual.tex
	pdflatex xmimsim-manual.tex
	pdflatex xmimsim-manual.tex
	




.md.tex:
	gsed -e 's/\* \*\*\(.\{1,\}\)\*\*.\{0,\}//' \
	    -e 's/## Table of contents//' \
	    -e 's/\.\.\/wiki\/figures/figures/' \
	    -e 's/^\(#\{2,3\}\) <a id="\(.\{1,\}\)"><\/a>\(.\{1,\}\)/\1 \3\nLABEL\2/' \
	    $< > $<.bkp
	pandoc -f markdown_github -t latex -o $@.bkp $<.bkp
	gsed -e 's/\\includegraphics\(.\{1,\}\)/\\begin{center}\\includegraphics[width=1.0\\textwidth]\1\\end{center}/' \
	    -e 's/LABEL\(.\{1,\}\)/\\label{\1}/' \
	    $@.bkp > $@
	rm -f $<.bkp $@.bkp

	

.SUFFIXES: .md .tex


clean:
	rm -f $(OBJECTS) *.bkp
	rm -f *.aux
	rm -f *.log
	rm -f *.toc
	rm -f *.bbl
	rm -f *.blg
	rm -f *.bak
	rm -f .*.swp
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.out
