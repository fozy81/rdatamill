# function to create selector for tests

test_ui <- function(){

       testui <- renderUI({

    # use get_test function to test df

   # if no tests available leave blank:

    ui <- open_test()
    return(ui)
  })

}
