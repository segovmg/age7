.PHONY: help validate

RESOURCES=$(shell cat datapackage.json | jq -r ' .resources | .[] | .name ')

VALIDATION_REPORTS=$(patsubst %, logs/%.txt, $(subst _,-,$(RESOURCES)))

TABLESCHEMA=$(shell cat datapackage.json | jq -r ' .resources | .[] | select( .name == "$(resource)" ) | .schema ')

#====================================================================
# PHONY TARGETS

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

validate: $(VALIDATION_REPORTS) ## Valida recursos que sofreram modificação

describe: ## Extrai dados e metadados do banco de dados Oracle (make describe resource=resource_name)
	Rscript scripts/describe_resource.R $(resource)
	make format resource=$(resource)

preview: ## Preview documentação
	Rscript -e 'xaringan::infinite_moon_reader("datapackage.Rmd")'

format: ## Formata arquivo yaml com tableschema (usage: make format resource=resource_name)
	@echo "Formatando tableschema $(TABLESCHEMA)"
	@Rscript -e 'dtamg::style_tableschema("$(TABLESCHEMA)", "$(TABLESCHEMA)")'

validate_metadata: ## Valida arquivo yaml com tableschema (usage: make validate_metadata resource=resource_name)
	@echo "Validando tableschema $(TABLESCHEMA)"
	@python scripts/validate-tableschema.py $(TABLESCHEMA)

logs/%.txt: data/%.csv.gz schemas/%.yaml schemas/dialect.json datapackage.json
	@echo "Validando recurso $*:"
	@frictionless validate $< --schema schemas/$*.yaml 2>&1 | tee $@

vars: ## Imprime valor das variáveis
	@echo 'RESOURCES:' $(RESOURCES)
	@echo 'VALIDATION_REPORTS:' $(VALIDATION_REPORTS)
	@echo 'TABLESCHEMA:' $(TABLESCHEMA)