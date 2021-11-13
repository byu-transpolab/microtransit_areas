library(targets)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then, run tar_make() to run the pipeline
# and tar_read(summary) to view the results.

# Set target-specific options such as packages.
tar_option_set(
  packages = as.character(read.csv(
    "U:/shayd/R_packages/packages.csv",
    header = F)[,1])
  )

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.
source("R/functions.R")


# Targets necessary to build your data and run your model
data_targets <- list(
  
  tar_target(
    read_data,
    "data/39.events.csv",
    format = "file"
    ),
  
  tar_target(
    count_events,
    read_data
  )
)



# Targets necessary to build the book / article
book_targets <- list()



# run all targets
list(
  data_targets, 
  book_targets
)
