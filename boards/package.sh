#!/bin/sh

# needs
# board.ps  - schematic
# board.csv - bom
# board.svg - layout
# board.g** - gerber files
# board.drl - drill file

rm ./export/*
# package kicad files
zip -r export/acris-kicad.zip libs/

for board in commbrd commdngl ledctrlr ledmini; do
    # convert schematic ps
    ps2pdf $board/${board}.ps $board/${board}.pdf

    # convert brd svg
    inkscape -z -D -b '#000000' -y 255 -d 600 -e $board/${board}-brd.png $board/${board}-brd.svg

    # fix BOM headings
    ./exportbom.sh ${board}/${board}.csv

    # make thumbnails
    convert -resize 400 -density 400 $board/${board}.pdf $board/${board}.png
    convert -resize 400 -density 400 $board/${board}-brd.png $board/${board}-brd_t.png 

    # copy relevant individual files
    cp $board/${board}.{pdf,png} export/
    cp $board/${board}-brd*.png export/
    cp $board/${board}.csv export/

    # package gerber+drill files
    zip -r export/${board}-gerber.zip $board/${board}-*.g* $board/${board}.drl

    # package kicad files
    zip -r export/acris-kicad.zip $board/${board}.{brd,cmp,net,pro,sch}
done
