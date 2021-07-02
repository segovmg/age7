library(dplyr); library(data.table)

source("scripts/utils.R")

resource_name = "dm-subfuncao-desp" # ajustar
resource <- fread(glue::glue('data/{gsub("_", "-", resource_name)}.csv.gz'), dec = ",")

glimpse(resource)

## field constraints

field <- "id_subfuncao" # ajustar

head(resource[, ..field])
describe_unique(resource[[field]])
describe_range(resource[[field]])
describe_length(resource[[field]])
describe_enum(resource[[field]])
