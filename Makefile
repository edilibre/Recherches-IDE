# Makefile pour convertir récursivement les fichiers markdown en html

# Fichiers sources et cibles
PANDOC ?= pandoc
PANDOC_FLAGS ?= -s --toc # --css=tufte.css

MD_FILES := $(shell find . -type f -name '*.md' -print)
HTML_FILES := $(patsubst %.md,%.html,$(MD_FILES))

# Cible par défaut
.PHONY: all clean help

all: $(HTML_FILES)

# Règle générique : convertir %.md en %.html
%.html: %.md
	@FOOTER=$$(mktemp); \
	echo "<footer style=\"font-size:0.9em;color:#666;margin-top:2rem;\"><p>© Sébastien Mengin -- Généré le : $$(date '+%Y-%m-%d %H:%M:%S')</p></footer>" > $$FOOTER; \
	$(PANDOC) $(PANDOC_FLAGS) --include-after-body=$$FOOTER $< -o $@; \
	rm -f $$FOOTER

help:
	@echo "Utilisation : make         # convertit tous les .md en .html (récursif) — ajoute un timestamp en pied de page"
	@echo "              make clean   # supprime tous les .html générés"
	@echo "Variables : PANDOC='...' PANDOC_FLAGS='...'"

# Nettoyage des fichiers html générés
clean:
	@echo "Suppression de $(words $(HTML_FILES)) fichiers HTML..."
	-rm -f $(HTML_FILES)