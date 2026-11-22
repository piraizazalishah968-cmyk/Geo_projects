
# Project 02: Vegetation Change Detection
# Script 04: NDVI Change Detection

library(terra)

# Set project directory
project_dir <- "Project Vegetation change"

# Load NDVI rasters
ndvi_2025 <- rast(file.path(
  project_dir, "outputs", "NDVI_Wageningen_2025.tif"
))

ndvi_2026 <- rast(file.path(
  project_dir, "outputs", "NDVI_Wageningen_2026.tif"
))

# Ensure both rasters have the same grid
ndvi_2026 <- resample(
  ndvi_2026,
  ndvi_2025,
  method = "bilinear"
)

# Calculate NDVI change
ndvi_change <- ndvi_2026 - ndvi_2025

# Save NDVI change raster
writeRaster(
  ndvi_change,
  file.path(project_dir, "outputs", "NDVI_Change_2025_2026.tif"),
  overwrite = TRUE
)

# Display NDVI change map
plot(
  ndvi_change,
  main = "NDVI Change: 2025 to 2026",
  col = hcl.colors(100, "RdYlGn", rev = TRUE)
)

# Calculate summary statistics
change_mean <- global(ndvi_change, "mean", na.rm = TRUE)
change_min  <- global(ndvi_change, "min", na.rm = TRUE)
change_max  <- global(ndvi_change, "max", na.rm = TRUE)

print(change_mean)
print(change_min)
print(change_max)

cat("NDVI change detection completed!\n")
