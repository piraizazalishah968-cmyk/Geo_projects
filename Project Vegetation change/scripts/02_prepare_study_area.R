
# ------------------------------------------------------------
# Project 02: Vegetation Change Detection
# Script 02: Prepare Study Area
# ------------------------------------------------------------

library(terra)

# ------------------------------------------------------------
# Define project directory
# ------------------------------------------------------------

project_dir <- "Project Vegetation change"

data_dir <- file.path(project_dir, "data")
outputs_dir <- file.path(project_dir, "outputs")

# ------------------------------------------------------------
# Define study area around Wageningen
# ------------------------------------------------------------

study_area <- ext(
  5.55, 5.78,
  51.85, 52.08
)

# Create a spatial vector from the extent
study_area_vect <- as.polygons(study_area)

# Assign coordinate reference system
crs(study_area_vect) <- "EPSG:4326"

# ------------------------------------------------------------
# Save study area boundary
# ------------------------------------------------------------

study_area_file <- file.path(
  data_dir,
  "Wageningen_study_area.gpkg"
)

writeVector(
  study_area_vect,
  study_area_file,
  overwrite = TRUE
)

# ------------------------------------------------------------
# Inspect study area
# ------------------------------------------------------------

print(study_area_vect)

plot(
  study_area_vect,
  main = "Study Area around Wageningen"
)

cat("\nStudy area saved successfully!\n")
