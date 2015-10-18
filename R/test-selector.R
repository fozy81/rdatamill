# function to create selector for tests

test_selector <- function(input_name='select_test',message='Select Test:',multiple=F){

       selector <- renderUI({
    # use test_df function to get reactive test list? so if test added
    # this will be added to drop  down list:
    test_df <- test_df()
    test_df <- test_df$Test
   # if no tests available leave blank:
    if (is.null(test_df))
      test_choices <- setNames("", "") else (test_choices <- setNames(test_df, test_df))
    ui <- selectInput(input_name,message, choices = test_choices,multiple=multiple)
    return(ui)
  })


}
