library(dplyr); library(data.table)

source("scripts/utils.R")

resource_name = "ft_orcamento_cred_alt" # ajustar
resource <- fread(glue::glue('data/{gsub("_", "-", resource_name)}.csv.gz'), dec = ",")

glimpse(resource)

## field constraints

field <- "nr_documento" # ajustar

head(resource[, ..field])
describe_unique(resource[[field]])
describe_range(resource[[field]])
describe_length(resource[[field]])
describe_enum(resource[[field]])
