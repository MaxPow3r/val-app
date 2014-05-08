library(shiny)

shinyUI(fluidPage(
  
    title = "Valresultatet EU-parlamentet 2009",
    
   
    
    hr(),
    
    fluidRow(
      column(3,
             h4("Välj parti"),
            
       selectInput("var", label = h5("Vilket parti du vill studera?"), 
                  choices = c("S", "MP" , "V","M", "FP", "C", "KD", "FI", "SD", "PP","JL"
                                  ),
                  selected = "S")
     
        ),
      plotOutput("map")
)))

