
# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Study area: Wageningen, Netherlands
# Script: 01_setup_and_inspect.R
# ============================================================

# 1. Clear the current environment
rm(list = ls())

# 2. Check the working directory
getwd()

# 3. Load required package
if (!requireNamespace("terra", quietly = TRUE)) {
  install.packages("terra")
}

library(terra)

# 4. Define project directories
project_dir <- "Project_01_Forest_LandCover"

data_dir <- file.path(project_dir, "data")
scripts_dir <- file.path(project_dir, "scripts")
outputs_dir <- file.path(project_dir, "outputs")

# 5. Check whether directories exist
dir.exists(data_dir)
dir.exists(scripts_dir)
dir.exists(outputs_dir)

# 6. List files currently available in the data folder
list.files(data_dir)

# 7. Display terra version
packageVersion("terra")

# 8. Print a message confirming setup
cat("Project environment initialized successfully!\n")
