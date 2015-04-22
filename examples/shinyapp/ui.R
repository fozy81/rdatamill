library(shiny)
library(rdatamill)

# Create function with renderUI and save to R directory. The file name for the
# survey must start with 'test..' e.g. testCustomerSurvey.R There are  a few
# examples in the R directory. Currently limited to single paper surveys
# automatically search for all available tests

# fetch the functions from package which include 'test' prefix:
getFunctionNames <- ls("package:rdatamill")
getTestFunctions <- grep(pattern ='^test',getFunctionNames, value=T)
getPrettyNames <-  sub("test", "", getTestFunctions)
getChoices = setNames(getTestFunctions,getPrettyNames)



# Select analysis and display 'test...' functions:
shinyUI(navbarPage(
  title = 'dataFactory',(
   tabPanel('Data entry',

               fluidRow(column(3,


       selectInput("Analysis","Select Analysis",getChoices)

      ),
      fluidRow(column(6,
        uiOutput('analysisUI'),
        h5(textOutput("counter"))
        )
        )
   )
    )),tabPanel('Validation'),tabPanel('Visualisation')))

