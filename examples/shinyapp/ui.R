library(shiny)
library(shinyjs)
library(rdatamill)

#
# Code not used currently:
#Create function with renderUI and save to R directory. The file name for the
# survey must start with 'test..' e.g. testCustomerSurvey.R There are  a few
# examples in the R directory. Currently limited to single paper surveys
# automatically search for all available tests

# fetch the functions from package which include 'test' prefix:
 getFunctionNames <- ls("package:rdatamill")
 getTestFunctions <- grep(pattern ='^test',getFunctionNames, value=T)
 getTestFunctions <<- getTestFunctions[getTestFunctions != 'testDataFrame']

###################################################

 appCSS <-".mandatory_star { color: red; }"
shinyUI(navbarPage(
    title = 'R DataMill',(tabPanel('Create/Edit Test',

                                  shinyjs::useShinyjs(),
                                  # Select update or create new test
                                  fluidRow(column(3,
                                                  p(),
                                                  actionButton("create_new_test","Create New Test"),
                                                  h5('Or...'),
                                                  uiOutput('test_choices_1'),
                                                  actionButton("edit_test","Edit Test")



                                  ),
                                  fluidRow(column(6,
                                                  uiOutput('test_create'),
                                                  uiOutput('test_update')
                                  ))
                                  )
                                  )),
                                   (
   tabPanel('Data entry',shinyjs::useShinyjs(),
            # Select analysis and display 'test...' functions:
               fluidRow(column(3,


                               uiOutput('test_choices_2'),
                               actionButton("log_sample","Log Sample")

      ),
      fluidRow(column(6,
                      shinyjs::inlineCSS(appCSS),

        uiOutput('data_entry'),
        uiOutput('data_entry2'),
        shinyjs::hidden(
          div(
            id = "thankyou_msg",
            h3("Thanks, your response was submitted successfully!"),
            actionLink("submit_another", "Submit another response"),p(),
            actionLink("submit_finish", "Data entry complete - finish sample")
          )),
        shinyjs::hidden(
          div(
            id = "mandatory",
            h3("Complete mandatory fields")
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

         uiOutput('test_choices_3')),    fluidRow(column(6,
                                                          uiOutput('upload_data')

                                                          ))

                )),
   tabPanel('Validation',shinyjs::useShinyjs(),
                                fluidRow(column(3,

                                                uiOutput('test_choices_4')),
                fluidRow(column(6,

                                dataTableOutput('result_table'),  actionButton("validate","Validate"),  dataTableOutput('validate_table')

                )))),tabPanel('Analysis'),tabPanel('Data Summary')))

