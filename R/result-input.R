# creates dataframe of results entered

result_input <- function(){


analysis <- input$Analysis

#analysisINputs <<- input$Analysis
answers <- lapply(analysis,function(analysis){

testForm <- read.csv(file="testForm.csv")
testForm <- testForm[testForm$Test == analysis,]
test_max <- max(testForm$Version)
testForm <<- testForm[testForm$Version == test_max,]
# get only input values/questions that in relevant test selected:
questions <- allInputValues[allInputValues %in% testForm$Question_order_name]
answers <- lapply(questions,function(question){


  result_name <<- as.character(testForm$Question[testForm$Question_order_name %in% question])
  answer <<- data.frame(eval(parse(text=paste("input$",question,sep=""))))
  answer$question <- result_name

      return(answer)
})
answers <- data.frame(do.call("rbind", answers))

names(answers) <- c('Result','Question')

answers1  <<- answers #testing
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
})
answers <- data.frame(do.call("rbind",answers))
return(answers)

}
