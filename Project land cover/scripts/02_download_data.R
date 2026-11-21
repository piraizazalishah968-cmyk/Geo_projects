
# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Script: 02_download_data.R
# Purpose: Download ESA WorldCover data
# ============================================================

# Define project directory
project_dir <- "Project land cover"

# Define data directory inside Project 01
data_dir <- file.path(project_dir, "data")

# Create data directory if it doesn't exist
dir.create(data_dir, showWarnings = FALSE, recursive = TRUE)

# Define file name
file_name <- "ESA_WorldCover_10m_2021_v200_N51E003_Map.tif"

# Define local file path
file_path <- file.path(data_dir, file_name)

# Define download URL
download_url <- paste0(
  "https://esa-worldcover.s3.eu-central-1.amazonaws.com/",
  "v200/2021/map/",
  file_name
)

# Download only if file does not already exist
if (!file.exists(file_path)) {

  download.file(
    url = download_url,
    destfile = file_path,
    mode = "wb"
  )

} else {

  message("File already exists. Download skipped.")

}

# Check if file exists
file.exists(file_path)

# Check file size in MB
file.size(file_path) / (1024^2)

# Print completion message
cat("Data download step completed!\n")
