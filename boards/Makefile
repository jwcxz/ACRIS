# makefile for exporting boards
# jwc :: jwcxz.com

# directories
D_ROOT=.
D_PROJ=$(D_ROOT)/prj
D_TOOL=$(D_ROOT)/tools
D_EXPT=$(D_ROOT)/export

# tools
C_PACKAGE=$(D_TOOL)/package.sh
C_EXPORTBOM=$(D_TOOL)/exportbom.sh
C_REMOVE=rm -rf

# board projects
PROJECTS=$(shell find "$(D_PROJ)" -maxdepth 1 -not -name "$(notdir $(D_PROJ))" -type d -printf "%f ")

# project directories
F_PROJ=$(addprefix $(D_PROJ)/,$(PROJECTS))
D_LIBS=$(D_ROOT)/libs

F_SCH=$(addsuffix /*.ps,$(F_PROJ))
F_BOM=$(addsuffix /*.csv,$(F_PROJ))
F_BRD=$(addsuffix /*.svg,$(F_PROJ))
F_GRB=$(addsuffix /*.g*,$(F_PROJ))
F_DRL=$(addsuffix /*.drl,$(F_PROJ))

O_LIB=$(D_EXPT)/libs.zip


all: $(PROJECTS) libs

clean:
	$(C_REMOVE) $(D_EXPT)/*

list:
	@echo $(PROJECTS)

libs:
	rm -f $(O_LIB)
	zip -r $(O_LIB) $(D_LIBS)

$(PROJECTS):
	$(C_PACKAGE) $@


.PHONY: all clean list libs
