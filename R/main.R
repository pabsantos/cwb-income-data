library(censobr)
library(tidyverse)
library(geobr)
library(sf)

tracts <- read_tracts(
  year = 2010,
  dataset = "Basico",
  as_data_frame = TRUE
)

cwb_tracts_data <- tracts |> 
  filter(code_muni == 4106902)

cwb_tracts <- read_census_tract(
  year = 2010,
  code_tract = 4106902
)

cwb_tracts_final <- cwb_tracts |> 
  select(code_tract, name_muni, name_neighborhood) |> 
  left_join(cwb_tracts_data, by = "code_tract")

st_write(cwb_tracts_final, "data/cwb_tracts.gpkg", append = FALSE)
