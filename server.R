library(shiny)
library (maps)
library(ggplot2)

# Load data 
kom <- readRDS("data/kommunder_val.rds")
kom2 <- readRDS("data/kommuner.rds")
# add source script
source("helper.R")

shinyServer(function(input, output) {
 
  output$map <- renderPlot({
    
    # when "X" is choosen, decide which data to use.
    data <- switch (input$var,
                    "S" =  kom$S_PROCENT,
                    "M" = kom$M_PROCENT,
                    "V" = kom$V_PROCENT,
                    "MP"= kom$MP_PROCENT,
                    "FP"= kom$FP_PROCENT,
                    "C" = kom$C_PROCENT,
                    "PP"= kom$PP_PROCENT,
                    "FI"= kom$FI_PROCENT,
                    "JL"= kom$JL_PROCENT,
                    "KD"= kom$KD_PROCENT,
                    "SD"= kom$SD_PROCENT,)
    
    # when "X" is choosen, decide which color to use for max in legend.
    #(white is set to min)
    farg <- switch (input$var,
                    "S" = "red",
                    "M" = "darkblue",
                    "V" = "#BA0214",
                    "MP"= "#61AB00",
                    "FP"= "#01024D",
                    "C" = "#014D0C",
                    "PP"= "black",
                    "FI"= "hotpink",
                    "JL"= "#EDC202",
                    "SD"= "#3D2602",
                    "KD"= "purple",)
    
    # Set legend title
    legend <- switch (input$var,
                    "S" = "% S",
                    "M" = "% M",
                    "V" = "% V",
                    "MP"= "% MP",
                    "FP"= "% FP",
                    "C" = "% C",
                    "PP"= "%PP",
                    "FI"= "%FI",
                    "JL"= "%JL",
                    "SD"= "%SD",
                    "KD"= "%KD",)
    title <- switch (input$var,
                      "S" = "Socialdemokraterna",
                      "M" = "Moderaterna",
                      "V" = "Vänsterpartiet",
                      "MP"= "Miljöpartiet",
                      "FP"= "Folkpartiet",
                      "C" = "Centerpartiet",
                      "PP"= "Piratpartiet",
                      "FI"= "Feministiskt Initiativ",
                      "JL"= "Junilistan",
                      "SD"= "Sverigedemokraterna",
                      "KD"= "Kristdemokraterna",)
    
    
    #Create map with function created in helper.R 
    Map <- procent_karta(data = kom, var = data, color = farg, legend.title = legend, title=title)
   plot(Map) 
   
  })
  output$hist <- renderPlot({
    
    # when "X" is choosen, decide which data to use.
    data2 <- switch (input$var,
                     "S" =  kom2$S_PROCENT,
                     "M" = kom2$M_PROCENT,
                     "V" = kom2$V_PROCENT,
                     "MP"= kom2$MP_PROCENT,
                     "FP"= kom2$FP_PROCENT,
                     "C" = kom2$C_PROCENT,
                     "PP"= kom2$PP_PROCENT,
                     "FI"= kom2$FI_PROCENT,
                     "JL"= kom2$JL_PROCENT,
                     "KD"= kom2$KD_PROCENT,
                     "SD"= kom2$SD_PROCENT,)
    
    farg   <- switch (input$var,
                      "S" = "red",
                      "M" = "darkblue",
                      "V" = "#BA0214",
                      "MP"= "#61AB00",
                      "FP"= "#01024D",
                      "C" = "#014D0C",
                      "PP"= "black",
                      "FI"= "hotpink",
                      "JL"= "#EDC202",
                      "SD"= "#3D2602",
                      "KD"= "purple",)
    
    
   
    
    
    #Create map with function created in helper.R 
    hist <- procent_histogram(data = kom2, var = data2, color=farg, bin=0.5)
    plot(hist) 
    
  })
})
