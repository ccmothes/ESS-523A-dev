# create an elevation profile for the Poudre Canyon Highway

#convert line to points
segments <- poudre_hwy %>%
  filter(LINEARID != 1103691319224) %>% 
  st_segmentize(dfMaxLength = 500) %>% 
  st_cast("POINT") %>% 
  #arrange by longitude
  arrange(geometry)


#extract elevation at points
segments$elevation <- extract(elevation_crop, segments)[,2]

tm_shape(segments)+
  tm_dots(col = "elevation")


hwy_elevation <- extract(elevation_crop, segments)

ggplot(hwy_elevation)+
  geom_line(aes(x = ID, y = Elevation))
