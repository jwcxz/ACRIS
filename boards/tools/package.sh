#!/bin/sh

# needs
# board.ps  - schematic
# board.csv - bom
# board.svg - layout
# board.g** - gerber files
# board.drl - drill file

for board in $@; do
    rm -f export/${board}.zip

    # convert schematic ps
    ps2pdf prj/${board}/${board}.ps prj/${board}/${board}.pdf

    # convert brd svg
    inkscape -z -D -b '#000000' -y 255 -d 600 -e prj/${board}/${board}-brd.png prj/${board}/${board}-brd.svg

    # fix BOM headings
    ./tools/exportbom.sh prj/${board}/${board}.csv

    # make thumbnails
    convert -resize 400 -density 400 prj/${board}/${board}.pdf prj/${board}/${board}.png
    convert -resize 400 -density 400 prj/${board}/${board}-brd.png prj/${board}/${board}-brd_t.png

    zip -r export/${board}.zip prj/${board}/${board}.{pdf,png} \
            prj/${board}/${board}-brd*.png prj/${board}/${board}.csv \
            prj/${board}/${board}-*.g* prj/$board/${board}.drl \
            prj/${board}/${board}.{brd,cmp,net,pro,sch}
done
