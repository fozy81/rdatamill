library(shiny)
library(shinyjs)
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


getTestForms <- read.csv(file="testForm.csv")
getTestForms$Test <- as.character(getTestForms$Test)
getChoices2 <- unique(getTestForms$Test)

# Select analysis and display 'test...' functions:
shinyUI(navbarPage(
    title = 'R DataMill',(tabPanel('Create/Edit Test',

                                  shinyjs::useShinyjs(),

                                  fluidRow(column(3,


                                                  selectInput("select_Test","Select test to update",getChoices2),
                                                  actionButton("edit_Test","Edit Test"),
                                                  hr(),
                                                  h3('Or...'),
                                                  actionButton("create_new_Test","Create New Test")

                                  ),
                                  fluidRow(column(6
                                                  , uiOutput('testCreateUI')


#                                                   shinyjs::hidden(
#                                                     div(
#                                                       id = "thankyou_msg",
#                                                       h3("Thanks, your response was submitted successfully!"),
#                                                       actionLink("submit_another", "Submit another response")
#                                                     )),
#                                                   shinyjs::hidden(
#                                                     div(
#                                                       id = "another_test_msg",
#                                                       h3("Thanks, your test was submitted successfully!"),
#                                                       actionLink("submit_another_Test_update", "Submit another test update")
#                                                     )),
#                                                   h5(textOutput("counter"))
                                  )
                                  )
                                  )

                                  )),
                                   (
   tabPanel('Data entry',shinyjs::useShinyjs(),

               fluidRow(column(3,


       selectInput("Analysis","Select Analysis",getChoices)

      ),
      fluidRow(column(6,


        uiOutput('analysisUI'),
        shinyjs::hidden(
          div(
            id = "thankyou_msg",
            h3("Thanks, your response was submitted successfully!"),
            actionLink("submit_another", "Submit another response")
          )),
        shinyjs::hidden(
          div(
            id = "another_test_msg",
            h3("Thanks, your test was submitted successfully!"),
            actionLink("submit_another_Test", "Submit another test")
          )),
        h5(textOutput("counter"))
        )
        )
   )
    )),tabPanel('Data upload'),
   tabPanel('Validation',shinyjs::useShinyjs(),
                                fluidRow(column(3,


                                selectInput("Test","Select Analysis",getTestFunctions)

                ),
                fluidRow(column(6,

                                dataTableOutput('table'),  actionButton("validate","Validate")

                )))),tabPanel('Analysis'),tabPanel('Data Summary')))

