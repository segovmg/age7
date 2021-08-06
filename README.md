# Portal da Transparência

Esse data package visa documentar as tabelas do modelo dimensional utilizado no banco de dados do Portal da Transparência. 
Os data packages representando consultas específicas do Portal da Transparência serão extraídos deste data package para fins de publicação.

Essa organização foi utilizada para evitar a necessidade de manter documentação em múltiplos repositórios para tabelas que são utilizadas em múltiplas consultas.

## Instalação e configuração

Instruções sobre instalação dos pré-requisitos e configuração do ambiente estão disponíves no arquivo [INSTALL](INSTALL.md)

## Uso

### Linha de comando

#### Documentação

```bash
make preview
```

```bash
make format resource=resource-name
```

#### Validação

Para validação do data package com `make validate` e `make validate_metadata` é necessário a ativação do ambiente virtual do Python criado durante o processo de instalação.

Para determinar qual comando para fazer a ativação execute na linha de comando

```bash
conda env list
# conda environments:
# age7                     /path/r-miniconda/envs/age7
# base                  *  /path/opt/anaconda3
```

Para ativar execute

```bash
conda activate age7
```

Em alguns casos, o "atalho" para ativação do ambiente virtual não está ficando registrado. O atalho deveria permitir executar ``conda activate base`` no lugar de ``conda activate /Users/user/opt/anaconda3``, por exemplo.

````
conda env list
# conda environments:
                         /Users/fjunior/Library/r-miniconda/envs/age7
base                     /Users/fjunior/opt/anaconda3
````
No windows, ainda é preciso descobrir onde fica a pasta R-MINI~1 e utilizar o separador correto:

````
conda env list
# conda environments:
                         C:\Users\user\AppData\Local\R-MINI~1\envs\age7
base                  *  C:\Users\user\miniconda3
````
Para essa última situação, utilizar ````conda activate C:\Users\user\AppData\Local\R-MINI~1\envs\age7````

O seu prompt da linha de comando, apesar de formas possivelmente diferentes, vai indicar se o ambiente virtual está ativo

- `remuneracao$` -> `(age7) remuneracao$`

Para validar somente os metadados armazenados no table schema execute

```bash
make validate_metadata resource=resource_name
```

Agora para validar se os dados armazenados em `data/` estão em conformidade com os metadados execute

```bash
make validate
```

### Rstudio

O script `scripts/exploratory-analysis.R` pode ser utilizado de forma interativa para o processo de análise exploratória para construção de um perfil dos recursos (ie. tabelas fato e dimensão).