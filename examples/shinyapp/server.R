library(shiny)
library(rdatamill)
library(shinyjs)
library(formattable)
library(rpivotTable)


shinyServer(function(input, output, session) {

  # create a differently named selectInput for each page to pick from list of available tests
  # and update when new test created. If no test available leave blank:
  output$tests_to_edit <- test_selector(input_name='tests_to_edit',message='Select existing Form to edit')
  output$tests_to_log  <- test_selector(input_name='tests_to_log',message='Select Forms to add to sample:',multiple=T)
  output$tests_to_upload  <- test_selector(input_name='tests_to_upload',message='Select Form to upload data')
  output$tests_to_validate  <- test_selector(input_name='tests_to_validate',message='Select Form data to validate')

  # output the 'create test' & save button in the UI if 'create test' button selected
  observeEvent(input$create_new_test, {
    output$test_create  <- renderUI({
        create_test()
      })
    shinyjs::show("save_new")
    shinyjs::hide("update_test_button")
    shinyjs::hide("updated_test_msg")

  })

  # if new test saved or existing test updated/edited then save new verison of test to file and create validation function
  observeEvent(input$save_new_test, {
    save_test(update=F)
    # update drop down lists of tests on all pages
    output$tests_to_edit <- test_selector(input_name='tests_to_edit',message='Select existing Form to edit')
    output$tests_to_log  <- test_selector(input_name='tests_to_log',message='Select Forms to add to sample:',multiple=T)
    output$tests_to_upload  <- test_selector(input_name='tests_to_upload',message='Select Form to upload data')
    output$tests_to_validate  <- test_selector(input_name='tests_to_validate',message='Select Form data to validate')
    # create wireframe validation function for new test
        create_validation()
  # show thank you message on screen
    shinyjs::hide("test_create")
    shinyjs::hide("save_new")
    shinyjs::show("another_test_msg")
  })

observeEvent(input$submit_another_test, {
    shinyjs::show("test_create")
    shinyjs::show("save_new")
    shinyjs::hide("another_test_msg")
  })

# output the 'edit test' panel in the UI if 'edit test' button selected
observeEvent(input$edit_test, {

  output$test_create  <- renderUI({
   update_test(selected_tests=input$tests_to_edit)
    })
  shinyjs::show("test_create")
  shinyjs::show("update_test_button")
  shinyjs::hide("save_new")
  shinyjs::hide("updated_test_msg")
  shinyjs::hide("another_test_msg")
})

# save updated test
observeEvent(input$update_test_button, {
  save_test(update=T)
  # create wireframe validation function fupdated test (remove this in future!)
 # create_validation()
  # show thank you message on screen
 # shinyjs::hide("test_update")
  shinyjs::hide("update_test_button")
  shinyjs::show("updated_test_msg")
  shinyjs::hide("test_create")
})

  # output the surveys/tests in the UI for data entry
  output$test_details_table <- renderTable({
    # if 'Log sample' button not clicked don't allow sample to be saved. display table of tests
      if (input$log_sample < 1){
      shinyjs::hide("data_entry")
         test <- lapply(input$tests_to_log, function(x){
         tests <- get_test()
         tests <- tests[tests$test == x,]
         max_test <- max(tests$version)
         tests <- tests[tests$version == max_test,]
         tests <- tests[,c(1,3)] })
         test <- data.frame(do.call("rbind", test))
         if((length(row.names(test)) == 0)){
           return()
         }
         else{
           return(test)
         }
         }

    })

#  If 'log sample' clicked, immediately log sample and create sample number by saving empty sample:
  observeEvent(input$log_sample, {
    if (input$log_sample == 1)
     #save data:
          save_data(selected_tests=input$tests_to_log)
    # show empty logged sample and save button
    output$sample_open <- renderUI({
      open_sample(sample_number) })
      shinyjs::show("save_click")
      shinyjs::show("finish")
    shinyjs::hide("tests_to_log")
  })

# if 'save' button clicked - run basic validation checks and save results to sample:
  observeEvent(input$save_click, {
    # check if test has mandatory fields:
    tests <- get_test()
    results <- read.csv(file="results.csv")
    results <- results[results$sample_number %in% sample_number,]
    max_test <- max(results$version)
    fields_mandatory <- tests$question_order_name[tests$required == T & tests$test %in% unique(results$test) & tests$version == max_test]
    mandatory_filled <- vapply(fields_mandatory, function(x) {
      !is.null(input[[x]]) && input[[x]] != ""
    }
    , logical(1))
    mandatory_filled <- all(mandatory_filled)
    # check if test(s) can be added mulitple times:
    tests <- tests[tests$test %in% unique(results$test) & tests$version == max_test,]
    multiple_test  <-    all(tests$multiple_results)

    if (mandatory_filled == T &  multiple_test == T | is.null(fields_mandatory)) {
      # enable/disable the submit another button depending whether multiple tests/results can be entered:
      if (is.null(input$save_click))
        return()
      if (input$save_click > 0 &  input$submit_another == 0) {
            save_data(sample_number = sample_number,selected_tests=unique(results$test))
        shinyjs::hide("sample_open")
        shinyjs::hide("save_click")
        shinyjs::hide("mandatory")
        shinyjs::show("thank_you_continue")
        shinyjs::show("finish")
        output$data_entry2 <- renderUI({
          return()
        })
      }
      if (input$save_click > 0 &  input$submit_another >= 1) {
        selected_tests <- tests$test[tests$test %in% unique(results$test) & tests$version == max_test & tests$multiple_results == T]
        save_data(sample_number = sample_number,multiple_test=T,selected_tests=unique(results$test))
        shinyjs::hide("sample_open")
        shinyjs::hide("save_click")
        shinyjs::hide("mandatory")
        shinyjs::show("thank_you_continue")
        shinyjs::show("finish")
        output$data_entry3 <- renderUI({
          return()
        })

      }
    }
    # display error message if mandatory fields not completed:
    if (mandatory_filled == F) {
      shinyjs::show("mandatory")
      shinyjs::show("finish")
    }
    # if multiple results not allowed display thank you message:
    if (mandatory_filled == T & multiple_test == F ) {
      save_data(sample_number = sample_number,selected_tests = unique(results$test))
      shinyjs::hide("sample_open")
      shinyjs::hide("save_click")
      shinyjs::hide("mandatory")
      shinyjs::show("thank_you_end")
      shinyjs::show("finish")
    }
  })

# if multiple test = T, then display only test(s) that is allowed multiple entries:
  observeEvent(input$submit_another, {

 output$sample_open <- renderUI({
                 if (input$submit_another == 0){
                   return()}

 return(list(open_sample(sample_number),shinyjs::show("sample_open"),
                             shinyjs::hide("thank_you_continue"),
                      shinyjs::show("save_click"),shinyjs::hide("mandatory"),shinyjs::show("finish")))
            })
})

# reset once finished with logging samples / data entry:
#    observeEvent(input$submit_finish, {
#
#      output$sample_open <- return()
#   })
#
#    observeEvent(input$finish, {
#
#     output$sample_open <- return()
#    })



# create list of samples previously logged:
   output$sample_choice <-  renderUI({
     if (file.exists("results.csv")) {
       results <- read.csv(file = "results.csv", stringsAsFactors = F)
                           results <- results$sample_number}
    else {return()}
       sample_choice <- selectInput(inputId  = 'selected_sample',label='Select sample',choices = results,selected = NULL)
    return(sample_choice)
  })

# create list of tests based on sample_number selected
   output$test_choice <-  renderUI({
     sample_number <<- input$selected_sample
     selected_sample <- input$selected_sample
     if (is.null(selected_sample)){
       return()
     }
     results <- read.csv(file = 'results.csv', stringsAsFactors = F)
     results_test <- unique(results$test[results$sample_number == selected_sample])
     test_choice <- selectInput(inputId = 'selected_test',label='Select test',choices = results_test,selected = results_test, multiple = T)
     return(test_choice)
   })

   # update sample_numbers after results saved:
   observeEvent(input$save_click, {
     output$sample_choice <-  renderUI({
       results <- read.csv(file="results.csv")
       results <- results$sample_number
       if (length(results) < 1){
         return()
       }
       sample_choice <- selectInput(inputId  = 'selected_sample',label='Select sample',choices = results)
       return(sample_choice)
     })
   })

   observeEvent(input$open_sample, {
     shinyjs::hide("save_click")
     shinyjs::hide("thank_you_continue")
 output$sample_open <- renderUI({
open_sample(input$selected_sample, test=input$tests_to_update)
         })
  shinyjs::show("save_click")
  shinyjs::show("tests_to_log")
 })


  # Make the input$ values global so result_input() function can
  # access the results entered
 input <<- input

  # upload data
  output$upload_data <- renderUI({
    upload_data()
  })

  # Data validation table output:
  output$result_table <- renderDataTable({
    data <- read.csv(file = "results.csv")
    unvalidated_data <- data[data$mode == "B" & data$test == input$tests_to_validate,]
    return(unvalidated_data)
  })

  output$validate_table <- renderFormattable({
    date_mode <- read.csv(file = "results.csv")
    date_mode <- date_mode[date_mode$mode == "B" & date_mode$test == input$tests_to_validate,
                     ]

    date_mode <- as.data.frame(format_validation(date_mode))
  date_mode <-  formattable(date_mode,list(
           result_msg = formatter("span",
                                  style = x ~ ifelse(x == "PASS", style(color = "green", font.weight = "bold"), style(color = "red", font.weight = "bold")))
    ))

    return(date_mode)
  })

  output$validate_data_table <- renderDataTable({
    date_mode <- read.csv(file = "results.csv")
    date_mode <- date_mode[date_mode$mode == "B" & date_mode$test == input$tests_to_validate,
                           ]
    # needs updating so different rules used for different verions:
        validation_name <- paste("valid_", unique(date_mode$test), "_1.R", sep = "")
      source(validation_name)
    date_mode <- as.data.frame(validation_rule(date_mode))
    return(date_mode)
  })

  observeEvent(input$validate, {
    validate_data()
  })

  output$valid_results_table <- renderRpivotTable({
    date_mode <- read.csv(file = "results.csv")
    date_mode <- rpivotTable(date_mode)
    return(date_mode)
    })
})
