
# ------------------------------------------------------------
# Project 01: Forest & Land-Cover Mapping around Wageningen
# Script 06: Land-Cover Map
# ------------------------------------------------------------

library(terra)

# 1. Define project and output directories
project_dir <- "Project land cover"

output_dir <- file.path(
  project_dir,
  "output",
  "Project_01_Forest_LandCover"
)

# 2. Load raster
raster_file <- file.path(
  output_dir,
  "Wageningen_LandCover_2021.tif"
)

landcover <- rast(raster_file)

# 3. Define classes
class_codes <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 95, 100)

class_names <- c(
  "Tree cover",
  "Shrubland",
  "Grassland",
  "Cropland",
  "Built-up",
  "Bare / sparse vegetation",
  "Snow / ice",
  "Permanent water",
  "Herbaceous wetland",
  "Mangroves",
  "Moss / lichen"
)

class_colors <- c(
  "#006400",
  "#FFBB22",
  "#FFFF4C",
  "#F096FF",
  "#FA0000",
  "#B4B4B4",
  "#F0F0F0",
  "#0064C8",
  "#0096A0",
  "#00CF75",
  "#FAE6A0"
)

# 4. Reclassify values to IDs 1-11
landcover_map <- subst(
  landcover,
  from = class_codes,
  to = seq_along(class_codes)
)

# 5. Identify classes present in the study area
class_frequency <- freq(landcover)

present_codes <- class_frequency$value

present_indices <- match(present_codes, class_codes)

present_names <- class_names[present_indices]
present_colors <- class_colors[present_indices]

# 6. Create output file path
output_file <- file.path(
  output_dir,
  "figures",
  "landcover_map.png"
)

dir.create(
  dirname(output_file),
  recursive = TRUE,
  showWarnings = FALSE
)

# 7. Save map with separate legend panel
png(
  filename = output_file,
  width = 12,
  height = 8,
  units = "in",
  res = 300
)

# Create two panels: map and legend
layout(
  matrix(c(1, 2), nrow = 1),
  widths = c(4, 1.7)
)

# ---------------- MAP PANEL ----------------

par(mar = c(4, 4, 4, 1))

plot(
  landcover_map,
  col = class_colors,
  breaks = seq(0.5, 11.5, by = 1),
  axes = TRUE,
  legend = FALSE,
  main = "Land-Cover Map around Wageningen (2021)"
)

# ---------------- LEGEND PANEL ----------------

par(mar = c(1, 0, 2, 0))

plot.new()

legend(
  "center",
  legend = present_names,
  fill = present_colors,
  title = "Land-cover classes",
  bty = "n",
  cex = 0.85,
  xjust = 0,
  yjust = 0.5
)

# ---------------- SOURCE ----------------

mtext(
  "Data source: ESA WorldCover 2021",
  side = 1,
  outer = FALSE,
  line = -1,
  cex = 0.8
)

# Close PNG device
dev.off()

# Reset layout
layout(1)

# 8. Display completion message
cat("Map saved successfully:", output_file, "\n")
