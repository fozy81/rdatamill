# function to create selector for tests

test_selector <- function(input_name=NULL,message=NULL,multiple=F){

      selector <- renderUI({

    # use get_test function to test df
    tests <- get_test()
    tests <- tests$test
   # if no tests available leave blank:
    if (is.null(tests))
      test_choices <- setNames("", "") else (test_choices <- setNames(tests, tests))
    ui <- selectInput(input_name,message, choices = test_choices,multiple=multiple)
    return(ui)
  })


}
