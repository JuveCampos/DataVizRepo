# Funcion para hacer mapas en ggplot
# Al estilo grossenbacher
grossenbacher <- function(mapa,
                          var_interes,
                          pretty_breaks, 
                          titulo = "", 
                          subtitulo = "", 
                          pie_de_pagina = "",
                          titulo_leyenda = "", 
                          line_color = "white"
){
  # # Generamos los breaks de la leyenda
  # pretty_breaks <- c(1, 50, 100, 500, 1000, 1500, 2000)
  # 
  library(pacman)
  p_load(tidyverse, leaflet, stringr)
  
  # Tema de mi mapa de ggplot
  theme_map <- function(...) {
    theme_minimal() +
      theme(
        # Nota! Instalen esta fuente primero!!
        text = element_text(family = "Asap-Bold", color = "#22211d"),
        axis.line = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        # panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
        panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "white", color = NA), 
        panel.background = element_rect(fill = "#e0fffc", color = NA), 
        legend.background = element_rect(fill = "white", color = NA),
        panel.border = element_blank(),
        plot.title = element_text(hjust = 0.5, size = 24, color = "#ffc02b"), 
        plot.subtitle = element_text(hjust = 0.5, size = 20),
        ...
      )
  }
  
  
  # mapa <- mapa#,
  #  var_interes = "interes_btc"#, 
  # pretty_breaks = seq(10,90,10)
  
  # Valor minimo
  minVal <- min(mapa %>% pull(var_interes), na.rm = T)
  # Valor maximo
  maxVal <- max(mapa %>% pull(var_interes), na.rm = T)
  
  # compute labels
  labels <- c()
  brks <- c(minVal, pretty_breaks, maxVal) %>% 
    sort() 
  brks <- brks[brks >= minVal] %>% 
    unique()
  
  # round the labels (actually, only the extremes)
  for(idx in 1:length(brks)){
    labels <- c(labels,round(brks[idx + 1], 2))
  }
  labels <- labels[1:length(labels)-1]
  
  # define a new variable on the data set just as above
  mapa$brks <- cut(mapa %>% pull(var_interes), 
                   breaks = brks, 
                   include.lowest = TRUE, 
                   labels = labels)
  brks_scale <- levels(mapa$brks)
  labels_scale <- rev(brks_scale)
  
  # Paleta de colores
  pal <- leaflet::colorFactor(palette = "YlOrRd", 
                              domain = brks)
  
  # Ahora si, hacemos el mapa. 
  mapa %>% 
    ggplot(aes(fill = brks)) +
    geom_sf(color = line_color) + 
    #scale_fill_distiller(palette = "Greens", direction = 1) + 
    theme_map() +
    theme(legend.position = "bottom") + 
    labs(title = titulo, 
         subtitle = subtitulo, 
         # tag  = "Alumnos: ",
         caption = pie_de_pagina) + 
    scale_fill_manual(
      # in manual scales, one has to define colors, well, manually
      # I can directly access them using viridis' magma-function
      #values = rev(viridis::viridis(length(brks))),
      values = pal(brks),
      breaks = rev(brks_scale),
      name = titulo_leyenda,
      drop = FALSE,
      labels = labels_scale,
      guide = guide_legend(
        direction = "horizontal",
        keyheight = unit(2, units = "mm"),
        keywidth = unit(70 / length(labels), units = "mm"),
        title.position = 'top',
        # I shift the labels around, the should be placed 
        # exactly at the right end of each legend key
        title.hjust = 0.5,
        label.hjust = 1,
        nrow = 1,
        byrow = T,
        # also the guide needs to be reversed
        reverse = T,
        label.position = "bottom"
      )
    )  
  
}
