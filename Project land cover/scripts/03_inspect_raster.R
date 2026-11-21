

# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Script: 03_inspect_raster.R
# Purpose: Load and inspect ESA WorldCover raster data
# ============================================================

# 1. Load package
library(terra)

# 2. Define project directory
project_dir <- "Project land cover"

# 3. Define data directory
data_dir <- file.path(project_dir, "data")

# 4. Define raster filename
file_name <- "ESA_WorldCover_10m_2021_v200_N51E003_Map.tif"

# 5. Construct file path
raster_file <- file.path(data_dir, file_name)

# 6. Check whether file exists
file.exists(raster_file)

# 7. Load raster
landcover <- rast(raster_file)

# 8. Print raster information
landcover

# 9. Raster dimensions
nrow(landcover)
ncol(landcover)
nlyr(landcover)
dim(landcover)

# 10. Spatial resolution
res(landcover)

# 11. Coordinate reference system
crs(landcover)

# 12. Spatial extent
ext(landcover)

# 13. Land-cover value frequencies
freq(landcover)

# 14. Plot raster
plot(landcover, main = "ESA WorldCover 2021")
