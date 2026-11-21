
# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Script: 08_forest_area_calculation.R
# Purpose: Calculate forest area and percentage
# ============================================================

library(terra)

# ------------------------------------------------------------
# 1. Define project and output directories
# ------------------------------------------------------------

project_dir <- "Project land cover"

output_dir <- file.path(
  project_dir,
  "output",
  "Project_01_Forest_LandCover"
)

# ------------------------------------------------------------
# 2. Load land-cover raster
# ------------------------------------------------------------

raster_file <- file.path(
  output_dir,
  "Wageningen_LandCover_2021.tif"
)

landcover <- rast(raster_file)

# ------------------------------------------------------------
# 3. Reproject raster to UTM Zone 31N
# ------------------------------------------------------------

landcover_utm <- project(
  landcover,
  "EPSG:32631",
  method = "near",
  res = 10
)

# Inspect projected raster
landcover_utm

res(landcover_utm)
crs(landcover_utm)

# ------------------------------------------------------------
# 4. Identify forest cells
# ESA WorldCover class 10 = Tree cover
# ------------------------------------------------------------

forest_cells <- global(
  landcover_utm == 10,
  "sum",
  na.rm = TRUE
)[1, 1]

# ------------------------------------------------------------
# 5. Count total valid cells
# ------------------------------------------------------------

total_cells <- global(
  !is.na(landcover_utm),
  "sum",
  na.rm = TRUE
)[1, 1]

# Non-forest cells
nonforest_cells <- total_cells - forest_cells

# ------------------------------------------------------------
# 6. Calculate cell area
# ------------------------------------------------------------

cell_area_m2 <- prod(res(landcover_utm))

cell_area_ha <- cell_area_m2 / 10000

# ------------------------------------------------------------
# 7. Calculate areas in hectares
# ------------------------------------------------------------

forest_area_ha <- forest_cells * cell_area_ha

nonforest_area_ha <- nonforest_cells * cell_area_ha

total_area_ha <- total_cells * cell_area_ha

# ------------------------------------------------------------
# 8. Calculate percentages
# ------------------------------------------------------------

forest_percentage <- (
  forest_area_ha / total_area_ha
) * 100

nonforest_percentage <- (
  nonforest_area_ha / total_area_ha
) * 100

# ------------------------------------------------------------
# 9. Create summary table
# ------------------------------------------------------------

area_summary <- data.frame(
  Class = c("Forest", "Non-forest", "Total"),
  Area_ha = c(
    forest_area_ha,
    nonforest_area_ha,
    total_area_ha
  ),
  Percentage = c(
    forest_percentage,
    nonforest_percentage,
    100
  )
)

# Round results
area_summary$Area_ha <- round(
  area_summary$Area_ha,
  2
)

area_summary$Percentage <- round(
  area_summary$Percentage,
  2
)

# ------------------------------------------------------------
# 10. Print results
# ------------------------------------------------------------

print(area_summary)

cat("\nForest area:", forest_area_ha, "ha\n")
cat("Forest percentage:", forest_percentage, "%\n")

# ------------------------------------------------------------
# 11. Save results
# ------------------------------------------------------------

table_dir <- file.path(
  output_dir,
  "tables"
)

dir.create(
  table_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

write.csv(
  area_summary,
  file.path(
    table_dir,
    "forest_area_summary.csv"
  ),
  row.names = FALSE
)

# ------------------------------------------------------------
# 12. Completion message
# ------------------------------------------------------------

cat("\nForest area calculation completed successfully!\n")
