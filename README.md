# Installation
## Project Paper
The project paper will be produced using Markdown and LaTex, therefore following packages are required to compile the file:

- LaTex: take MiKTeX for Windows or TeX Live for Linux. 
- Pandoc: https://github.com/jgm/pandoc/blob/master/INSTALL.md
- Pandoc template: https://github.com/Wandmalfarbe/pandoc-latex-template
Save eisvogel.tex file to the template directory. In Linux you will need to create a new directory .pandoc/templates/ and then specify the path to the template file when compiling the paper. 

Following command can be used to compile the project paper and to create the PDF file:

```bash 
pandoc --from=markdown+hard_line_breaks+backtick_code_blocks+abbreviations+link_attributes+raw_tex --top-level-division=chapter --template=Path_to_pandoc/templates/eisvogel.tex  --listings --filter=pandoc-citeproc SSBM-HANA.md -o SSBM-HANA.pdf -V lang=de
```



Replace $Path_to_pandoc$ with the path to the pandoc directory. 

#ToDo
- Alte Ergebnisse reproduzieren
- Row vs. coumns based benchmarks getrennt laufen lassen (Tabellen laden und droppen von den Benchmarks trennen)
- MDX vs. SQL
- Sinvolle Optimierungen für HANA ()
- Prepared Statements
- Parallele Abfragen
- Mehr Queries generieren (Mehr Variationen von den gleichen Abfragen)
- TPCH Queries auf das SSBM Schema übertragen?
- Query Execution Plans generieren und analysieren
- Verschiedene Anzahl an CPUs testen (wie sie skalieren)
- Sar-Daten sammeln und auswerten
