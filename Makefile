PAPER=main

# Check if inkscape exist
ifneq ("$(shell which inkscape)","")
INKSCAPE := inkscape
else
INKSCAPE := echo "Consider installing Inkscape as the SVG is newer than the PDF: "
endif

# List all SVG files that the TARGET depends on
TMP    = $(wildcard figs/*.svg)
SVGS   = $(TMP:.svg=.pdf)

# Find the current working directory
CWD=$(shell dirname $(realpath $(filter %Makefile, $(MAKEFILE_LIST))))

default: paper

paper: $(SVGS)
	latexmk -pdf $(PAPER).tex

figs/%.pdf: figs/%.svg
	@echo "%%%%%%%%%% RUNNING INKSCAPE %%%%%%%%%%"
	@$(INKSCAPE) -f $(CWD)/$< -A $(CWD)/$@

tidy:
	rm -f $(PAPER).aux $(PAPER).bbl $(PAPER).blg $(PAPER).brf $(PAPER).btx $(PAPER).log $(PAPER).out $(PAPER).fls $(PAPER).fdb_latexmk

clean: tidy
	rm -f $(PAPER).pdf
