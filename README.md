# Installation
## Project Paper
The project paper will be produced using Markdown and LaTex, therefore following packages are required to compile the file:

- LaTex: take MiKTeX for Windows or TeX Live for Linux. 
- Pandoc: https://github.com/jgm/pandoc/blob/master/INSTALL.md
- Pandoc template: https://github.com/Wandmalfarbe/pandoc-latex-template
Save eisvogel.tex file to the template directory. In Linux you will need to create a new directory .pandoc/templates/ and then specify the path to the template file when compiling the paper. 

Following command can be used to compile the project paper and to create the PDF file:
'''pandoc --from=markdown+hard_line_breaks+backtick_code_blocks+abbreviations+link_attributes+raw_tex --top-level-division=chapter --template=$Path_to_pandoc$/templates/eisvogel.tex --listings --filter=pandoc-citeproc basic-example.md -o basic-example.pdf'''

Replace $Path_to_pandoc$ with the path to the pandoc directory. 
