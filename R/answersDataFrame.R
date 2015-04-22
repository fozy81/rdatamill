answersDataFrame <- function() {

allInputValues <- names(input)

analysis <- input$Analysis

questions <- allInputValues[!allInputValues %in% analysis]

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
answers  <<-  answers
return(answers)

}
