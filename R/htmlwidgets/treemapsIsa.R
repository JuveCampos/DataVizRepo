# treemaps Isabel

library(highcharter)
library(tidyverse)
library(RColorBrewer)

niveles <- function(x) levels(as.factor(x))

# Base de datos
df <- readxl::read_xlsx("Producción_primaria_total.xlsx")
df_zac <- df %>% filter(Entidad == "Zacatecas") %>% 
  mutate(color = case_when(sector == "Agricola" ~ 1, 
                           sector == "Pecuario" ~ 2, 
                           sector == "Pesquero" ~ 3)) %>% 
  mutate(info = paste0(Cultivo, "<br>", scales::dollar(valor_prod), ".00", "<br>",  Porcentaje, "% del volumen"))

niveles(df_zac$Cultivo)  
niveles(df_zac$sector)
names(df_zac)
df_zac$info

# hctreemap2(df, group_vars = "group", 
#            size_var = "size", 
#            color_var = "color_numeric") %>%
#   hc_legend(enabled = FALSE) %>%
#   hc_colorAxis(
#     dataClassColor = "category",
#     dataClasses = color_classes(df$color_numeric, colors = color_pal)
#   )

# Treemap
hctreemap2(df_zac, 
           group_vars = "info",
           size_var = "valor_prod", 
           color_var = "color") %>% 
  hc_legend(enabled = FALSE) %>%
  hc_colorAxis(
    dataClassColor = "color",
    dataClasses = color_classes(df_zac$color, 
                                colors = c("#003ef7","#00f721","#e36928"))) %>% 
  hc_add_theme(thm)


thm <- hc_theme(
  colors = c('red', 'green', 'blue'),
  chart = list(
    backgroundColor = "#FFFFFF"
  ),
  title = list(
    style = list(
      color = '#333333',
      fontFamily = "Erica One"
    )
  ),
  subtitle = list(
    style = list(
      color = '#666666',
      fontFamily = "Shadows Into Light"
    )
  ),
  legend = list(
    itemStyle = list(
      fontFamily = 'Tangerine',
      color = 'black'
    )
  )
)

