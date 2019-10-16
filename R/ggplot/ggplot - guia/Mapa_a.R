library(pacman)
p_load(dplyr, tidyverse, janitor, sf, tmap, spData, RColorBrewer, readxl)


df_estados <- st_read("C:/Users/CIDE/Documents/Mapas/Estados_2015/dest_2015gw.shp")
df_estados <- clean_names(df_estados)

df_mapa_politico <- read_excel("Geopolitica.xlsx")
df_mapa_politico <- clean_names(df_mapa_politico)
df_mapa_politico <- df_mapa_politico %>% 
  rename(cve_ent = region) %>% 
  select(-estado)

df_estados_mapa_politico <- df_estados %>% 
  left_join(df_mapa_politico, by = "cve_ent")


df_estados_mapa_politico %>% 
  ggplot() +
  geom_sf(aes(fill = factor(partido_gobernante,
                            levels = c("PAN",
                                       "PRI",
                                       "PRD",
                                       "MC",
                                       "PES",
                                       "MORENA",
                                       "INDEPENDIENTE")))) +
  scale_fill_manual(values = c("blue",
                               "green",
                               "yellow",
                               "orange",
                               "white",
                               "red",
                               "grey")) +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank())
