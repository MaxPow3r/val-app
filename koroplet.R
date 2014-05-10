#make choropletemap over election results for election to EU parliment in sweden
# 2009

library(ggplot2)
library(plyr)
library(rgeos)
library(maptools)

setwd("/home/maxpow3r/Documents/R/Shiny")

#läser in shpfilen
library(rgdal)
kommuner <- readOGR( dsn="/home/maxpow3r/Documents/R/Shiny/val-app/data/alla_kommuner", "alla_kommuner")

#read election, remove rows which correspond to election district and
# transform 'KOD' to always be 4 digits and start with zero if its not originally.

library(gdata)
resultat <- read.xls("val-app/data/valresultat_slutligt_2009.xls")
resultat<- resultat[which(resultat$KOD < 9999),]
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

kommuner.f$S_DIFF <- kommuner.f$S_PROCENT - 24.41
kommuner.f$M_DIFF <- kommuner.f$M_PROCENT - 18.83
kommuner.f$V_DIFF <- kommuner.f$V_PROCENT - 5.66
kommuner.f$MP_DIFF <- kommuner.f$MP_PROCENT - 11.02
kommuner.f$FP_DIFF <- kommuner.f$FP_PROCENT - 13.58
kommuner.f$C_DIFF <- kommuner.f$C_PROCENT - 5.47
kommuner.f$KD_DIFF <- kommuner.f$KD_PROCENT - 4.68
kommuner.f$JL_DIFF <- kommuner.f$JL_PROCENT - 3.55
kommuner.f$SD_DIFF <- kommuner.f$SD_PROCENT - 3.27
kommuner.f$PP_DIFF <- kommuner.f$PP_PROCENT - 7.13
kommuner.f$FI_DIFF <- kommuner.f$FI_PROCENT - 2.22


saveRDS(kommuner.f, "kommunder_val.rds")

map <- ggplot(kommuner.f ,aes(long, lat, group = group, fill = MP_DIFF)) +
  geom_polygon() +
  coord_equal()+
  ggtitle("title") +
  scale_fill_gradient2(low = "turquoise3", high= "orangered") +
  labs( fill = "legend.title") +
  theme(
    panel.background = element_blank(),
    axis.ticks = element_blank(),
    axis.text = element_blank(),
    axis.title = element_blank() )

map

kommuner@data$S_PROCENT <- as.numeric( sub(",", ".", kommuner@data$S_PROCENT) )
kommuner@data$M_PROCENT <- as.numeric( sub(",", ".", kommuner@data$M_PROCENT) )
kommuner@data$V_PROCENT <- as.numeric( sub(",", ".", kommuner@data$V_PROCENT) )
kommuner@data$FI_PROCENT <- as.numeric( sub(",", ".", kommuner@data$FI_PROCENT) )
kommuner@data$SD_PROCENT <- as.numeric( sub(",", ".", kommuner@data$SD_PROCENT) )
kommuner@data$MP_PROCENT <- as.numeric( sub(",", ".", kommuner@data$MP_PROCENT) )
kommuner@data$JL_PROCENT <- as.numeric( sub(",", ".", kommuner@data$JL_PROCENT) )
kommuner@data$KD_PROCENT <- as.numeric( sub(",", ".", kommuner@data$KD_PROCENT) )
kommuner@data$C_PROCENT <- as.numeric( sub(",", ".", kommuner@data$C_PROCENT) )
kommuner@data$PP_PROCENT <- as.numeric( sub(",", ".", kommuner@data$PP_PROCENT) )


hist <- ggplot(kommuner_t, aes(x=FI_PROCENT))+
        geom_histogram(binwidth=0.5 , fill="hotpink")+
        theme(panel.background = element_blank())

hist

colors()


saveRDS(kommuner@data, "kommuner.rds")

kommuner_t <- readRDS("kommuner.rds")






