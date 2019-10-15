library(highcharter)
library(tidyverse)
library(RColorBrewer)

# Base de datos
df <- data.frame(name = c("john", "jane", "herbert", "peter"),
                 bananas = c(10, 14, 6, 3))

# Treemap
hctreemap2(df, 
           group_vars = "name",
           size_var = "bananas") %>% 
  hc_colorAxis(minColor = brewer.pal(7, "YlOrRd")[7],
               maxColor = brewer.pal(7, "Greens")[7])



df <- data.frame(
  "group" = letters[1:24],
  "color" = rep(letters[1:6], each = 4),
  "size" = rpois(24, 100)
)
df$color_numeric <- as.numeric(as.factor(df$color))
color_pal <- RColorBrewer::brewer.pal(max(length(unique(df$color_numeric)), 3), "Paired")

hctreemap2(df, group_vars = "group", size_var = "size", color_var = "color_numeric") %>%
  hc_legend(enabled = FALSE) %>%
  hc_colorAxis(
    dataClassColor = "category",
    dataClasses = color_classes(df$color_numeric, colors = color_pal)
  )
