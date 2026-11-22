
library(terra)

project_dir <- "Project Vegetation change"

# Load classified NDVI change
change_class <- rast(
  file.path(project_dir, "outputs", "NDVI_Change_Classes.tif")
)

# Define map colors
map_colors <- c(
  "#D73027",  # Decrease
  "#FFFFBF",  # Stable
  "#1A9850"   # Increase
)

# Save final map
png(
  file.path(project_dir, "outputs", "figures",
            "Final_NDVI_Change_Map.png"),
  width = 2000,
  height = 1600,
  res = 200
)

plot(
  change_class,
  col = map_colors,
  breaks = c(0.5, 1.5, 2.5, 3.5),
  main = "Vegetation Greenness Change\nWageningen (2025–2026)",
  axes = TRUE,
  plg = FALSE
)

legend(
  "bottomleft",
  legend = c(
    "Decrease",
    "Stable",
    "Increase"
  ),
  fill = map_colors,
  title = "NDVI Change",
  cex = 0.9,
  bg = "white"
)

dev.off()

cat("Final NDVI change map saved!\n")
