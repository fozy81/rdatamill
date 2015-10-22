library(shiny)
library(rdatamill)
library(shinyjs)

shinyServer(function(input, output, session) {

  # create UI selectInput to pick from list of available tests and
  # updates when new test created if no test available leave blank:

  output$test_choices_1 <- test_selector(input_name='selected_test_1',message='Select existing test to edit')
  output$test_choices_2  <- test_selector(input_name='selected_test_2',message='Select tests to add to sample:',multiple=T)
  output$test_choices_3  <- test_selector(input_name='selected_test_3',message='Select test to upload data')
  output$test_choices_4  <- test_selector(input_name='selected_test_4',message='Select test data to validate')

  # output the 'create a new test' panel in the UI if 'edit test' button selected
  observeEvent(input$edit_test, {
    output$test_create  <- renderUI({
      return(list(update_test(), update_button()))
    })
  })


  # output the 'update test' panel in the UI if 'update test' button selected
  observeEvent(input$create_new_test, {
    output$test_create  <- renderUI({
      return(list(create_test(),update_button()))
      })
  })

  # reactive global test list so if test added this will be added to drop  down list:
  test_df <<- reactive({
    get_test()
  })


  # if new test saved or existing test updated/edited then save new verison of test to file and create validation function
  observeEvent(input$update_click, {
    save_test()
    output$test_choices_1 <- test_selector(input_name='selected_test_1',message='Select existing test to edit')
    output$test_choices_2  <- test_selector(input_name='selected_test_2',message='Select tests to add to sample:',multiple=T)
    output$test_choices_3  <- test_selector(input_name='selected_test_3',message='Select test to upload data')
    output$test_choices_4  <- test_selector(input_name='selected_test_4',message='Select test data to validate')
    create_validation()
     shinyjs::hide("form")
    shinyjs::hide("save_test")
    shinyjs::show("another_test_msg")
    })

#   observeEvent(input$update_click, {
#   output$test_choices_1 <- test_selector(input_name='selected_test_1',message='Select existing test to edit',ignoreNULL = FALSE)
#   })

  observeEvent(input$submit_another_Test, {

    shinyjs::reset("form")
    shinyjs::show("form")
    shinyjs::show("save_test")
    shinyjs::hide("another_test_msg")

  })

  # output the surveys/tests in the UI for data entry
  output$data_entry <- renderTable({
    # if 'Log sample' button not clicked don't allow sample to be saved
      if (input$log_sample < 1){
     tests <- get_test()
      tests <- tests[tests$Test == input$selected_test_2,]
      max_test <- max(tests$Version)
      tests <- tests[tests$Version == max_test,]
      tests <- tests[,c(1,3)]
      if((length(row.names(tests)) == 0)){
        return()
      }
      else{
      return(tests)}}
  })
        # return(list(open_test()))
    # if sample logged allow results to be saved:
    output$data_entry2 <- renderUI({
      if (input$log_sample > 0)
    #  save_data()
    #  return()
       return(list(open_test(), save_button()))
  })

  # immediately following logging save empty sample
  observeEvent(input$log_sample, {
    if (input$log_sample == 1)
      try(save_data())
  })


  # labelMandatory <- function(label) { tagList( label, span('*', class =
  # 'mandatory_star') ) }

  observeEvent(input$save_click, {

    test_df_forms <- get_test()
    max_test <- max(test_df_forms$Version[test_df_forms$Test %in% input$selected_test_2])
    fieldsMandatory <- test_df_forms$Question_order_name[test_df_forms$required == T & test_df_forms$Test %in% input$selected_test_2 & test_df_forms$Version == max_test]
    mandatoryFilled <- vapply(fieldsMandatory, function(x) {
      !is.null(input[[x]]) && input[[x]] != ""
    }
    , logical(1))
    mandatoryFilled <- all(mandatoryFilled)

    if (mandatoryFilled == T | is.null(fieldsMandatory)) {
      # enable/disable the submit button
      if (is.null(input$save_click))
        return()
      if (input$save_click >= 1) {
        save_data()
        shinyjs::hide("form")
        shinyjs::hide("save_button")
        shinyjs::hide("mandatory")
        shinyjs::show("thankyou_msg")
      }
    }
    if (mandatoryFilled == F) {
      shinyjs::show("mandatory")
    }
  })

  observeEvent(input$submit_another, {

    shinyjs::reset("form")
    shinyjs::show("form")
    shinyjs::show("save_button")
    shinyjs::hide("thankyou_msg")

  })

  observeEvent(input$submit_finish, {
     shinyjs::reset("form")
    shinyjs::hide("form")
    shinyjs::hide("thankyou_msg")
  })

  # Make the input$ values global so result_input() function can
  # access the answers

  input <<- input

  # creates a dataframe reactively for saveData function to save to file make
  # these functions global so that save_data can find the dataframe to save to
  # file:
  answers_df <<- reactive({
    result_input()
  })

  # create counter to add unique number to each record saved
#   output$counter <- renderText({
#     counters <- count_test()
#     return(paste0("Test count: ", counters))
#   })

  # upload data
  output$upload_data <- renderUI({
    upload_data()
  })

  # Data validation table output:
  output$result_table <- renderDataTable({

    data <- read.csv(file = "dataResults.csv")
    unvalidated_data <- data[data$Mode == "B" & data$Test == input$selected_test_4,]

    return(unvalidated_data)
  })

  output$validate_table <- renderDataTable({

    dataMode <- read.csv(file = "dataResults.csv")
    dataMode <- dataMode[dataMode$Mode == "B" & dataMode$Test == input$selected_test_4,
                         ]
    # needs updating so different rules used for different verions:
    validation_name <<- paste("valid_", unique(dataMode$Test), "_",
                              max(dataMode$Version), ".R", sep = "")
    source(validation_name)
    dataMode <- as.data.frame(validation_rule(dataMode))
    return(dataMode)
  })

  observeEvent(input$validate, {
    validate_data()
  })
})
