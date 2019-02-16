# FUNCION GRAFICA DE BARRAS

graficas_base <- function(titulo = "", datos_x, datos_y, estados_interes = c("Tamaulipas", 'Nacional')){
  
  cortaTitulos <- function(titulo){
    a <- strsplit(titulo, split = " ") %>% unlist()
    total <- sum(nchar(a))
    if(total > 80){
      corte <- round(total/2)
    j <- 0
    for (i in 1:length(a)){
      if(j <= corte){
        #    i <- 14
        j <- sum(j, nchar(a[i]))
        j
      } else {
        a[i] <- paste(a[i], "\n")
        break
      } 
    }
    a <- paste(a, collapse = ' ')
    return(a)
    } else {
      a <- paste(a, collapse = ' ')
      return(a)
    }
  }

# Datos
  titulo <-  base_fil$Indicador[1]
  datos_x <- base_fil$ent
  datos_y <- base_fil$valor
  estados_interes <- c("Tamaulipas", 'Nacional')
  datos <- cbind(datos_x, datos_y) %>% as_tibble()
  datos$datos_y <- as.numeric(datos$datos_y)
  datos$datos_y <- round(datos$datos_y, 2)
  
  # Temas
  tema_propio <- theme_minimal() +
    theme(axis.line = element_line(size = 0.3),
           plot.title = element_text(hjust=0, 
                                     size = 14),
          plot.subtitle = element_text(hjust=0.5,
                                       size = 12,
                                       color = "gray50"),
          plot.caption =  element_text(color = "gray50",
                                       size=10, 
                                       hjust=0),
          #        panel.grid = element_line(linetype = 2), 
          panel.grid = element_blank(),
          panel.grid.minor = element_blank(),
          strip.background = element_rect(fill="gray99", 
                                          linetype="blank"),
          panel.border = element_rect(color = "gray98",
                                      fill=NA),
          rect = element_rect(fill = "transparent"))
  
  # Funciones dentro de la funcion
  formato <- function(numero, dgt = 0) {
    format(numero, 
           big.mark = ",", 
           scientific = FALSE, 
           trim = TRUE, 
           digits = dgt)}
  
  myLabelFormat = function(..., reverse_order = FALSE){ 
    if(reverse_order){ 
      function(type = "numeric", cuts){ 
        cuts <- sort(cuts, decreasing = T)
      } 
    }else{
      labelFormat(...)
    }
  }
  
  # Colores (me arroja el min, max, interes y nacional)
  minimo         <- datos_x[which(datos_y == min(datos_y, na.rm = FALSE))]
  minimo         <- sort(minimo)[1] 
  maximo         <- datos_x[which(datos_y == max(datos_y, na.rm = FALSE))]
  maximo         <- maximo[1]
  estados_interes <- c(estados_interes, minimo, maximo)
  
  # Etiquetas
  etiquetas <- c(rep("", length(datos_x))) 
  etiquetas[str_detect(datos_x, or1(exactly(estados_interes)))] <- 
    datos$datos_y[which(str_detect(datos_x, or1(exactly(estados_interes))))]
  etiquetas 
  # as.numeric(etiquetas)
  etiquetas_pos  <- case_when(is.na(as.numeric(etiquetas)) ~ "", 
                             as.numeric(etiquetas) < 0 ~ "", 
                             as.numeric(etiquetas) > 0 ~ formato(as.numeric(etiquetas), 3)
                             )
  
  etiquetas_neg  <- case_when(is.na(as.numeric(etiquetas)) ~ "", 
                              as.numeric(etiquetas) > 0 ~ "", 
                              as.numeric(etiquetas) < 0 ~ formato(as.numeric(etiquetas), 3)
  )
  
  # Colores
  colores <- c(rep("base", length(datos_x)))
  colores[str_detect(datos_x, pattern = estados_interes[1])] <- "Estado_interes"
  colores[str_detect(datos_x, pattern = estados_interes[2])] <- "Nacional"
  #colores[str_detect(datos_x, pattern = minimo)] <- "Minimo"
  #colores[str_detect(datos_x, pattern = maximo)] <- "Maximo"
  colores  
  
lim_inicial <- 0
if(min(datos_y, na.rm = FALSE) < 0){
  lim_inicial <- min(datos_y, na.rm = FALSE) * 1.3
} else {
  lim_inicial <- 0
}
  
  # inicializacion
p <-  ggplot(data = datos, aes(x = reorder(datos_x, datos_y), y = datos_y, fill = colores)) + 
    # tipo de grafico
    geom_bar(stat = 'identity', show.legend = FALSE) + 
    # limites 
    #ylim(datos_y[which(datos_x == minimo)], datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo])) +
    ylim(lim_inicial, datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo]))  +
    #scale_y_continuous(expand = c(0,0)) + 
    # ylim(0, datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo])) +
    # Colores
    scale_fill_manual(values = c('dimgray', 
                                 'dodgerblue1', 
                                 #'red', 
                                 #'turquoise', 
                                 'gray')) + 
    tema_propio + theme(axis.text.x=element_blank(),
                        axis.text.y = element_text(face = "bold", size = 12),
                        legend.text = element_text(face = "bold", size = 15),
                        axis.title.x = element_text(face = "bold", size = 15),
                        axis.title.y = element_text(face = "bold", size = 15),
                        plot.caption = element_text(size = 10),
                        axis.line = element_blank(),
                        legend.position="top") + 
    # labels
    ggtitle(cortaTitulos(titulo)) + 
    xlab("") +
    ylab("") + 
    # opciones adicionales
    coord_flip() +  # Voltea los ejes :3
    geom_text(aes(label = etiquetas_pos), 
              colour = 'black',
              fontface = 'bold',
              size = 4, 
              hjust = -0.2
    ) + 
  geom_text(aes(label = etiquetas_neg), 
            colour = 'black',
            fontface = 'bold',
            size = 4, 
            hjust = 1.2)

p
ggsave(paste0("graficas/", str_replace(titulo, pattern = "/", replacement = "-"), ".png"),
         plot = p,
         bg = "transparent",
         width = 260,                  # Ancho de la gráfica
         height =150,
         units = "mm")
} 

