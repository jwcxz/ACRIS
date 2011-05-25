# top-level makefile for building firmware projects
# jwc :: jwcxz.com

D_PROJ=prj
PROJECTS=$(shell find "$(D_PROJ)" -maxdepth 1 -not -name "$(D_PROJ)" -type d -printf "%f ")

all: $(PROJECTS)

list:
	@echo $(PROJECTS)

tags: FORCE
	./tools/mktags

$(PROJECTS):
	make -C $(D_PROJ)/$@ $(filter-out $@ all, $(MAKECMDGOALS))

$(filter-out $(PROJECTS) all list tags, $(MAKECMDGOALS)):
	@echo -n "" > /dev/null

.PHONY = all list tags $(PROJECTS)
FORCE:
