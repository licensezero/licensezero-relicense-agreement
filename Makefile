CF=node_modules/.bin/commonform
CFT=node_modules/.bin/cftemplate
SPELL=node_modules/.bin/reviewers-edition-spell
OUTPUT=build
PROJECT_OUTPUT=$(OUTPUT)/projects
GIT_TAG=$(strip $(shell git tag -l --points-at HEAD))
EDITION=$(if $(GIT_TAG),$(GIT_TAG),Development Draft)
ifeq ($(EDITION),development draft)
	SPELLED_EDITION=$(EDITION)
else
	SPELLED_EDITION=$(shell echo "$(EDITION)" | $(SPELL) | sed 's!draft of!draft of the!')
endif

FORMS=$(basename $(wildcard *.cform))
DOCX=$(addprefix $(OUTPUT)/,$(addsuffix .docx,$(FORMS) $(PROJECTS)))
PDF=$(addprefix $(OUTPUT)/,$(addsuffix .pdf,$(FORMS) $(PROJECTS)))
MD=$(addprefix $(OUTPUT)/,$(addsuffix .md,$(FORMS) $(PROJECTS)))
JSON=$(addprefix $(OUTPUT)/,$(addsuffix .json,$(FORMS) $(PROJECTS)))

TARGETS=$(DOCX) $(PDF) $(MD) $(JSON)

all: $(TARGETS)

$(OUTPUT):
	mkdir -p $@

$(OUTPUT)/%.md: %.form %.options blanks.json | $(CF) $(OUTPUT)
	$(CF) render --format markdown $(shell cat $*.options) --blanks blanks.json < $< > $@

$(OUTPUT)/%.docx: %.form %.options blanks.json | $(CF) $(OUTPUT)
	$(CF) render --format docx $(shell cat $*.options) --edition "$(SPELLED_EDITION)" --blanks blanks.json < $< > $@

$(OUTPUT)/%.json: %.form | $(CF) $(OUTPUT)
	$(CF) render --format native < $< > $@

%.form: %.cform
ifeq ($(EDITION),Development Draft)
	cat $< | sed "s!PUBLICATION!a development draft of the License Zero Relicense Agreement!" > $@
else
	cat $< | sed "s!PUBLICATION!the $(SPELLED_EDITION) of the License Zero Relicense Agreement!" > $@
endif

%.pdf: %.docx
	doc2pdf $<

$(CF):
	npm install

.PHONY: clean docker lint critique

lint: $(JSON) | $(CF)
	for form in $(JSON); do echo $$form; $(CF) lint < $$form; done

critique: $(JSON) | $(CF)
	for form in $(JSON); do echo $$form ; $(CF) critique < $$form; done

clean:
	rm -rf $(OUTPUT)

docker:
	docker build -t open-accession-agreement .
	docker run --name open-accession-agreement open-accession-agreement
	docker cp open-accession-agreement:/workdir/$(OUTPUT) .
	docker rm open-accession-agreement
