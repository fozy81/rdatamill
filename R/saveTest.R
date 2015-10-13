saveTest <- function(){


  if(is.null(input$testClick))
    return()
  if(input$testClick >= 1){
    if (!file.exists("testForm.csv")){
      # save the version number of the test if testForm doesn't exists:
      test_questions <- testDF()
      test_questions$Version <- 1

       try(return(write.csv( test_questions, "testForm.csv",row.names = FALSE)))
    }

    # save the version number of the test if testForm already exists:

    if(file.exists("testForm.csv")){
     test_questions <- testDF()
   #  test_questions   <-   test_questions
     savedTestForms <- read.csv("testForm.csv", stringsAsFactors=F)
     test_questions$Test <- as.character(test_questions$Test)

#savedTestForms  <- savedTestForms
         if (unique(test_questions$Test) %in% savedTestForms$Test){
         name_test <- as.character(unique( test_questions$Test))
         version <- max(savedTestForms$Version[savedTestForms$Test == name_test])
         test_questions$Version  <- version + 1
         test_questions$Date_created  <- as.character(test_questions$Date_created)
                 savedTestForms <- rbind(savedTestForms, test_questions)

         return(write.csv(savedTestForms, "testForm.csv", row.names = FALSE))

    }
    # save the version number of the test if testForm already exists but test name doesn't:
       if  (!unique(test_questions$Test) %in% savedTestForms$name_test){
         test_questions$Version <- 1
         savedTestForms <- rbind(savedTestForms,test_questions)


      return(write.csv(savedTestForms, "testForm.csv", row.names = FALSE))}
}
}
   }

