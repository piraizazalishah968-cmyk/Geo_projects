
# Project 03: Forest Fragmentation Analysis
# Script 01: Project Initialization

# Define project directory
project_dir <- "Project Forest fragmentation"

# Initialize project structure
project_subdirs <- c(
  "data",
  "scripts",
  "outputs",
  "outputs/figures",
  "outputs/tables",
  "docs"
)

# Create project directories
invisible(lapply(
  project_subdirs,
  function(x) {
    dir.create(
      file.path(project_dir, x),
      recursive = TRUE,
      showWarnings = FALSE
    )
  }
))

message("Project initialization completed.")
