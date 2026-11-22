
# Project 03: Forest Fragmentation Analysis
# Script 04: Forest Patch Metrics

library(terra)

# --------------------------------------------------
# 1. Define project directory
# --------------------------------------------------

project_dir <- "Project Forest fragmentation"

# --------------------------------------------------
# 2. Load forest patch raster
# --------------------------------------------------

patches <- rast(
  file.path(
    project_dir,
    "data",
    "Forest_Patches_Wageningen.tif"
  )
)

# --------------------------------------------------
# 3. Calculate patch area in hectares
# --------------------------------------------------

patch_area <- expanse(
  patches,
  unit = "ha",
  byValue = TRUE
)

# --------------------------------------------------
# 4. Convert results to data frame
# --------------------------------------------------

patch_table <- as.data.frame(patch_area)

# Keep patch ID and area columns
patch_table <- patch_table[, 2:3]

# Rename columns
names(patch_table) <- c(
  "Patch_ID",
  "Area_ha"
)

# --------------------------------------------------
# 5. Sort patches by area
# --------------------------------------------------

patch_table <- patch_table[
  order(-patch_table$Area_ha),
]

# --------------------------------------------------
# 6. Save patch metrics table
# --------------------------------------------------

write.csv(
  patch_table,
  file.path(
    project_dir,
    "outputs",
    "tables",
    "Forest_Patch_Area.csv"
  ),
  row.names = FALSE
)

# --------------------------------------------------
# 7. Display 10 largest forest patches
# --------------------------------------------------

print(
  head(patch_table, 10)
)

# --------------------------------------------------
# 8. Calculate summary statistics
# --------------------------------------------------

total_patches <- nrow(patch_table)

largest_patch <- max(
  patch_table$Area_ha,
  na.rm = TRUE
)

mean_patch_area <- mean(
  patch_table$Area_ha,
  na.rm = TRUE
)

cat("Total forest patches:", total_patches, "\n")
cat("Largest patch area (ha):", largest_patch, "\n")
cat("Mean patch area (ha):", mean_patch_area, "\n")

cat("Forest patch metrics completed!\n")
