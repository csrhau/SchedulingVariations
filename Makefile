TEX_DIR = tex
PLOT_DIR = plots

PLOT_TEX_FILES := $(wildcard $(PLOT_DIR)/*.tex)
PLOT_FILENAMES := $(notdir $(PLOT_TEX_FILES))
PLOT_PDF_FILES := $(PLOT_FILENAMES:%.tex=%.pdf)

.PHONY: all 
.DEFAULT: all
all: document.pdf 

.PHONY: plots
plots: $(PLOT_PDF_FILES)

.PHONY: ALWAYS
document.pdf: $(TEX_DIR)/document.tex $(PLOT_PDF_FILES) ALWAYS
	latexmk -f -pdf $<

%.pdf: $(PLOT_DIR)/%.tex
	latexmk -f -pdf $<

tidy:
	rm -f document.bbl *.fls *.aux *.log *.bbl *.blg
	rm -f *.fdb_latexmk *.lof *.lot *.out *.toc
	
clean: tidy
	latexmk -CA $(TEX_DIR)/document.tex $(PLOT_TEX_FILES)
