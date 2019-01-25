mapa_zm <- function(colorHGO = "Yellow", colorCDMX = "Red", colorEDOMEX = "Green") {
  # Bases de datos
  # MUNICIPIOS ZMVM
  ZMCM <- st_read('https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/EdosZM.geojson') 
  # ESTADOS ZMVM
  ZMCM_edos <- st_read('https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/EstadosZMVM.geojson')
  
  
  # Paleta de Colores
  pal = colorFactor(palette = c("Red", "Yellow", "Green"), domain = c("09", "13", "15"))
  
  # Leaflet
  leaflet() %>%
    addPolygons(data = ZMCM, label = paste0(ZMCM$NOM_MUN, ", ", ZMCM$ESTADO.C.31), weight = 0.9, dashArray ="3,3",
                fillColor = ~pal(ZMCM$CVE_ENT), color = "gray") %>%
    addPolygons(data = ZMCM_edos, color="black", weight = 2, fill = F)
}

mapa_zm <- mapa_zm()
saveRDS(mapa_zm, "Mapa_zm.rds")

