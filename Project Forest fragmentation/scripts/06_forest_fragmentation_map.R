
# Project 03: Forest Fragmentation Analysis
# Script 06: Forest Fragmentation Map

library(terra)

# Project directory
project_dir <- "Project Forest fragmentation"

# Load forest patch raster
patches <- rast(
  file.path(
    project_dir,
    "data",
    "Forest_Patches_Wageningen.tif"
  )
)

# Load study area
study_area <- vect(
  file.path(
    "Project Vegetation change",
    "data",
    "Wageningen_study_area.gpkg"
  )
)

# Reproject study area to raster CRS
study_area <- project(
  study_area,
  crs(patches)
)

# Create map
png(
  file.path(
    project_dir,
    "outputs",
    "figures",
    "Forest_Fragmentation_Map.png"
  ),
  width = 2000,
  height = 1600,
  res = 200
)

plot(
  patches,
  main = "Forest Fragmentation around Wageningen (2021)",
  axes = TRUE,
  col = hcl.colors(
    100,
    palette = "Dark 3"
  )
)

plot(
  study_area,
  add = TRUE,
  border = "black",
  lwd = 1.5
)

dev.off()

cat("Forest fragmentation map saved!\n")
