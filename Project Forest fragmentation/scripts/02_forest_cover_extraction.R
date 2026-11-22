
# Project 03: Forest Fragmentation Analysis
# Script 02: Forest Cover Extraction

library(terra)

# Define project paths
project_dir <- "Project Forest fragmentation"

worldcover_path <- file.path(
  "Project land cover",
  "data",
  "ESA_WorldCover_10m_2021_v200_N51E003_Map.tif"
)

study_area_path <- file.path(
  "Project Vegetation change",
  "data",
  "Wageningen_study_area.gpkg"
)

# Load datasets
worldcover <- rast(worldcover_path)
study_area <- vect(study_area_path)

# Reproject study area to raster CRS
study_area <- project(study_area, crs(worldcover))

# Crop and mask WorldCover to study area
worldcover_crop <- crop(worldcover, study_area)
worldcover_mask <- mask(worldcover_crop, study_area)

# ESA WorldCover tree cover class = 10
forest <- worldcover_mask == 10

# Save forest cover raster
writeRaster(
  forest,
  file.path(project_dir, "data", "Forest_Cover_Wageningen.tif"),
  overwrite = TRUE
)

# Plot forest cover
plot(
  forest,
  col = c("grey90", "darkgreen"),
  main = "Forest Cover around Wageningen (2021)"
)

cat("Forest cover extraction completed!\n")
