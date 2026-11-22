
library(terra)

project_dir <- "Project Vegetation change"

# Load NDVI change raster
ndvi_change <- rast(
  file.path(project_dir, "outputs", "NDVI_Change_2025_2026.tif")
)

# Classify NDVI change
# 1 = Decrease
# 2 = Stable
# 3 = Increase

rcl <- matrix(c(
  -1,   -0.05, 1,
  -0.05, 0.05, 2,
   0.05,  1,    3
), ncol = 3, byrow = TRUE)

change_class <- classify(
  ndvi_change,
  rcl = rcl,
  include.lowest = TRUE,
  right = FALSE
)

# Save classified raster
writeRaster(
  change_class,
  file.path(project_dir, "outputs", "NDVI_Change_Classes.tif"),
  overwrite = TRUE
)

# Calculate pixel area in hectares
area_raster <- cellSize(change_class, unit = "ha")

# Calculate area for each class
area_by_class <- zonal(
  area_raster,
  change_class,
  fun = "sum",
  na.rm = TRUE
)

# Keep only the three expected classes
area_by_class <- area_by_class[
  area_by_class[, 1] %in% c(1, 2, 3),
]

# Assign category names based on class values
area_by_class$Category <- ifelse(
  area_by_class[, 1] == 1, "Vegetation Decrease",
  ifelse(
    area_by_class[, 1] == 2, "Stable Vegetation",
    "Vegetation Increase"
  )
)

# Save statistics
write.csv(
  area_by_class,
  file.path(project_dir, "outputs", "tables", "NDVI_Change_Area.csv"),
  row.names = FALSE
)

print(area_by_class)

cat("NDVI change statistics completed!\n")