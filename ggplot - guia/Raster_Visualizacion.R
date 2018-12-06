
library(raster)    
library(rasterVis)
library(RColorBrewer)

## Create a matrix with random data & use image()
# Creamos una matriz de datos aleatorios de 20 x 20 y checamos 
# como se veria como raster utilizando la funcion `image`.
  xy <- matrix(rnorm(400),20,20)
  raster::image(xy)

# Convertimos la matriz en un raster
  rast <- raster(xy)
  class(rast)

# Le damos coordenadas lat/long de 36-37°E, 3-2°S
# Lo que hace `extent` es tomar el inicio, el final, restarlos y dividir cada cell en una unidad de la division. 
  raster::extent(rast) <- c(36,37,-3,-2) # Par: {x_inic, x_fin, y_inic, y_fin}
  plot(rast)
  
# Asignamos una proyeccion al raster
projection(rast) <- sp::CRS("+proj=longlat +datum=WGS84")
plot(rast)

# Creamos un tema de 'rasterVis'
#PAR: paleta de colores (vector con colores hex)
mapTheme <- rasterVis::rasterTheme(region=brewer.pal(8,"Greens"))      

# Creamos la imagen con el tema basico y modificaciones en las etiquetas.
plt <- rasterVis::levelplot(rast, margin = F, 
                            par.settings = mapTheme, 
                            main = "Mapa de Prueba", 
                            xlab = "Longitud", 
                            ylab = "Latitud") 
# Mostramos la grafica
png(filename="rastercito.png")
plt
dev.off()




