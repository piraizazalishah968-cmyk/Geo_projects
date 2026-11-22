
# GEO_PROJECTS

A geospatial portfolio showcasing practical applications of remote sensing, GIS, and spatial analysis using R. This repository documents projects focused on land-cover mapping, vegetation monitoring, and forest landscape analysis around Wageningen, the Netherlands.

## Projects

### Project 01 — Forest & Land-Cover Mapping

**Objective:** Map and quantify forest and non-forest land-cover distribution around Wageningen using ESA WorldCover 2021.

**Data and methods:**
- ESA WorldCover 2021 (10 m resolution)
- Raster cropping and masking
- Land-cover classification
- Area calculation and percentage analysis
- Thematic map production

**Results:**

| Land-cover group | Area (ha) | Percentage |
|---|---:|---:|
| Forest / tree cover | 11,472.55 | 26.2% |
| Non-forest | 32,319.29 | 73.8% |
| **Total** | **43,791.84** | **100%** |

### Project 02 — Vegetation Change Detection

**Objective:** Assess changes in vegetation greenness around Wageningen between summer 2025 and summer 2026 using Sentinel-2 satellite imagery.

**Data and methods:**
- Sentinel-2 Level-2A imagery
- Earth Search STAC API
- Red and near-infrared bands
- Normalized Difference Vegetation Index (NDVI)
- NDVI difference analysis
- Vegetation change classification
- Area statistics and map visualization

**Change calculation:**

`NDVI Change = NDVI 2026 − NDVI 2025`

Change categories:
- **Decrease:** NDVI change < -0.05
- **Stable:** -0.05 to 0.05
- **Increase:** NDVI change > 0.05

The results represent observed differences in vegetation greenness between selected satellite scenes.

### Project 03 — Forest Fragmentation Analysis

**Objective:** Examine the spatial distribution and configuration of forest patches around Wageningen using ESA WorldCover 2021.

**Data and methods:**
- ESA WorldCover 2021
- Tree-cover class extraction (class 10)
- Forest-cover raster preparation
- Forest patch identification using 8-neighbour connectivity
- Forest patch area calculation
- Landscape-level fragmentation metrics
- Forest patch mapping

**Metrics:**
- Number of forest patches
- Total forest area
- Mean patch area
- Largest patch area

The analysis describes forest patch patterns at the 10 m land-cover data resolution.

## Software and Tools

- R
- Positron
- `terra`
- GIS and raster analysis
- Remote sensing
- Sentinel-2
- ESA WorldCover
- Git and GitHub

## Repository Structure

```text
GEO_PROJECTS/
├── Project land cover/
├── Project Vegetation change/
├── Project Forest fragmentation/
└── README.md
```

Each project directory contains its own scripts, data, outputs, figures, tables, and documentation.

## Project Scope

These projects demonstrate geospatial data processing, remote sensing workflows, raster analysis, land-cover assessment, vegetation change detection, and landscape pattern analysis using open geospatial datasets.
