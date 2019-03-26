#########################################
# Leaflet - Incluir una flecha de Norte #
#########################################

# Hacemos la función para incluir al norte 
norte <- function(mapa_leaflet, ancho = 40, posicion = 'topright'){
  # 1. Descargamos la imagen
  
  north.arrow.icon <- paste0("<img src='http://ian.umces.edu/imagelibrary/albums/userpics/10002/normal_ian-symbol-north-arrow-2.png' style='width:",
         as.character(ancho), "px;height:", 
         as.character(1.5 * ancho), "px;'>")
  
  # Lo incluimos en una funcion de RLeaflet
  if (!require("leaflet")) install.packages("leaflet") # Asegurarnos que este instalado Leaflet
  addControl(mapa_leaflet, 
             html = north.arrow.icon, position = posicion, 
             className = "fieldset {
             border: 0;}") 
}


# # Ejemplo
# info_geo <- sf::st_read("https://github.com/JuveCampos/Shapes_Resiliencia_CDMX_CIDE/raw/master/Zona%20Metropolitana/EdosZM.geojson")
# library(leaflet)
# leaflet(info_geo) %>%
#   addTiles() %>%
#   addPolygons() %>%
#   norte()
