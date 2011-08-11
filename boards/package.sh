#!/bin/sh

rm ./export/*

# convert schematic ps
ps2pdf commbrd/commbrd.ps commbrd/commbrd.pdf
ps2pdf ledctrlr/ledctrlr.ps ledctrlr/ledctrlr.pdf
ps2pdf ledmini/ledmini.ps ledmini/ledmini.pdf


# fix BOM headings
./exportbom.sh commbrd/commbrd-bom.csv
./exportbom.sh ledctrlr/ledctrlr-bom.csv
./exportbom.sh ledmini/ledmini-bom.csv


# make thumbnails
convert -resize 400 -density 400 commbrd/commbrd.pdf commbrd/commbrd.png
convert -resize 400 -density 400 commbrd/commbrd-brd.pdf commbrd/commbrd-brd.png 

convert -resize 400 -density 400 ledctrlr/ledctrlr.pdf ledctrlr/ledctrlr.png
convert -resize 400 -density 400 ledctrlr/ledctrlr-brd.pdf ledctrlr/ledctrlr-brd.png

convert -resize 400 -density 400 ledmini/ledmini.pdf ledmini/ledctrlr.png
convert -resize 400 -density 400 ledmini/ledmini-brd.pdf ledmini/ledmini-brd.png


# copy relevant individual files
cp commbrd/commbrd{,-brd}.{pdf,png} export/
cp ledctrlr/ledctrlr{,-brd}.{pdf,png} export/
cp ledmini/ledmini{,-brd}.{pdf,png} export/

cp commbrd/commbrd-bom.csv export/
cp ledctrlr/ledctrlr-bom.csv export/
cp ledmini/ledmini-bom.csv export/


# package gerber+drill files
zip -r export/commbrd-gerber.zip commbrd/commbrd-*.g* commbrd/commbrd.drl
zip -r export/ledctrlr-gerber.zip ledctrlr/ledctrlr-*.g* ledctrlr/ledctrlr.drl
zip -r export/ledmini-gerber.zip ledmini/ledmini-*.g* ledmini/ledmini.drl


# package kicad files
zip -r export/acris-kicad.zip libs/ {commbrd,ledctrlr,ledmini}/{commbrd,ledctrlr,ledmini}.{brd,cmp,net,pro,sch}
