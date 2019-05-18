#!/bin/sh

echo "Enter the file name:"
read fname
touch ./$fname.rmd
echo "Enter the file title:"
read title
echo "Enter the file author:"
read author
echo "Do you need a table of contents? [true / false]"
read TOC

PRESET="---\ntitle: '$title'\nauthor: '$author'\noutput: pdf_document\nlan: 'es'\ntoc: '$TOC'\nfontsize: 10pt\n---\n\n-----\n\n#"

echo -e $PRESET > $fname.rmd
echo "Created $frname.rmd in current directory"
