
# ============================================================
# Project 1: Forest & Land-Cover Mapping
# Script: 03_inspect_raster.R
# Purpose: Load and inspect ESA WorldCover raster data
# ============================================================

# 1. Load package
library(terra)

# 2. Define data directory
data_dir <- "data"

# 3. Define raster filename
file_name <- "ESA_WorldCover_10m_2021_v200_N51E003_Map.tif"

# 4. Construct file path
raster_file <- file.path(data_dir, file_name)

# 5. Check whether file exists
file.exists(raster_file)

# 6. Load raster
landcover <- rast(raster_file)

# 7. Print raster information
landcover

# 8. Raster dimensions
nrow(landcover)
ncol(landcover)
nlyr(landcover)
dim(landcover)

# 9. Spatial resolution
res(landcover)

# 10. Coordinate reference system
crs(landcover)

# 11. Spatial extent
ext(landcover)

# 12. Land-cover value frequencies
freq(landcover)

# 13. Plot raster
plot(landcover, main = "ESA WorldCover 2021")
