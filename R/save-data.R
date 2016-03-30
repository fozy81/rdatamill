# saves user entered results

save_data <- function(sample_number=NULL,multiple_test=NULL,selected_tests=NULL){


  if (!file.exists("results.csv")){
    results <- result_input(sample_number=NULL,selected_tests=selected_tests)
    results$result_number <- row.names(results)
    try(return(write.csv(results, "results.csv",row.names = FALSE)))
  }
  if(file.exists("results.csv")){

    results <- read.csv("results.csv",stringsAsFactors = FALSE)
if(!is.null(sample_number)){
  if(is.null(multiple_test)){
      results <- results[!results$sample_number %in% sample_number,]
  }
}

    new_results <- result_input(sample_number=sample_number,selected_tests=selected_tests)

    ### remove multiple answer if not allowed
    if(unique(new_results$sample_number) %in% results$sample_number) {

        answers  <- lapply(selected_tests, function(test){
          test_df <- get_test()
         test_df <- test_df[test_df$test == test,]
        test_max <- max(test_df$version)
        test_df <- test_df[test_df$version == test_max,]
        return(test_df)
        })
        answers <- data.frame(do.call("rbind", answers))

          answers <- answers[answers$multiple_results == TRUE,]

          new_results <- new_results[new_results$question %in% answers$question,]

        }

    new_results$result_number <- row.names(new_results)
    results <- rbind(results,new_results)
    results$result_number <- row.names(results)
    results$result <- unlist(results$result)
    results$question <- unlist(results$question)
  #  results <- data.frame(results)
    ## remove answers if multiple entries not allowed




    return(write.csv(results, "results.csv", row.names = FALSE))

  }
}



