SOURCES = Home.md Installation-instructions.md References-and-additional-resources.md \
		The-XMI-MSIM-API-list-of-functions.md User-guide.md Advanced-usage.md

OBJECTS = Home.tex Installation-instructions.tex References-and-additional-resources.tex \
		The-XMI-MSIM-API-list-of-functions.tex User-guide.tex Advanced-usage.tex


xmi-msim-manual.pdf: $(SOURCES) $(OBJECTS) xmi-msim-manual.tex
	@echo "Building documentation"	
	pdflatex xmi-msim-manual.tex
	pdflatex xmi-msim-manual.tex
	pdflatex xmi-msim-manual.tex
	


scp: xmi-msim-manual.pdf
	scp -P 6522 xmi-msim-manual.pdf schoon@lvserver.ugent.be:/var/www/html/xmi-msim/


.md.tex:
	gsed -e 's/^\* \*\*\(.\{1,\}\)\*\*.\{0,\}//' \
	    -e 's/^\* \[.\{1,\})$$//' \
	    -e 's/## Table of contents//' \
	    -e 's/\.\.\/wiki\/figures/figures/' \
	    -e 's/^\(#\{2,3\}\) <a id="\(.\{1,\}\)"><\/a>\(.\{1,\}\)/\1 \3\nLABEL\2/' \
	    -e 's/<sub>/BEGINSUB/g' \
	    -e 's/<\/sub>/ENDSUB/g' \
	    -e 's/<sup>/BEGINSUP/g' \
	    -e 's/<\/sup>/ENDSUP/g' \
	    -e 's/](\.\.\/wiki\/\(.\{1,\}\)#/](#/g' \
	    -e 's/](\.\.\/wiki\/\(.\{1,\}\))/](#\1)/g' \
	    $< > $<.bkp
	perl captions.pl $<.bkp
	pandoc --wrap=none -f markdown_github -t latex -o $@.bkp $<.bkp
	gsed -e 's/\\includegraphics\(.\{1,\}\)/\\begin{center}\\includegraphics[width=1.0\\textwidth]\1\\end{center}/' \
	    -e 's/LABEL\(.\{1,\}\)/\\label{\1}/' \
	    -e 's/BEGINSUB/$$_{/g' \
	    -e 's/ENDSUB/}$$/g' \
	    -e 's/BEGINSUP/$$^{/g' \
	    -e 's/ENDSUP/}$$/g' \
	    -e 's/^BEGCAP\(.\{1,\}\)ENDCAPFILE\(.\{1,\}\)ENDFILE/\\begin{figure}[htb]\\begin{center}\\includegraphics[width=1.0\\textwidth]{\2}\\caption{\1}\\end{center}\\end{figure}/' \
	    $@.bkp > $@.bkp2
	perl equation.pl $@.bkp2
	gsed -e '/^\\label/s/\\_/_/g' \
	    -e 's/ux5f/_/g' \
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
