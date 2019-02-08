mapa_zm <- function(colorHGO = "Yellow", colorCDMX = "Red", colorEDOMEX = "Green", labelMapa = paste0(ZMCM$NOM_MUN, ", ", ZMCM$ESTADO.C.31)) {
  ZMCM <- st_read('https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/EdosZM.geojson') 
  ZMCM_edos <- st_read('https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/EstadosZMVM.geojson')
  pal = colorFactor(palette = c(colorCDMX, colorHGO, colorEDOMEX), domain = c("09", "13", "15"))
  leaflet() %>%
    addPolygons(data = ZMCM, label = labelMapa, weight = 0.9, dashArray ="3,3",
                fillColor = ~pal(ZMCM$CVE_ENT), color = "gray") %>%
    addPolygons(data = ZMCM_edos, color="black", weight = 2, fill = F)
}
