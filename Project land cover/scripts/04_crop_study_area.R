
# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Script: 04_crop_study_area.R
# Purpose: Crop the land-cover raster to Wageningen study area
# ============================================================

# Load terra
library(terra)

# ------------------------------------------------------------
# 1. Define input file
# ------------------------------------------------------------

project_dir <- "Project land cover"

data_dir <- file.path(project_dir, "data")

file_name <- "ESA_WorldCover_10m_2021_v200_N51E003_Map.tif"

raster_file <- file.path(data_dir, file_name)

# ------------------------------------------------------------
# 2. Load raster
# ------------------------------------------------------------

landcover <- rast(raster_file)

# ------------------------------------------------------------
# 3. Define study area bounding box
# ------------------------------------------------------------

study_area <- ext(
  5.55, 5.78,
  51.85, 52.08
)

# ------------------------------------------------------------
# 4. Crop raster
# ------------------------------------------------------------

landcover_wageningen <- crop(
  landcover,
  study_area
)

# ------------------------------------------------------------
# 5. Inspect cropped raster
# ------------------------------------------------------------

landcover_wageningen

dim(landcover_wageningen)

res(landcover_wageningen)

ext(landcover_wageningen)

freq(landcover_wageningen)

# ------------------------------------------------------------
# 6. Plot cropped raster
# ------------------------------------------------------------

plot(
  landcover_wageningen,
  main = "Land Cover around Wageningen (2021)"
)

# ------------------------------------------------------------
# 7. Create output directory
# ------------------------------------------------------------

output_dir <- file.path(
  project_dir,
  "output",
  "Project_01_Forest_LandCover"
)

dir.create(
  output_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

# ------------------------------------------------------------
# 8. Save cropped raster
# ------------------------------------------------------------

output_file <- file.path(
  output_dir,
  "Wageningen_LandCover_2021.tif"
)

writeRaster(
  landcover_wageningen,
  output_file,
  overwrite = TRUE
)

# ------------------------------------------------------------
# 9. Confirm output
# ------------------------------------------------------------

file.exists(output_file)

cat("Study area raster successfully created!\n")
