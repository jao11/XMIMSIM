SOURCES = Home.md Installation-instructions.md References-and-additional-resources.md \
		The-XMI-MSIM-API-list-of-functions.md User-guide.md

OBJECTS = Home.tex Installation-instructions.tex References-and-additional-resources.tex \
		The-XMI-MSIM-API-list-of-functions.tex User-guide.tex


xmimsim-manual.pdf: $(SOURCES) $(OBJECTS)
	@echo "Building documentation"	
	pdflatex xmimsim-manual.tex
	pdflatex xmimsim-manual.tex
	pdflatex xmimsim-manual.tex
	




.md.tex:
	gsed -e 's/\* \*\*\(.\{1,\}\)\*\*.\{0,\}//' \
	    -e 's/## Table of contents//' \
	    -e 's/\.\.\/wiki\/figures/figures/' \
	    -e 's/^\(#\{2,3\}\) <a id="\(.\{1,\}\)"><\/a>\(.\{1,\}\)/\1 \3\nLABEL\2/' \
	    -e 's/<sub>/BEGINSUB/g' \
	    -e 's/<\/sub>/ENDSUB/g' \
	    -e 's/<sup>/BEGINSUP/g' \
	    -e 's/<\/sup>/ENDSUP/g' \
	    -e 's/](\.\.\/wiki.\{1,\}#/](#/g' \
	    $< > $<.bkp
	perl captions.pl $<.bkp
	pandoc --listings  --no-wrap -f markdown_github -t latex -o $@.bkp $<.bkp
	gsed -e 's/\\includegraphics\(.\{1,\}\)/\\begin{center}\\includegraphics[width=1.0\\textwidth]\1\\end{center}/' \
	    -e 's/LABEL\(.\{1,\}\)/\\label{\1}/' \
	    -e 's/BEGINSUB/$$_{/g' \
	    -e 's/ENDSUB/}$$/g' \
	    -e 's/BEGINSUP/$$^{/g' \
	    -e 's/ENDSUP/}$$/g' \
	    -e 's/^BEGCAP\(.\{1,\}\)ENDCAPFILE\(.\{1,\}\)ENDFILE/\\begin{figure}[htb]\\begin{center}\\includegraphics[width=1.0\\textwidth]{\2}\\caption{\1}\\end{center}\\end{figure}/' \
	    -e 's/}\\label.\{1,\}$$/}/' \
	    $@.bkp > $@.bkp2
	perl equation.pl $@.bkp2
	gsed -e '/^\\label/s/\\_/_/g' \
	    -e 's/ux5f/_/g' \
	    -e 's/^\\hyperdef.\{1,\}\\subsub/\\subsub/' \
	    $@.bkp2 > $@
	rm -f $<.bkp $@.bkp $@.bkp2

	

.SUFFIXES: .md .tex


clean:
	rm -f $(OBJECTS) *.bkp*
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
