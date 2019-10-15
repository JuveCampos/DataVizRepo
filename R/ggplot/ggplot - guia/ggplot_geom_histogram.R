# Histograma
library(readr)
library(dplyr)
library(ggplot2)

# CARGAMOS LA BASE DE DATOS
chol <- as_tibble(read.table(url("http://assets.datacamp.com/blog_assets/chol.txt"), header = TRUE))
head(chol)

#############
# D A T O S #
#############
# Los datos que se van a utilizar serán del tipo <int> (numeric). Se analizará la frecuencia.


######################
# qplot (Quick Plot) #
#####################
qplot(chol$AGE)

######################################
# ggplot basico (ignoramos los bins) #
######################################

# No nos metemos con los bins 
ggplot(data=chol, aes(chol$AGE)) + geom_histogram()

  # aes(le metemos datos numéricos), una vez que ya sabe que va a ser un objeto ggplot
  # le decimos que va a ser un histograma. 

#########################################
# ggplot basico (considerando los bins) #
#########################################

# Nos metemos con los bins. Los bins son "cajones" o "botes" en los cuales "metemos" los datos. 
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(breaks=seq(20, 50, by=2))
# Se pasan los breaks mediante la función `seq`
# Primer parámetro: inicio de la grafica
# Segundo parámetro: final de la gráfica
# Tercer parámetro (by = ), cortes. Cada gráfica almacena la 
#     frecuencia de observaciones en saltos de 2 en magnitud.

#########################################################################
# ggplot basico (considerando los bins) + colores de relleno y contorno #
#########################################################################
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(breaks=seq(20, 50, by =2), 
                 col="red", 
                 fill="green")

#########################################################################################
# ggplot basico (considerando los bins) + colores de relleno y contorno + transparencia #
#########################################################################################
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(breaks=seq(20, 50, by =2), 
                 col="red", 
                 fill="green", 
                 alpha = .2)

#########################################################################################
# ggplot basico (considerando los bins) + colores de contorno + transparencia           #
# + colores variables en las barras(Color default azul)                                 #
#########################################################################################
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(breaks=seq(20, 50, by =2), 
                 col="red", 
                 aes(fill=..count..))

#########################################################################################
# ggplot basico (considerando los bins) + colores de contorno + transparencia           #
# + colores variables en las barras(colorfill gradient)                                 #
#########################################################################################

# En el anterior teniamos el color defalt azul. Ahora haremos una coloración en función de 
# la magnitud y, donde el gradiente será de verde (menos) a rojo (mas)
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(breaks=seq(20, 50, by =2), 
                 col="red", 
                 aes(fill=..count..)) +
  scale_fill_gradient("Count", low = "green", high = "red")

#########################################################################################
# ggplot basico (considerando los bins) + colores de contorno + transparencia           #
# + etiquetas de titulo                                                                 #
#########################################################################################
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(breaks=seq(20, 50, by = 2), 
                 col="red", 
                 fill="green", 
                 alpha = .2) + 
  labs(title="Histogram for Age") +
  labs(x="Age", y="Count")

#########################################################################################
# ggplot basico (considerando los bins) + colores de contorno + transparencia           #
# + etiquetas de titulo + modificación de las escalas x-y                               #
#########################################################################################
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(breaks=seq(20, 50, by = 2), 
                 col="red", 
                 fill="green", 
                 alpha = .2) + 
  labs(title="Histogram for Age") +
  labs(x="Age", y="Count") + 
  xlim(c(18,52)) +
  ylim(c(0,30))

#########################################################################################
# ggplot basico (considerando los bins) + colores de contorno + transparencia           #
# + etiquetas de titulo + modificación de las escalas x-y                               #
#########################################################################################
ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(aes(y =..density..), 
                 breaks=seq(20, 50, by = 2), 
                 col="red", 
                 fill="green", 
                 alpha = .2) + 
  geom_density(col=2) +                # Se añade la linea de tendencia 
  labs(title="Histogram for Age") +
  labs(x="Age", y="Count")

# Aqui esta la linea de tendencia por separado, la cual igual es un objeto ggplot
# al cual se le dice que va a ser una linea de densidad.
ggplot(data=chol, aes(chol$AGE)) +
  geom_density(col=2)

############
# ggplotly #
###########

# 1. Creamos el objeto ggplot
a <- ggplot(data=chol, aes(chol$AGE)) + 
  geom_histogram(aes(y =..density..), 
                 breaks=seq(20, 50, by = 2), 
                 col="red", 
                 fill="green", 
                 alpha = .2) + 
  geom_density(col=2) +                # Se añade la linea de tendencia 
  labs(title="Histogram for Age") +
  labs(x="Age", y="Count")

# Checamos la clase del objeto.
class(a)

# 2. Transformamos el objeto ggplot a objeto plotly. 
# -Se necesita el paquete plotly para llevar a cabo esta función-
plotly::ggplotly(a)


####################
# Datos characters #
####################
datos2 <- as_tibble( c(rep("a", 10), rep("b", 20), rep("c", 25), rep("d", 33), rep("e", 23)))
datos2

#############################################
# ggplot + colores bordo y relleno + titulo #
#############################################

ggplot(data = datos2, aes(datos2$value)) + 
  geom_histogram(stat="count", col = "green", 
                 fill = "white") + ggtitle("Conteo de Letras") 


##########################################
# ggplot + multiples categorias a contar #
##########################################

# 1.- Diamonds.- Esta BD tiene informacion de caracteristicas de diamantes 

ggplot(diamonds, aes(price, fill = cut)) +
  geom_histogram(binwidth = 500)

# 2.- el introducir dos parametros en aes() nos dice que hay que considerar dos 
# cosas a la hora de colorear las barras. El tamaño de la barra lo da la frecuencia de ocurrencia, 
# el tamaño de cada color de la barra lo da la frecuencia de dicha caracteristica. 

