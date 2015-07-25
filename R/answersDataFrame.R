# creates dataframe of answers

# currently excludes saveClick input - this is used to count number of times data has been entered. probably can remove in future
# as old feature borrowed from oline article in first attempt at creating forms


answersDataFrame <- function() {

allInputValues <- names(input)

analysis <- input$Analysis

questions <- allInputValues[!allInputValues %in% c(analysis)]


answers <- lapply(questions,function(question){
  answer <- eval(parse(text=paste("input$",question,sep="")))
  return(answer)
})

answers <- data.frame(do.call("rbind", answers))

answers$'Test' <- answers[1,1]


answers <- answers[-1,]

names(answers) <- c("Answer","Test")

questions <- data.frame(questions)

names(questions) <- "Questions"

questions <- questions[-1,]

answers <- cbind(answers,questions)

# remove saveClick input - probably remove this in future - left it in for now

answers <- answers[!answers$questions == 'saveClick',]
answers <- answers[!answers$questions == 'submit_another',]
answers <- answers[!answers$questions == 'testClick',]
answers <- answers[!answers$questions == 'submit_another_test',]
#answers <- answers[!answers$questions == 'Test_name',]

answers$'Mode' <- 'B'
#answers  <<-  answers


return(answers)

}
