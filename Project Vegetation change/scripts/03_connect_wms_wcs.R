
# ------------------------------------------------------------
# Project 02: Vegetation Change Detection
# Script 03: Download Sentinel-2 imagery from public archive
# ------------------------------------------------------------

# Install packages
packages <- c("terra", "httr2", "jsonlite")

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

library(terra)
library(httr2)
library(jsonlite)

# ------------------------------------------------------------
# Project paths
# ------------------------------------------------------------

project_dir <- "Project Vegetation change"

data_dir <- file.path(project_dir, "data")
output_dir <- file.path(project_dir, "outputs")

dir.create(data_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

# ------------------------------------------------------------
# Study area: Wageningen
# ------------------------------------------------------------

aoi <- as.polygons(
  ext(5.55, 5.78, 51.85, 52.08),
  crs = "EPSG:4326"
)

# Save study area
writeVector(
  aoi,
  file.path(data_dir, "Wageningen_study_area.gpkg"),
  overwrite = TRUE
)

# ------------------------------------------------------------
# Public Earth Search STAC API
# ------------------------------------------------------------

stac_url <- "https://earth-search.aws.element84.com/v1/search"

# ------------------------------------------------------------
# Function to search and download imagery for one year
# ------------------------------------------------------------

download_sentinel <- function(year) {

  cat("\nSearching Sentinel-2 imagery for", year, "...\n")

  start_date <- paste0(year, "-06-01T00:00:00Z")
  end_date   <- paste0(year, "-08-31T23:59:59Z")

  search_body <- list(
    collections = list("sentinel-2-c1-l2a"),
    bbox = list(5.55, 51.85, 5.78, 52.08),
    datetime = paste(start_date, end_date, sep = "/"),
    limit = 100,
    query = list(
      "eo:cloud_cover" = list(lt = 30)
    )
  )

  response <- request(stac_url) |>
    req_method("POST") |>
    req_body_json(search_body) |>
    req_perform()

  result <- fromJSON(
    resp_body_string(response),
    simplifyVector = FALSE
  )

  items <- result$features

  if (length(items) == 0) {
    stop("No Sentinel-2 scenes found for ", year)
  }

  # Select the scene with the lowest cloud cover
  cloud_values <- vapply(
    items,
    function(item) {
      item$properties[["eo:cloud_cover"]]
    },
    numeric(1)
  )

  best_item <- items[[which.min(cloud_values)]]

  cat("Selected scene:", best_item$id, "\n")
  cat("Cloud cover:", min(cloud_values), "%\n")

  # Get band URLs
  red_url <- best_item$assets$red$href
  nir_url <- best_item$assets$nir$href

  if (is.null(red_url) || is.null(nir_url)) {
    stop("Red or NIR band not found in selected scene.")
  }

  # Read remote Cloud-Optimized GeoTIFFs
  red_band <- rast(red_url)
  nir_band <- rast(nir_url)

  # Reproject study area to raster CRS
  aoi_projected <- project(
    aoi,
    crs(red_band)
  )

  # Crop and mask to Wageningen
  red_crop <- crop(
    red_band,
    aoi_projected,
    mask = TRUE
  )

  nir_crop <- crop(
    nir_band,
    aoi_projected,
    mask = TRUE
  )

  # Save downloaded bands locally
  red_file <- file.path(
    data_dir,
    paste0("Sentinel2_Red_", year, ".tif")
  )

  nir_file <- file.path(
    data_dir,
    paste0("Sentinel2_NIR_", year, ".tif")
  )

  writeRaster(
    red_crop,
    red_file,
    overwrite = TRUE
  )

  writeRaster(
    nir_crop,
    nir_file,
    overwrite = TRUE
  )

  # Calculate NDVI
  ndvi <- (nir_crop - red_crop) /
          (nir_crop + red_crop)

  names(ndvi) <- paste0("NDVI_", year)

  ndvi_file <- file.path(
    output_dir,
    paste0("NDVI_Wageningen_", year, ".tif")
  )

  writeRaster(
    ndvi,
    ndvi_file,
    overwrite = TRUE
  )

  cat("Saved Red band:", red_file, "\n")
  cat("Saved NIR band:", nir_file, "\n")
  cat("Saved NDVI:", ndvi_file, "\n")

  return(ndvi)
}

# ------------------------------------------------------------
# Download summer imagery for 2025 and 2026
# ------------------------------------------------------------

ndvi_2025 <- download_sentinel(2025)
ndvi_2026 <- download_sentinel(2026)

cat("\nSentinel-2 download and NDVI calculation completed!\n")
