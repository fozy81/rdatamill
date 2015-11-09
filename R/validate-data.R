
# not sure why this works! - without the first two if statements...

validate_data <- function(){

if(is.null(input$tests_to_validate))
  return()
if(input$tests_to_validate == 1){

  if (!file.exists("results.csv")){

    try(return())
  }
  if(file.exists("results.csv")){

    results <- read.csv(file='results.csv')
    results$mode <- as.character(results$mode)
    results$mode[results$mode == 'B' & results$test == tests_to_validate] <- 'C'
    return(write.csv(results, "results.csv", row.names = FALSE))

  }
}
}



