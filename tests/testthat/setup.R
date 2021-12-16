library(data.table); library(validate); library(dtamg); library(dotenv)

reticulate::use_python(Sys.getenv("PYTHON_PATH"), required = TRUE)
