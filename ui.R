library(shiny)

shinyUI(fluidPage(
  
    title = "Valresultatet EU-parlamentet 2009",
    
   
    
    hr(),
    
    fluidRow(
      
      column(1,
            
       selectInput("var", label = h5("Välj Parti"), 
                  choices = c("S", "MP" , "V","M", "FP", "C", "KD", "FI", "SD", "PP","JL"
                                  ),
                  selected = "S")
              ),
      
      column (4,
              plotOutput("map",  height="600px")
              ),

      
      column(2,
             sliderInput("bin", label = h5("Välj intervall för histogram"),
                         min = 0.1, max = 1, value = 0.5 ,step=0.1)
             ),
      
      column (4,
              plotOutput("hist", height="600px"))
              )

  ))

