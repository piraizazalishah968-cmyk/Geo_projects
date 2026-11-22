
# Project 03: Forest Fragmentation Analysis
# Script 03: Forest Patch Identification

library(terra)

project_dir <- "Project Forest fragmentation"

# Load forest cover raster
forest <- rast(
  file.path(project_dir, "data", "Forest_Cover_Wageningen.tif")
)

# Identify connected forest patches
# 8-neighbour connectivity
patches <- patches(
  forest,
  directions = 8,
  zeroAsNA = TRUE
)

# Save forest patch raster
writeRaster(
  patches,
  file.path(project_dir, "data", "Forest_Patches_Wageningen.tif"),
  overwrite = TRUE
)

# Plot forest patches
plot(
  patches,
  main = "Forest Patches around Wageningen (2021)"
)

cat("Forest patch identification completed!\n")
