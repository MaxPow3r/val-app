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



