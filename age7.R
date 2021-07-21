library(yaml); library(purrr); library(data.table)

# gh pr list --assignee @me
# gh pr list --assignee kesiabomfa
# status: Todo; Open; Assigned; Merge; Merged
#======================================================================

age7 <- read_yaml("age7.yaml")

status <- data.table(resource = names(age7$resources), 
                     status = map_chr(age7$resources, "status"))

status[, .N, status]

status[status == 'Todo']

map(age7, "notes") |> unlist()

