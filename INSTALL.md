# Instalação e configuração

## Programas CLI

### make, git, bash

Ferramentas padronizadas.

### jq

Faça download do programa `jq` no site <https://stedolan.github.io/jq/download/>. 

Renomeie o arquivo baixado para `jq` e salve esse arquivo na pasta `C:\Program Files\Git\usr\bin`. 

Para confirmar a instalação e configuração bem sucedida do `jq`, execute em uma nova linha de comando

```bash
jq --version
```

Caso o `jq` não tenha sido detectado, pode ser necessário a instalação do <https://scoop.sh/>, um gerenciador que executará ta função, a partir das etapas seguintes:

- Pressione as teclas **Windows + R**. Digite PowerShell e tecle Enter
- Ao abrir o Prompt de comando, Digite PowerShell e pressione Enter
- Em seguida digite o comando abaixo:
```
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
scoop install jq
````
Digite o comando `jq --version` numa nova `bash` cell para confirmar a instação do `jq`.

### git LFS

Instruções para instalação do `git LFS` estão disponíveis em <https://git-lfs.github.com/>. 

Para configurar execute na linha de comando

```bash
git lfs install
Git LFS initialized.
```

Esse procedimento de inicialização precisa ser executado somente uma vez por instalação.

Para confirmar a instalação e configuração bem sucedida execute na linha de comando

```bash
git lfs --version
```

## R

Esse projeto utiliza o [R versão 4.1.0](https://www.r-project.org/). Faça a instalação ou atualização antes de continuar.

O pacote [renv](https://rstudio.github.io/renv/index.html) é utilizado para gerenciamento de dependências. 
Ao inicializar o projeto do Rstudio, se as seguintes mensagens forem apresentadas

```r
# Bootstrapping renv 0.13.2 --------------------------------------------------
* Downloading renv 0.13.2 from CRAN ... OK
* Installing renv 0.13.2 ... Done!
* Successfully installed and loaded renv 0.13.2.
* Project 'path/to/project/' loaded. [renv 0.13.2]
* The project library is out of sync with the lockfile.
* Use `renv::restore()` to install packages recorded in the lockfile.
```

Siga as instruções e execute

```r
renv::restore()
```

Instale também de forma excepcional

```r
install.packages("remotes")
remotes::install_github("transparencia-mg/dtamg-r@v0.2.0")
```

Caso contrário pode ser necessário

```r
install.packages("renv") # instalação do pacote renv
renv::init() # instalação dos pacotes listados no arquivo renv.lock
```

Essa instalação demora vários minutos.

As mensagens acima somente serão exibidas na primeira vez que o `renv` for inicializado. 
Nas sessões seguintes, a mensagem indicativa de sucesso é simplesmente

```r
* Project 'path/to/project/' loaded. [renv 0.13.2]
```

## Python

Para validação dos recursos com `make validate` é necessário a instalação do Python e do pacote `frictionless`. 

Vamos gerenciar nossa instalação do python e dos pacotes python utilizando o miniconda. Faça a instalação seguindo as instruções do link <https://docs.conda.io/en/latest/miniconda.html>. Para confirmar a instalação e configuração bem sucedida execute na linha de comando

```bash
conda --version
```

Agora execute os seguintes comandos no console do R (ie. via Rstudio):

```R
reticulate::conda_create("age7") # criacao de ambiente conda especifico para esse projeto
reticulate::conda_install("age7", "frictionless==4.12.2") # instalacao da versao correta do frictionless
```

