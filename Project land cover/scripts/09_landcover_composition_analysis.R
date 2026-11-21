
# ------------------------------------------------------------
# Project 01: Forest & Land-Cover Mapping around Wageningen
# Script 09: Land-cover Composition Analysis
# ------------------------------------------------------------

# Define project and output directories
project_dir <- "Project land cover"

output_dir <- file.path(
  project_dir,
  "output",
  "Project_01_Forest_LandCover"
)

table_dir <- file.path(output_dir, "tables")
figure_dir <- file.path(output_dir, "figures")

# ------------------------------------------------------------
# Load the existing land-cover summary
# ------------------------------------------------------------

summary_file <- file.path(
  table_dir,
  "landcover_class_summary.csv"
)

landcover_summary <- read.csv(summary_file)

# Inspect the data
print(landcover_summary)
str(landcover_summary)


# ------------------------------------------------------------
# Visualize land-cover composition
# ------------------------------------------------------------

# Land-cover composition chart with percentage labels

bar_positions <- barplot(
  landcover_summary$percentage,
  names.arg = landcover_summary$class_name,
  horiz = TRUE,
  las = 1,
  col = "forestgreen",
  border = NA,
  main = "Land-Cover Composition around Wageningen (2021)",
  xlab = "Land cover (%)",
  cex.names = 0.8,
  xlim = c(0, max(landcover_summary$percentage) + 6)
)

# Add percentage labels
text(
  x = landcover_summary$percentage,
  y = bar_positions,
  labels = paste0(round(landcover_summary$percentage, 2), "%"),
  pos = 4,
  cex = 0.8
)


# ------------------------------------------------------------
# Save land-cover composition chart
# ------------------------------------------------------------

output_file <- file.path(
  figure_dir,
  "landcover_composition.png"
)

png(
  filename = output_file,
  width = 10,
  height = 7,
  units = "in",
  res = 300
)

bar_positions <- barplot(
  landcover_summary$percentage,
  names.arg = landcover_summary$class_name,
  horiz = TRUE,
  las = 1,
  col = "forestgreen",
  border = NA,
  main = "Land-Cover Composition around Wageningen (2021)",
  xlab = "Land cover (%)",
  cex.names = 0.8,
  xlim = c(0, max(landcover_summary$percentage) + 6)
)

text(
  x = landcover_summary$percentage,
  y = bar_positions,
  labels = paste0(round(landcover_summary$percentage, 2), "%"),
  pos = 4,
  cex = 0.8
)

dev.off()
