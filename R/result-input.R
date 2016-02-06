# creates dataframe of results entered

result_input <- function(sample_number=NULL,selected_tests=NULL){

  tests <- selected_tests

if(!is.null(selected_tests)){

  tests <- selected_tests
}

allInputValues <- names(input)

answers <- lapply(tests,function(test){

test_df <- get_test()
test_df <- test_df[test_df$test == test,]
test_max <- max(test_df$version)
test_df <- test_df[test_df$version == test_max,]

# get only input values/questions that in relevant test selected:
#questions <- allInputValues[allInputValues %in% test_df$question_order_name]
questions <- test_df$question_order_name
answers <- lapply(questions,function(question){

    result_name <- as.character(test_df$question[test_df$question_order_name %in% question])
 # answer <- data.frame(eval(parse(text=paste("input$",question,sep=""))))
    answer <- data.frame(input[[question]])
  if(length(answer) == 0){
    answer <- data.frame("")}
  answer$question <- unique(result_name)

      return(answer)
})
answers <- data.frame(do.call("rbind", answers))
if(length(answers) == 0){
     answers <- data.frame("","")
}

 names(answers) <- c('result','question')

answers$'mode' <- 'B'
# this is saving the user - could use session info in future:
answers$entered_by <- "Default"
answers$date_entered <- as.factor(Sys.time())
answers$test <- unique(test_df$test)
answers$version <- max(test_df$version)
answers$test_number <- count_sample()
 answers$sample_number <- 1 # temporary value
 answers <- answers
 return(answers)
})

answers <- data.frame(do.call("rbind",answers))
answers$sample_number <- unique(sample_number)
  if(is.null(sample_number)){
answers$sample_number <- count_test()
  }
sample_number <<- answers$sample_number
return(answers)
}
