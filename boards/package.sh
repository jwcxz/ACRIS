#!/bin/sh

rm ./export/*

# convert schematic ps
ps2pdf commbrd/commbrd.ps commbrd/commbrd.pdf
ps2pdf ledctrlr/ledctrlr.ps ledctrlr/ledctrlr.pdf
ps2pdf ledmini/ledmini.ps ledmini/ledmini.pdf


# convert brd pdf
inkscape -z -D -b '#000000' -y 255 -d 600 -e commbrd/commbrd-brd.png commbrd/commbrd-brd.svg
inkscape -z -D -b '#000000' -y 255 -d 600 -e ledctrlr/ledctrlr-brd.png ledctrlr/ledctrlr-brd.svg
inkscape -z -D -b '#000000' -y 255 -d 600 -e ledmini/ledmini-brd.png ledmini/ledmini-brd.svg


# fix BOM headings
./exportbom.sh commbrd/commbrd-bom.csv
./exportbom.sh ledctrlr/ledctrlr-bom.csv
./exportbom.sh ledmini/ledmini-bom.csv


# make thumbnails
convert -resize 400 -density 400 commbrd/commbrd.pdf commbrd/commbrd.png
convert -resize 400 -density 400 commbrd/commbrd-brd.png commbrd/commbrd-brd_t.png 

convert -resize 400 -density 400 ledctrlr/ledctrlr.pdf ledctrlr/ledctrlr.png
convert -resize 400 -density 400 ledctrlr/ledctrlr-brd.png ledctrlr/ledctrlr-brd_t.png

convert -resize 400 -density 400 ledmini/ledmini.pdf ledmini/ledmini.png
convert -resize 400 -density 400 ledmini/ledmini-brd.png ledmini/ledmini-brd_t.png


# copy relevant individual files
cp commbrd/commbrd.{pdf,png} export/
cp ledctrlr/ledctrlr.{pdf,png} export/
cp ledmini/ledmini.{pdf,png} export/

cp commbrd/commbrd-brd*.png export/
cp ledctrlr/ledctrlr-brd*.png export/
cp ledmini/ledmini-brd*.png export/

cp commbrd/commbrd-bom.csv export/
cp ledctrlr/ledctrlr-bom.csv export/
cp ledmini/ledmini-bom.csv export/


# package gerber+drill files
zip -r export/commbrd-gerber.zip commbrd/commbrd-*.g* commbrd/commbrd.drl
zip -r export/ledctrlr-gerber.zip ledctrlr/ledctrlr-*.g* ledctrlr/ledctrlr.drl
zip -r export/ledmini-gerber.zip ledmini/ledmini-*.g* ledmini/ledmini.drl


# package kicad files
zip -r export/acris-kicad.zip libs/ {commbrd,ledctrlr,ledmini}/{commbrd,ledctrlr,ledmini}.{brd,cmp,net,pro,sch}
