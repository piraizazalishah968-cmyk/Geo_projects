
# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Script: 07_forest_nonforest_map.R
# Purpose: Create Forest vs Non-Forest map around Wageningen
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
# 2. Load cropped land-cover raster
# ------------------------------------------------------------

raster_file <- file.path(
  output_dir,
  "Wageningen_LandCover_2021.tif"
)

landcover <- rast(raster_file)

# ------------------------------------------------------------
# 3. Reclassify Forest vs Non-Forest
# ESA WorldCover class 10 = Tree cover
# ------------------------------------------------------------

forest_nonforest <- ifel(
  landcover == 10,
  1,
  2
)

# ------------------------------------------------------------
# 4. Define class labels and colors
# ------------------------------------------------------------

class_names <- c(
  "Forest (Tree cover)",
  "Non-forest"
)

class_colors <- c(
  "#006400",  # Dark green: Forest
  "#F2E8C9"   # Beige: Non-forest
)

# ------------------------------------------------------------
# 5. Create plotting function
# ------------------------------------------------------------

plot_forest_map <- function() {

  # Create map and legend panels
  layout(
    matrix(c(1, 2), nrow = 1),
    widths = c(3, 1)
  )

  # Map panel
  par(mar = c(4, 4, 4, 1))

  plot(
    forest_nonforest,
    col = class_colors,
    breaks = c(0.5, 1.5, 2.5),
    axes = TRUE,
    legend = FALSE,
    main = "Forest vs Non-Forest around Wageningen"
  )

  # Legend panel
  par(mar = c(1, 0, 1, 0))
  plot.new()

  legend(
    "left",
    legend = class_names,
    fill = class_colors,
    bty = "n",
    cex = 1,
    title = "Land-cover type"
  )

  # Reset layout
  layout(1)
}

# ------------------------------------------------------------
# 6. Display map in Positron
# ------------------------------------------------------------

plot_forest_map()

# ------------------------------------------------------------
# 7. Create output directory
# ------------------------------------------------------------

figures_dir <- file.path(
  output_dir,
  "figures"
)

dir.create(
  figures_dir,
  recursive = TRUE,
  showWarnings = FALSE
)

# ------------------------------------------------------------
# 8. Save map as PNG
# ------------------------------------------------------------

output_file <- file.path(
  figures_dir,
  "Wageningen_Forest_vs_NonForest.png"
)

png(
  filename = output_file,
  width = 1600,
  height = 1200,
  res = 200
)

plot_forest_map()

dev.off()

# ------------------------------------------------------------
# 9. Confirm successful output
# ------------------------------------------------------------

file.exists(output_file)

cat("Forest vs Non-Forest map created successfully!\n")
