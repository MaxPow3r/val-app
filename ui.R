library(shiny)

shinyUI(fluidPage(
    titlePanel("Valresultatet EU-parlamentet 2009"),
    
    sidebarLayout(
      sidebarPanel(
       helpText("Skapa koropletkarta över valresultatet i EU-valet 2009"),
       br(),
       selectInput("var", label = h5("Vilket parti du vill studera?"), 
                  choices = c("S", "MP" , "V","M", "FP", "C", "KD", "FI", "SD", "PP","JL"
                                  ),
                  selected = "S"),
       br(),
       sliderInput("range", label = h5("Range of interest"),
                   min = 0, max = 100, value = c(0,100))
        ),
      mainPanel(
        plotOutput("korv"))
  
)))

