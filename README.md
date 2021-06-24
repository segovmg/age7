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

Para validação dos recursos com `make validate` é necessário a ativação do ambiente virtual do Python criado durante o processo de instalação.

Para determinar qual comando para fazer a atividação execute na linha de comando

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

O seu prompt da linha de comando, apesar de formas possivelmente diferentes, vai indicar se o ambiente virtual está ativo

- `remuneracao$` -> `(age7) remuneracao$`

Agora para validar execute

```bash
make validate
```

### Rstudio

O script `scripts/exploratory-analysis.R` pode ser utilizado de forma interativa para o processo de análise exploratória para construção de um perfil dos recursos (ie. tabelas fato e dimensão).