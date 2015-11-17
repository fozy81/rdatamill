library(shiny)
library(shinyjs)
library(rdatamill)
library(formattable)
library(rpivotTable)


# colour mandatory fields marked with * as red
appCSS <-".mandatory_star { color: red; }"

shinyUI(navbarPage(
    title = 'R DataMill',(tabPanel('Create/Edit Form',
                                  shinyjs::useShinyjs(),
                                  # Select update or create new test
                                  fluidRow(column(3,
                                                  p(),
                                                  actionButton("create_new_test","Create New Form"),
                                                  h5('Or...'),
                                                  uiOutput('tests_to_edit'),
                                                  actionButton("edit_test","Edit Form")
                                  ),
                                  fluidRow(column(6,
                                                  uiOutput('test_create'),
                                                shinyjs::hidden(
                                                    div(id = "save_new",
                                                      actionButton("save_new_test", "Save Form"))),
                                                  shinyjs::hidden(
                                                    div(id = "another_test_msg",
                                                      h3("Thanks, your test were submitted successfully!"),
                                                      actionLink("submit_another_test", "Submit another Form"))),
                                                  shinyjs::hidden(
                                                    div(id = "update_test_button",
                                                        actionButton("update_test_button", "Save Update"))),
                                                  shinyjs::hidden(
                                                    div(id = "updated_test_msg",
                                                        h3("Thanks, your Form was updated successfully!")))
                                  ))
                                  )
                                  )),
                                   (
   tabPanel('Log Sample/Result entry',shinyjs::useShinyjs(),
            # Select analysis and display 'test...' functions:
               fluidRow(column(3,
                               uiOutput('tests_to_log'),
                               actionButton("log_sample","Log Sample"),
                               hr(),
                               hr(),
                               hr(),
                               uiOutput('sample_choice'),
                               uiOutput('test_choice'),
                               actionButton("open_sample","Open Sample")
      ),
      fluidRow(column(6,
                      shinyjs::inlineCSS(appCSS),

        uiOutput('test_details_table'),
         uiOutput('sample_open'),
         shinyjs::hidden(actionButton("save_click","Save Results")),
        shinyjs::hidden(
          div(
            id = "thank_you_continue",
            h3("Thanks, your response was submitted successfully!"),
            actionButton("submit_another", "Submit another response")
                )),
        shinyjs::hidden(
          div(
          id = "finish",
          p(),
          actionButton("finish", "Finish")
        )),
        shinyjs::hidden(
          div(
            id = "mandatory",
            h3("Complete mandatory fields *")
          )),
        shinyjs::hidden(
          div(
            id = "thank_you_end",
            h3("Thanks, your response was submitted successfully!")
          )),
        h5(textOutput("counter"))
        )
        )
   )
    )),
tabPanel('Import Results',  fluidRow(column(3,

         uiOutput('tests_to_upload')),    fluidRow(column(6,
                                                          uiOutput('upload_data')

                                                          ))

                )),
   tabPanel('Validation',shinyjs::useShinyjs(),
                                fluidRow(column(3,

                                                uiOutput('tests_to_validate')),
                fluidRow(column(6,

                               h4('Results table'), dataTableOutput('result_table'),  actionButton("validate","Validate"),
                               h4('Results format validation'), formattableOutput('validate_table',width = "100%", height = "300"),  h4('Results data validation'),
                               dataTableOutput('validate_data_table')

                )))),tabPanel('Analysis',
                              fluidRow(column(3

                                            ),
                                       fluidRow(column(6,

                                                       h4('Results valid table'), rpivotTableOutput('valid_results_table'))))



                              ),tabPanel('Data Summary')))

