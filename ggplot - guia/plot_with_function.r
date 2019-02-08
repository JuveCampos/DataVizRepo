# Grafica
library(ggplot2)
library(tidyverse)
library(ggthemes)
library(plotly)

x <- c(1:10)
y <- c(35901, 6028, 23971, 41737, 32985, 9621, 6208, 9733, 33439, 79323) 
data <- cbind(x,y) %>% as.data.frame()
f <- function(x) 1599.7*x^2 - 15284*x + 50371

p <- ggplot(data, aes(x = x, y = y)) + geom_bar(stat = "identity") 
p

p + stat_function(fun = f)


mpios$tema <- "inundacion"




