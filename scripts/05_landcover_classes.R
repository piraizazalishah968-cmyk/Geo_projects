
# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Script: 05_landcover_classes.R
# Purpose: Identify and summarize land-cover classes
# ============================================================

library(terra)

# ------------------------------------------------------------
# 1. Load cropped raster
# ------------------------------------------------------------

raster_file <- file.path(
  "output",
  "Project_01_Forest_LandCover",
  "Wageningen_LandCover_2021.tif"
)

landcover <- rast(raster_file)

# ------------------------------------------------------------
# 2. Define land-cover class names
# ------------------------------------------------------------

class_codes <- c(
  10, 20, 30, 40, 50, 60,
  70, 80, 90, 95, 100
)

class_names <- c(
  "Tree cover",
  "Shrubland",
  "Grassland",
  "Cropland",
  "Built-up",
  "Bare / sparse vegetation",
  "Snow and ice",
  "Permanent water",
  "Herbaceous wetland",
  "Mangroves",
  "Moss and lichen"
)

# ------------------------------------------------------------
# 3. Calculate frequency of each class
# ------------------------------------------------------------

landcover_freq <- freq(landcover)

# Remove NA values
landcover_freq <- landcover_freq[
  !is.na(landcover_freq$value),
]

# ------------------------------------------------------------
# 4. Add class names
# ------------------------------------------------------------

landcover_freq$class_name <- class_names[
  match(landcover_freq$value, class_codes)
]

# ------------------------------------------------------------
# 5. Calculate percentage
# ------------------------------------------------------------

total_cells <- sum(landcover_freq$count)

landcover_freq$percentage <- (
  landcover_freq$count / total_cells
) * 100

# ------------------------------------------------------------
# 6. Arrange results
# ------------------------------------------------------------

landcover_freq <- landcover_freq[
  order(-landcover_freq$count),
]

# ------------------------------------------------------------
# 7. Display results
# ------------------------------------------------------------

print(landcover_freq)

# ------------------------------------------------------------
# 8. Forest cover summary
# ------------------------------------------------------------

forest_cells <- landcover_freq$count[
  landcover_freq$value == 10
]

forest_percentage <- (
  forest_cells / total_cells
) * 100

cat("Forest cover percentage:", forest_percentage, "%\n")

# ------------------------------------------------------------
# 9. Save summary table
# ------------------------------------------------------------

table_dir <- file.path(
  "output",
  "Project_01_Forest_LandCover",
  "tables"
)

dir.create(
  table_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  landcover_freq,
  file.path(table_dir, "landcover_class_summary.csv"),
  row.names = FALSE
)

cat("Land-cover classification summary completed!\n")
