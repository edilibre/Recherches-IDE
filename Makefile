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
	$(PANDOC) $(PANDOC_FLAGS) $< -o $@

help:
	@echo "Utilisation : make         # convertit tous les .md en .html (récursif)"
	@echo "              make clean   # supprime tous les .html générés"
	@echo "Variables : PANDOC='...' PANDOC_FLAGS='...'"

# Nettoyage des fichiers html générés
clean:
	@echo "Suppression de $(words $(HTML_FILES)) fichiers HTML..."
	-rm -f $(HTML_FILES)