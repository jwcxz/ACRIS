Electronics
===========

These schematics and boards were made with [KiCad].


## Boards

Board projects are in `prj/`.

* `commbrd`: First attempt at a USB-to-RS-485 converter
* `commdngl`: USB-dongle that connects directly to a computer and delivers RS-485
* `ecomm`: Etchable USB-to-RS485 converter (proven)
* `ledctrlr_rf`: The main ACRIS LED controller board with RF connectivity
* `ledctrlr_rs485`: The main ACRIS LED controller board with RS-485 connectivity
* `ledmini`: Small form-factor LED controller
* `myropcb`: First run sent to Myro for production


## Libraries

Parts libraries (schematic symbols and footprints) are in the `libs/` dir.
Most of them are homemade, some of them are sourced from the internet.


## Tools

There are some scripts in the `tools/` dir.

* `exportbom.sh`: Clean up exported BOM files
* `package.sh`: Packager

### Packager

The packager does the following:

1.  Convert PS schematics exported from KiCad to PDF
2.  Convert SVG output from PCB editor to PNG
3.  Fix BOM headers with `exportbom.sh`
4.  Make image thumbnails.
5.  Archive Gerber and drill files
6.  Archive KiCad files



[KiCad]:http://www.kicad-pcb.org/
