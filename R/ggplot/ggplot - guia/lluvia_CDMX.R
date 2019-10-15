# Librerias
library(readxl)
library(tidyverse)
library(reshape)
library(wesanderson)

datos <- read_xlsx("muestra1.xlsx") %>% 
  as.data.frame() %>% 
  mutate(Lugar = as.factor(Lugar)) %>% 
  reshape::melt(id = c("Lugar")) %>% 
  arrange(Lugar)

# Inspeccionamos la variable 
class(datos$variable)
levels(datos$variable)

# Tema juve
tema_juve <- theme_bw() + theme(text = element_text(family = "Asap-Bold", color = "#25636e"), 
                                panel.grid.major = element_blank(),
                                panel.grid.minor = element_blank(), 
                                plot.caption=element_text(hjust=1,size=9,colour="grey30"),
                                plot.subtitle=element_text(face="italic",size=12,colour="grey40"),
                                plot.title=element_text(size=18,face="bold"),
                                axis.text.x = element_text(family = "Asap-Bold", color = "#25636e"),
                                axis.text.y = element_text(family = "Asap-Bold", color = "#25636e"))

# ggplot
ggplot(data = datos, aes(x = variable, y = value, fill = Lugar)) + 
  geom_bar(position = position_dodge(), stat = "identity", colour = "black") + 
  labs(x = "", 
       y = "Precipitación (mm)") + 
  scale_y_continuous(breaks = c(0,50,100,150,200,250, 300), 
                     labels = scales::dollar_format(prefix = "", suffix = " mm"), 
                     expand = c(0.02,0)) + 
  tema_juve +
  theme(legend.position="bottom", 
        legend.title=element_blank(), 
        legend.box.spacing = unit(-0.5, 'cm'), 
        legend.key = element_rect(color = NA, fill = NA), 
        legend.key.size = unit(0.5, "cm"),
        legend.spacing.x = unit(0.2, 'cm')
        #legend.title.align = 1
        ) + 
  scale_fill_manual(values = c(wes_palettes$Cavalcanti1, wes_palettes$Darjeeling1[1:2]) , aesthetics = "fill")
