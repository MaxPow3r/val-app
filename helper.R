library(ggplot2)


procent_karta <- function(data, var, color, legend.title, title) {
   
  .e<- environment()
  
          ggplot(data ,aes(long, lat, group = group, fill = var), environment=.e) +
                  geom_polygon() +
                  coord_equal()+
                  ggtitle(title) +
                  scale_fill_gradient(low = "white", high = color) +
                  labs( fill = legend.title)+
                  theme(
                    panel.background = element_blank(),
                    axis.ticks = element_blank(),
                    axis.text = element_blank(),
                    axis.title = element_blank())
}

procent_karta2 <- function(data, var,  legend.title, title) {
  
  .e<- environment()
  
           ggplot(data ,aes(long, lat, group = group, fill =var), environment=.e) +
                  geom_polygon() +
                  coord_equal()+
                  ggtitle(title) +
                  scale_fill_gradient2(low = "turquoise3", high= "orangered") +
                  labs( fill = legend.title) +
                  theme(
                    panel.background = element_blank(),
                    axis.ticks = element_blank(),
                    axis.text = element_blank(),
                    axis.title = element_blank() )
}


procent_histogram <- function(data, var, color, bin) {
  
  .e<- environment()
  
  ggplot(data, aes(x=var), environment=.e)+
    geom_histogram(binwidth=bin , fill=color)+
    theme(panel.background = element_blank())    
          
}




