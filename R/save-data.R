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
    new_results$result_number <- row.names(new_results)
    results <- rbind(results,new_results)
    results$result_number <- row.names(results)
    results$result <- unlist(results$result)
    results$question <- unlist(results$question)
  #  results <- data.frame(results)

    return(write.csv(results, "results.csv", row.names = FALSE))

  }
}



