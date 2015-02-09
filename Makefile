TARGET =WBMA.pdf

BIBTEX = bibtex
LATEX = latex
PDFLATEX = pdflatex
DVIPS = dvips
PS2PDF = ps2pdf

VERSION = 0.1.0



MAIN_FILE = wbma.tex
DVI_FILE  = $(addsuffix .dvi, $(basename $(MAIN_FILE)))
AUX_FILE  = $(addsuffix .aux, $(basename $(MAIN_FILE)))
PS_FILE   = $(addsuffix .ps, $(basename $(MAIN_FILE)))
PDF_FILE  = $(addsuffix .pdf, $(basename $(MAIN_FILE)))


.PHONY: all clean dist-clean

all: 
	@make $(TARGET)
     
$(TARGET): $(MAIN_FILE) $(SOURCES) myReferences.bib
	$(LATEX) $(MAIN_FILE) 
	$(BIBTEX) $(AUX_FILE)
	$(LATEX) $(MAIN_FILE) 
	$(PDFLATEX) $(MAIN_FILE) 
	@cp $(PDF_FILE) $(TARGET)

clean:
	rm -f *~ *.dvi *.ps *.backup *.aux *.log
	rm -f *.lof *.lot *.bbl *.blg *.brf *.toc *.idx
	rm -f *.pdf
	rm -f *.synctex.gz
	
dist: clean
	tar vczf tcc-fga-latex-$(VERSION).tar.gz *

dist-clean: clean
	rm -f $(PDF_FILE) $(TARGET)