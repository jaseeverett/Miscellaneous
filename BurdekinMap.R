library(tidyverse)
library(sf)
library(rnaturalearth)

# sf <- st_read("Data/RiverBasins/River_basins.shp") %>% 
#   filter(RIVER_NAME == "Burdekin River")

# sf <- st_read("Data/WatercourseAreas/Watercourse_areas.shp") %>%
  # filter(NAME == "Burdekin River")

sf <- st_read("Data/MajorWatercourses/Major_watercourse_lines.shp") %>% 
  filter(NAME == "Burdekin River")

dat <- read_csv("BurdekinSites.csv") %>% 
  st_as_sf(coords = c("Lon", "Lat")) %>% 
  st_set_crs("EPSG:4326") %>% 
  st_make_valid()

# ne <- ne_countries(country = "Australia", scale = "large", returnclass = "sf")
# ne <- st_read("Data/Coastline/Coastline_and_State_border.shp")
ne <- st_read("Data/AustraliaCoastline/aust_cd66states.shp") %>% 
  filter(STE == 3) %>% 
  st_set_crs("EPSG:4326")

ggplot() + 
  geom_sf(data = ne) +
  geom_sf(data = dat, colour = "red") + 
  geom_sf(data = sf) +
  coord_sf(xlim = c(146, 148.5), ylim = c(-20.75, -18.25), expand = FALSE) + 
  theme_bw() + 
  theme(text = element_text(size = 16), axis.title = element_blank()) + 
  annotate("text", x = 146.5, y = -19.95, label = "Burdekin River", angle = -41, size = 5)

ggsave("Figures/BurdekinMap.pdf")
