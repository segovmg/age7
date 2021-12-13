.PHONY: help describe preview format validate_metadata validate log clean vars parse

RESOURCES=$(shell cat datapackage.json | jq -r ' .resources | .[] | .name ')

VALIDATION_REPORTS=$(patsubst %, logs/%.json, $(RESOURCES))

TABLESCHEMA=$(shell cat datapackage.json | jq -r ' .resources | .[] | select( .name == "$(resource)" ) | .schema ')

SQL_FILES := $(patsubst %, scripts/sql/%.sql, $(RESOURCES))

#====================================================================

# PHONY TARGETS

help: 
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

validate: clean $(VALIDATION_REPORTS) ## Valida recursos que sofreram modificação

validate_data: ## Valida arquivo (usage: make validate_data resource=resource_name)
	@echo "Validando recurso $(resource)"
	@python scripts/validate-resource.py $(resource) | jq . 2>&1 | tee logs/$(resource).json

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

logs/%.json: data/%.csv.gz schemas/%.yaml schemas/dialect.json
	@echo "Validando recurso $*:"
	@python scripts/validate-resource.py $* | jq . 2>&1 | tee logs/$*.json

log: ## Exibe recursos com validação inválida
	@echo "Recursos inválidos:"
	@bash -c "jq -n 'inputs | select( .valid == false) | input_filename' logs/*.json"

clean: ## Remove logs de recursos com validação inválida
	@bash -c "jq -n 'inputs | select( .valid == false) | input_filename' logs/*.json | xargs rm -f"

vars: ## Imprime valor das variáveis
	@echo 'RESOURCES:' $(RESOURCES)
	@echo 'VALIDATION_REPORTS:' $(VALIDATION_REPORTS)
	@echo 'TABLESCHEMA:' $(TABLESCHEMA)
	@echo 'SQL_FILES:' $(SQL_FILES)

parse: $(SQL_FILES)

$(SQL_FILES): scripts/sql/%.sql: schemas/%.yaml datapackage.json scripts/parse-sql.R renv.lock
	Rscript --verbose scripts/parse-sql.R $* 2> logs/parse-sql-$*.Rout
