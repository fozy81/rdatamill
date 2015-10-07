# creates dataframe of answers

answersDataFrame <- function() {

allInputValues <- names(input)

analysis <- input$Analysis
testForm <- read.csv(file="testForm.csv")
testForm <- testForm[testForm$Test == analysis,]
test_max <- max(testForm$Version)
testForm <- testForm[testForm$Version == test_max,]
# get only input values/questions that in relevant test selected:
questions <- allInputValues[allInputValues %in% testForm$Question_order]

answers <- lapply(questions,function(question){
  answer <- data.frame(eval(parse(text=paste("input$",question,sep=""))))
  result_name <- testForm$Question[testForm$Question_order %in% question]
  answer$question <- result_name
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
# not working - want to increase 'counter' each time dataentry is saved
counter <- counter_test()
answers$Test_number <- counter
 counter <- counter + 1
 save(counter, file="counter.Rdata")
 counter <- counter_sample()
 answers$Sample_number <- counter
 counter <- counter
 save(counter, file="sampleCounter.Rdata")

return(answers)

}
