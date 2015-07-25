saveTest <- function(){


  if(is.null(input$testClick))
    return()
  if(input$testClick == 1){
    if (!file.exists("testForm.csv")){
      answers <<- testDF()
     # answers$Test_name <- answers$Answer[answers$questions== 'Test_name']
       try(return(write.csv(answers, "testForm.csv",row.names = FALSE)))
    }
    if(file.exists("testForm.csv")){
     answers <<- testDF()
   #  answers$Test_name <- answers$Answer[answers$questions== 'Test_name']
     dataResults <- read.csv("testForm.csv")
  dataResults <- rbind(dataResults,answers)
  return(write.csv(dataResults, "testForm.csv", row.names = FALSE))

}
   }
}
