# creates dataframe of results entered

result_input <- function(analysis=analysis){

if(analysis == analysis){
analysis <- input$selected_test_2
}
allInputValues <- names(input)

answers <- lapply(analysis,function(analysis){

testForm <- read.csv(file="testForm.csv")
testForm <- testForm[testForm$Test == analysis,]
test_max <- max(testForm$Version)
testForm <- testForm[testForm$Version == test_max,]

# get only input values/questions that in relevant test selected:
questions <- allInputValues[allInputValues %in% testForm$Question_order_name]
answers <- lapply(questions,function(question){

    result_name <- as.character(testForm$Question[testForm$Question_order_name %in% question])
  answer <- data.frame(eval(parse(text=paste("input$",question,sep=""))))
  answer$question <- unique(result_name)

      return(answer)
})
answers <- data.frame(do.call("rbind", answers))

 names(answers) <- c('Result','Question')


answers$'Mode' <- 'B'
# this is saving the user - could use session info in future:
answers$'Entered_by' <- "Default"
answers$Date_entered <- as.factor(Sys.time())
answers$Test <- unique(testForm$Test)
answers$Version <- max(testForm$Version)
answers$Test_number <- count_sample()
 answers$Sample_number <- 1
 answers <- answers
 return(answers)
})

answers <- data.frame(do.call("rbind",answers))
answers$Sample_number <- count_test()
return(answers)

}
