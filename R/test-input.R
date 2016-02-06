# creates dataframe of test editing inputs

# input values from shiny GUI include active button, text boxes etc from all the
# html widgets (in all panels/tabs within app). We only want to keep inputs
# from the form itself:


test_input <- function(update=NULL) {

  all_input_values <- names(input)

  if(update==T){
   # tests <- get_test()
    #test_inputs  <- names(tests)
   # test_inputs  <- paste("update_",test_inputs,sep="")
    test_inputs <-  c("update_question_order","update_types","update_list","update_max","update_min","update_step","update_unit","update_required")
    values <- lapply(test_inputs,function(test_inputs){

      test_names <- grep(pattern=test_inputs,all_input_values, value=T)

      test_input <- lapply(test_names, function(test_inputs){

        if(is.null(input[[test_inputs]])){
          value <-FALSE
          return(value)}


        else {value <- input[[test_inputs]]
        value <- value
        return(value)}
      })
      test_input <- data.frame(do.call("rbind",   test_input))
    })
    #

    answers <- data.frame(do.call("cbind", values))
    names(answers) <- c("question", "types", "lists","max","min","step","unit","required")
    answers$question_order <-  grep(pattern="update_question_",all_input_values, value=T)
    # crete some extra column of useful info - may add more or develop further in future
    answers$'date_created' <- Sys.time()
    answers$'constraint_message' <- ""
    answers$hint <- ""
    # test if can add name to question_test_1 et so that multiple results for the same question can be returned in the same sample
    answers$active <- as.character(input$update_active)
    answers$multiple_results <- as.character(input$update_multiple_results)
    answers <- answers[!answers$question == "",]
    row.names(answers) <- NULL
    answers$num <- row.names(answers)
    answers$question_order_name <- paste(answers$question,answers$'test',answers$num,sep="")
    # name of test
    answers$test <- input$tests_to_edit
    answers <- answers[,c('question','question_order','test', 'active','multiple_results','types','lists','max','min','step','unit','required','date_created','constraint_message','hint','num','question_order_name')]

    return(answers)

  }


  if(update==F){
 #   tests <- get_test()
  #  test_inputs <- names(tests)
  #  test_inputs <- paste('new_',test_inputs,"",sep="")
 #  test_inputs[6] <- "New_types"
     test_inputs <- c("new_question","new_types","new_lists","new_max","new_min","new_step","new_unit","new_required")
   values <- lapply(test_inputs,function(test_inputs){

      test_names <- grep(pattern=test_inputs,all_input_values, value=T)

    test_input <- lapply(test_names, function(test_inputs){

        if(is.null(input[[test_inputs]])){
          value <-FALSE
          return(value)}


    else {value <- input[[test_inputs]]
     value <- value
    return(value)}
    })
    test_input <- data.frame(do.call("rbind",   test_input))
    })
   #

  answers <- data.frame(do.call("cbind", values))
  names(answers) <- c("question", "types", "lists", "max", "min", "step","unit","required")
  answers$question_order <-  grep(pattern="new_question_",all_input_values, value=T)
    # crete some extra column of useful info - may add more or develop further in future
  answers$'date_created' <- Sys.time()
  answers$'constraint_message' <- ""
  answers$hint <- ""
  # test if can add name to question_test_1 et so that multiple results for the same question can be returned in the same sample
  answers$active <- as.character(input$new_active1)
  # name of test
  answers$test <- input$new_test
  answers$multiple_results <- as.character(input$new_multiple_results1)
  answers <- answers[!answers$question == "",]
  row.names(answers) <- NULL
  answers$num <- row.names(answers)
  answers$question_order_name <- paste(answers$question,answers$'test',answers$num,sep="")
    answers <- answers[,c('question','question_order','test', 'active','multiple_results','types','lists','max','min','step','unit','required','date_created','constraint_message','hint','num','question_order_name')]

return(answers)

  }

}


