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
 getTestFunctions <<- getTestFunctions[getTestFunctions != 'testDataFrame']

# getPrettyNames <-  sub("test", "", getTestFunctions)
# getChoices <<- setNames(getTestFunctions,getPrettyNames)

# fetch functions names saved in test table for updating:
# if(file.exists("testForm.csv")){
# getTestForms <- read.csv(file="testForm.csv")
# getTestForms$Test <- as.character(getTestForms$Test)
# getChoices2 <- unique(getTestForms$Test)
# getChoices2 <<- setNames(getChoices2,getChoices2)
# getTestFunctions <<- getChoices2
# getChoices3 <<- getChoices2
# }
# if(!file.exists("testForm.csv")){
# getChoices2 <<- setNames("","")
# getTestFunctions <<- getChoices2
# # combine all tests (in table and write into functions) so all tests can be selected:
# getChoices3 <<- getChoices2
# }
shinyUI(navbarPage(
    title = 'R DataMill',(tabPanel('Create/Edit Test',

                                  shinyjs::useShinyjs(),
                                  # Select update or create new test
                                  fluidRow(column(3,


                                                  uiOutput('test_list_one'),
                                                  actionButton("edit_Test","Edit Test"),
                                                  hr(),
                                                  h4('Or...'),
                                                  actionButton("create_new_Test","Create New Test")

                                  ),
                                  fluidRow(column(6
                                                  , uiOutput('testCreateUI'),
                                                  uiOutput('test_updateUI')



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
            # Select analysis and display 'test...' functions:
               fluidRow(column(3,


                               uiOutput('test_list_two'),
                               actionButton("add_Test","Add Test")

      ),
      fluidRow(column(6,


        uiOutput('analysisUI'),
        shinyjs::hidden(
          div(
            id = "thankyou_msg",
            h3("Thanks, your response was submitted successfully!"),
            actionLink("submit_another", "Submit another response"),p(),
            actionLink("submit_finish", "Data entry complete - finish sample")
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
    )),
tabPanel('Data upload',  fluidRow(column(3,

         uiOutput('test_list_three')),    fluidRow(column(6,
                                                          uiOutput('uploadDataUI')

                                                          ))

                )),
   tabPanel('Validation',shinyjs::useShinyjs(),
                                fluidRow(column(3,

                                                uiOutput('test_list_four')),
                fluidRow(column(6,

                                dataTableOutput('result_table'),  actionButton("validate","Validate"),  dataTableOutput('validate_table')

                )))),tabPanel('Analysis'),tabPanel('Data Summary')))

