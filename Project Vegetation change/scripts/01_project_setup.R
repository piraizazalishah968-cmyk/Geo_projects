
# ------------------------------------------------------------
# Project 02: Vegetation Change Detection
# Script 01: Project Setup
# ------------------------------------------------------------

# Check current working directory
getwd()

# ------------------------------------------------------------
# Define project directories
# ------------------------------------------------------------

project_dir <- "Project Vegetation change"

data_dir <- file.path(project_dir, "data")
scripts_dir <- file.path(project_dir, "scripts")
outputs_dir <- file.path(project_dir, "outputs")
figures_dir <- file.path(outputs_dir, "figures")
tables_dir <- file.path(outputs_dir, "tables")
docs_dir <- file.path(project_dir, "docs")

# ------------------------------------------------------------
# Create directories if they do not already exist
# ------------------------------------------------------------

dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(scripts_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figures_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(tables_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(docs_dir, recursive = TRUE, showWarnings = FALSE)

# ------------------------------------------------------------
# Check project structure
# ------------------------------------------------------------

cat("Project directory:", project_dir, "\n")

cat("\nProject folders:\n")
print(list.dirs(project_dir, recursive = FALSE))

# ------------------------------------------------------------
# Check and load terra
# ------------------------------------------------------------

if (!requireNamespace("terra", quietly = TRUE)) {
  install.packages("terra")
}

library(terra)

cat("\nterra version:\n")
print(packageVersion("terra"))

cat("\nProject setup completed successfully!\n")
