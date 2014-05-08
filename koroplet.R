#make choropletemap over election results for election to EU parliment in sweden
# 2009

library(ggplot2)
library(plyr)
library(rgeos)
library(maptools)

setwd("/home/maxpow3r/Documents/R/Shiny")

#läser in shpfilen
library(rgdal)
kommuner <- readOGR( dsn="/home/maxpow3r/Documents/R/Shiny/val-app/alla_kommuner", layer="alla_kommuner")

#read election, remove rows which correspond to election district and
# transform 'KOD' to always be 4 digits and start with zero if its not originally.

library(gdata)
resultat <- read.xls("valresultat_slutligt_2009.xls")
resultat<- reslutat[which(reslutat$KOD < 9999),]
resultat$KOD <-formatC(resultat$KOD, width = 4, format = "d", flag = "0")

#Kollar vilka som finns i både dataset och shapefil, alla +22 till 
summary(resultat$KOD %in% kommuner$ID)

# Change name of resultat$KOD for joining

resultat <- rename(resultat, replace = c(KOD = "ID"))

# preform join on ID

kommuner@data <- join(kommuner@data, resultat)

plot(kommuner)

# To get the shapefiles into a format that can be plotted 
# we have to use the fortify() function. 

kommuner.f <- fortify(kommuner, region = "ID")

# When fortifying the attributedata is lost, have to merge it on.

kommuner.f <- merge(kommuner.f, kommuner@data, by.x = "id", by.y = "ID")


kommuner.f <- readRDS("val-app/data/kommunder_val.rds")


Map <- ggplot(kommuner.f, aes(long, lat, group = group, fill = VDT_PROCENT)) +
  geom_polygon() +
  coord_equal()+
  ggtitle("Valresultat EU-parlamentvalet 2009, Vänsterpartiet") +
  scale_fill_gradient(low = "white", high = "#000082") +
  labs( fill = "% Sport Partic.")+
  theme(
        panel.background = element_blank(),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank()
  )
      
Map


saveRDS(kommuner.f, "kommunder_val.rds")
