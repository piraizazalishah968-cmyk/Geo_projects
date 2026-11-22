
# Project 03: Forest Fragmentation Analysis
# Script 05: Landscape Fragmentation Metrics

library(terra)

# Define project directory
project_dir <- "Project Forest fragmentation"

# Load forest patch metrics
patch_table <- read.csv(
  file.path(
    project_dir,
    "outputs",
    "tables",
    "Forest_Patch_Area.csv"
  )
)

# Calculate landscape metrics
total_patches <- nrow(patch_table)

total_forest_area <- sum(
  patch_table$Area_ha,
  na.rm = TRUE
)

mean_patch_area <- mean(
  patch_table$Area_ha,
  na.rm = TRUE
)

largest_patch_area <- max(
  patch_table$Area_ha,
  na.rm = TRUE
)

# Create summary table
landscape_metrics <- data.frame(
  Metric = c(
    "Number of Forest Patches",
    "Total Forest Area (ha)",
    "Mean Patch Area (ha)",
    "Largest Patch Area (ha)"
  ),
  Value = c(
    total_patches,
    total_forest_area,
    mean_patch_area,
    largest_patch_area
  )
)

# Save landscape metrics
write.csv(
  landscape_metrics,
  file.path(
    project_dir,
    "outputs",
    "tables",
    "Landscape_Fragmentation_Metrics.csv"
  ),
  row.names = FALSE
)

# Display results
print(landscape_metrics)

cat("Landscape fragmentation metrics completed!\n")
