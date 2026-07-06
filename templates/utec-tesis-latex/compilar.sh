#!/bin/bash
# Script para compilar la tesis localmente
# Requiere: texlive-latex-base texlive-latex-extra texlive-lang-spanish texlive-bibtex-extra

set -e
cd "$(dirname "$0")"

echo "Compilando main.tex..."
pdflatex -interaction=nonstopmode main.tex
echo "Procesando referencias..."
bibtex main 2>/dev/null || true
echo "Segunda pasada..."
pdflatex -interaction=nonstopmode main.tex
echo "Tercera pasada..."
pdflatex -interaction=nonstopmode main.tex

echo ""
echo "Listo. PDF generado: main.pdf"
echo "Para ver: xdg-open main.pdf"
