#save test

save_test <- function(update=NULL){

    if (!file.exists("tests.csv")){
      # save the version number of the test if tests.csv doesn't exists:
      test_questions <- test_input()
      test_questions$version <- 1

       try(return(write.csv( test_questions, "tests.csv",row.names = FALSE)))
    }

    # save the version number of the test if tests.csv already exists:

    if(file.exists("tests.csv")){
     test_questions <- test_input(update)
     saved_tests <- read.csv("tests.csv", stringsAsFactors=F)
     test_questions$test <- as.character(test_questions$test)


         if (unique(test_questions$test) %in% saved_tests$test){
         name_test <- as.character(unique( test_questions$test))
         version <- max(saved_tests$version[saved_tests$test == name_test])
         test_questions$version  <- version + 1
         test_questions$date_created  <- as.character(test_questions$date_created)
                 saved_tests <- rbind(saved_tests, test_questions)

         return(write.csv(saved_tests, "tests.csv", row.names = FALSE))

    }
    # save the version number of the test if tests.csv already exists but test name doesn't:
       if  (!unique(test_questions$test) %in% saved_tests$name_test){
         test_questions$version <- 1
         test_questions$date_created  <- as.character(test_questions$date_created)
         saved_tests <- rbind(saved_tests,test_questions)


      return(write.csv(saved_tests, "tests.csv", row.names = FALSE))}
}
}


