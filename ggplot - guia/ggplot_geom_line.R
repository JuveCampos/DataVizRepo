# ggplot geomline

# LIBRERIAS
library(ggplot2)
library(ggthemes)
library(plotly)


#####################
# Plot con numerics #
#####################
a <- c(1:12)
b <- runif(n = 12, min = 0, max = 12)

c <- as.data.frame(cbind(a,b))
class(c$a) #Numeric
class(c$b) #Numeric

ggplot(data = c, aes(x = a, y = b)) + geom_line() 


####################
# Plot con factors #
#####################

# Ploteo de una linea con eje x factor (valor unico) y eje y numerico.
a <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j","k", "l")
length(a)
b <- runif(n = 12, min = 0, max = 12)
c <- as.data.frame(cbind(a,b))
class(c$a)
class(c$b)
c$b <- as.numeric(c$b)
class(c$b)

# Gráfica Básica
ggplot(data = c, aes(x = a, y = b, group=1)) + geom_line()

# Gráfica con titulo y etiqueta de ejes de colores 
ggplot(data = c, aes(x = a, y = b, group=1)) + 
  geom_line() + 
  ggtitle("Datos Aleatorios \n en funcion de un grupo \n alfabético") +
  theme (plot.title = element_text(#family="Times New Roman",
    size=rel(2), #Tamaño relativo de la letra del título
    vjust=2, #Justificación vertical, para separarlo del gráfico
    face="bold", #Letra negrilla. Otras posibilidades "plain", "italic", "bold" y "bold.italic"
    color="red", #Color del texto
    lineheight=1.5)) + #Separación entre líneas
  labs(x = "Clases de la información",y = "Valores") + # Etiquetas o títulos de los ejes
  theme(axis.title.x = element_text(face="bold", vjust=-0.5, colour="orange", size=rel(1.5))) + # Color y forma eje de las x
  theme(axis.title.y = element_text(face="bold", vjust=1.5, colour="blue", size=rel(1.5)))      # Color y forma eje de las y


# Gráfica con titulo y etiqueta de ejes de colores + linea de colores
ggplot(data = c, aes(x = a, y = b, group=1)) + 
  geom_line(colour = "#7fc0f9", size = 2) + 
  ggtitle("Datos Aleatorios en funcion de un grupo \n alfabético") +
  theme(plot.title = element_text(
    family="sans",
    size=rel(1), #Tamaño relativo de la letra del título
    vjust=2, #Justificación vertical, para separarlo del gráfico
    hjust = 0.5,
    face="bold", #Letra negrilla. Otras posibilidades "plain", "italic", "bold" y "bold.italic"
    color="red", #Color del texto
    lineheight=1)) + #Separación entre líneas
  labs(x = "Clases de la información",y = "Valores") + # Etiquetas o títulos de los ejes
  theme(axis.title.x = element_text(face="bold", vjust=-0.5, colour="orange", size=rel(1.5))) + # Color y forma eje de las x
  theme(axis.title.y = element_text(face="bold", vjust=1.5, colour="blue", size=rel(1.5)))      # Color y forma eje de las y


# Gráfica con titulo y etiqueta de ejes de colores + linea de colores + puntos rojos en cada vértice
(graf1 <- ggplot(data = c, aes(x = a, y = b, group=1)) + 
    geom_line(colour = "#7fc0f9", size = 2) + 
    ggtitle("Datos Aleatorios en funcion de un grupo \n alfabético") +
    theme(plot.title = element_text(
      family="sans",
      size=rel(1), #Tamaño relativo de la letra del título
      vjust=2, #Justificación vertical, para separarlo del gráfico
      hjust = 0.5,
      face="bold", #Letra negrilla. Otras posibilidades "plain", "italic", "bold" y "bold.italic"
      color="red", #Color del texto
      lineheight=1)) + #Separación entre líneas
    labs(x = "Clases de la información",y = "Valores") + # Etiquetas o títulos de los ejes
    theme(axis.title.x = element_text(face="bold", vjust=-0.5, colour="orange", size=rel(1.5))) + # Color y forma eje de las x
    theme(axis.title.y = element_text(face="bold", vjust=1.5, colour="blue", size=rel(1.5))) +     # Color y forma eje de las y
    geom_point(fun.y = sum, stat = "summary", colour = "red", size = 3) )


# Gráfica con titulo y etiqueta de ejes de colores + linea de colores + puntos rojos en cada vértice + theme_solarized()
(graf1 <- ggplot(data = c, aes(x = a, y = b, group=1)) + theme_solarized() +
    geom_line(colour = "#7fc0f9", size = 2) + 
    ggtitle("Datos Aleatorios en funcion de un grupo \n alfabético") +
    theme(plot.title = element_text(
      family="sans",
      size=rel(1), #Tamaño relativo de la letra del título
      vjust=2, #Justificación vertical, para separarlo del gráfico
      hjust = 0.5,
      face="bold", #Letra negrilla. Otras posibilidades "plain", "italic", "bold" y "bold.italic"
      color="red", #Color del texto
      lineheight=1)) + #Separación entre líneas
    labs(x = "Clases de la información",y = "Valores") + # Etiquetas o títulos de los ejes
    theme(axis.title.x = element_text(face="bold", vjust=-0.5, colour="orange", size=rel(1.5))) + # Color y forma eje de las x
    theme(axis.title.y = element_text(face="bold", vjust=1.5, colour="blue", size=rel(1.5))) +     # Color y forma eje de las y
    geom_point(fun.y = sum, stat = "summary", colour = "red", size = 3) )


ggplotly(graf1)