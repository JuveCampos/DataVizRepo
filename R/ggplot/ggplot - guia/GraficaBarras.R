# FUNCION GRAFICA DE BARRAS
graficas_base <- function(titulo = "", datos_x, datos_y,
                          estados_interes = c("Tamaulipas", 'Nacional'),
                          etiqueta_nacional = "Nacional",
                          color_estados_interes = "dodgerblue1",
                          color_base = "dimgray",
                          color_nacional = "gray",
                          mejorArriba = TRUE,
                          nombre_archivo = "grafica_",
                          highlightMinMax = TRUE,
                          etiqueta_numero = "",
                          subtitulo = NULL,
                          pie_de_pagina = NULL
                          ){


  pacman::p_load(tidyverse, rebus, leaflet)
  extrafont::fonts()

  # Librerias
  # require(showtext) # Importar tipos de letra de Google Fonts
  # Download a wefont
  # sysfonts::font_add_google(name = "Felipa", family = "Felipa", regular.wt = 400, bold.wt = 700)
  # Perhaps the only tricky bit is remembering to run the following function to enable webfonts
  # showtext::showtext_auto()

  cortaTitulos <- function(titulo){
    a <- strsplit(titulo, split = " ") %>% unlist()
    total <- sum(nchar(a))
    if(total > 50){
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
      a <- paste(a, collapse = ' ') %>%
        stringr::str_replace(pattern = "6°", replacement = "sexto") %>%
        stringr::str_replace(pattern = "3°", replacement = "tercero") %>%
        stringr::str_replace(pattern = "\n ", replacement = "\n")

      return(a)
    } else {
      a <- paste(a, collapse = ' ') %>%
        stringr::str_replace(pattern = "6°", replacement = "sexto") %>%
        stringr::str_replace(pattern = "3°", replacement = "tercero") %>%
        stringr::str_replace(pattern = "\n ", replacement = "\n")
      return(a)
    }
  }

  # ESTA SECCION DEL CODIGO QUEDA COMENTADA DADO QUE SE UTILIZA PARA HACER
  # LAS PRUEBAS
  ###########################################################
  # titulo <-  whiches$Indicador[1]
  # datos_x <- x
  # datos_y <- y
  # # estados_interes <- c("Tamaulipas", 'Nacional')
  # mejorArriba = TRUE
  # nombre_archivo <- "aaaaa"
  ###########################################################

  datos <- cbind(datos_x, datos_y) %>% as_tibble()
  datos$datos_y <- as.numeric(datos$datos_y)
  datos$datos_y <- round(datos$datos_y, 2)

  # Temas
  tema_propio <- theme_minimal() +
    theme(axis.line = element_line(size = 0.3),
          plot.title = element_text(hjust=0,
                                    size = 15,
                                    #color = "red",
                                    face="bold"),
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
          rect = element_rect(fill = "transparent")
    )

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

  if(highlightMinMax){
    estados_interes <- c(estados_interes, minimo, maximo)
  } else {
    estados_interes <- c(estados_interes)
  }

  # Etiquetas
  etiquetas <- c(rep("", length(datos_x)))
  etiquetas[str_detect(datos_x, or1(exactly(estados_interes)))] <- datos$datos_y[which(str_detect(datos_x, or1(exactly(estados_interes))))]

  etiquetas[str_detect(datos_x, or1(exactly(etiqueta_nacional)))] <- datos$datos_y[which(str_detect(datos_x, or1(exactly(etiqueta_nacional))))]

  etiquetas
  # as.numeric(etiquetas)
  etiquetas_pos  <- case_when(is.na(as.numeric(etiquetas)) ~ "",
                              as.numeric(etiquetas) < 0 ~ "",
                              as.numeric(etiquetas) > 0  ~ paste0(formato(as.numeric(etiquetas), 3), etiqueta_numero),
                              as.numeric(etiquetas) == 0 ~ paste0(formato(as.numeric(etiquetas), 3), etiqueta_numero))

  etiquetas_neg  <- case_when(is.na(as.numeric(etiquetas)) ~ "",
                              as.numeric(etiquetas) > 0 ~ "",
                              as.numeric(etiquetas) < 0 ~ paste0(formato(as.numeric(etiquetas), 3), etiqueta_numero))

  # Colores
  colores <- c(rep("base", length(datos_x)))
  #colores[str_detect(datos_x, pattern = estados_interes[1])]   <- "Estado_interes"
  colores[str_detect(datos_x, pattern = or1(estados_interes))] <- "Estado_interes"
  colores[str_detect(datos_x, pattern = etiqueta_nacional)]    <- "Nacional"
  #colores[str_detect(datos_x, pattern = minimo)] <- "Minimo"
  #colores[str_detect(datos_x, pattern = maximo)] <- "Maximo"
  colores

  pal <- leaflet::colorFactor(palette = c(color_base,
                                   color_estados_interes,
                                   color_nacional),
                              domain = c("base", "Estado_interes", "Nacional"))

  # Limites de los ejes #
  lim_inicial <- 0
  if(min(datos_y, na.rm = FALSE) < 0){
    lim_inicial <- min(datos_y, na.rm = FALSE) * 1.3
  } else {
    lim_inicial <- 0
  }

  # Orden
  if (mejorArriba == TRUE){
    # inicializacion
    p <-  ggplot(data = datos, aes(x = reorder(datos_x, datos_y), y = datos_y, fill = colores))
  } else {
    p <-  ggplot(data = datos, aes(x = reorder(datos_x, -datos_y), y = datos_y, fill = colores))
  }

  # tipo de grafico
  p <- p + geom_bar(stat = 'identity', show.legend = FALSE, width = 0.8) +
    # limites
    #ylim(datos_y[which(datos_x == minimo)], datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo])) +

    ### ylim(lim_inicial, datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo]))  +
    #ylim(lim_inicial, datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo]), expand = c(0, 0)) +
    scale_y_continuous(limits = c(lim_inicial, datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo])), expand = c(0, 0)) +

    #scale_y_continuous(expand = c(0,0)) +
    # ylim(0, datos_y[which(datos_x == maximo)] + 0.3*(datos_y[datos_x == maximo])) +
    # Colores

    scale_fill_manual(values = c(color_base,
                                 color_estados_interes,
                                 color_nacional)) +
    tema_propio + theme(axis.text.x=element_blank(),
                        axis.text.y = element_text(face = "bold",  size = 12),
                        legend.text = element_text(face = "bold",  size = 15),
                        axis.title.x = element_text(face = "bold", size = 15),
                        axis.title.y = element_text(face = "bold", size = 15),
                        plot.caption = element_text(size = 10),
                        axis.line = element_blank(),
                        legend.position="top") +
    # labels
    ggtitle(cortaTitulos(titulo)) +
    labs(subtitle = subtitulo,
         caption = pie_de_pagina) +
    xlab("") +
    ylab("") +
    # opciones adicionales
    coord_flip() +  # Voltea los ejes :3
    geom_text(aes(label = etiquetas_pos, fontface = "bold"),
              colour = pal(colores),
              #fontface = "bold",
              size = 6,
              hjust = -0.2
    ) +
    geom_text(aes(label = etiquetas_neg, fontface = "bold"),
              colour = pal(colores),
              #fontface = "bold",
              size = 6,
              hjust = 1.2
              )

  # Cambiamos fuentes y tipos de letra
  #p <- p + theme(text=element_text(size=16,  family="Comic sans"))
  p

  ggsave(paste0(nombre_archivo, ".png"),
         plot = p,
         dpi = 100,
         bg = "transparent",
         width = 200,                  # Ancho de la gráfica
         height =160,
         units = "mm")

  return(p)

}

#
# x <- letters
# y <- rnorm(n = 26) * 1000000
# cbind.data.frame(x,y)
#
# y[10] <- 0
#
# args(graficas_base)
# graficas_base(datos_x = x, datos_y = y, estados_interes = c("j", "m", "o", "v", "t", "w"),
#               etiqueta_nacional = "q",
#               color_nacional = "green",
#               color_base = "red",
#               mejorArriba = F,
#               highlightMinMax = TRUE,
#               etiqueta_numero = "%")
#
