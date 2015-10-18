
# not sure why this works! - without the first two if statements...

validate_data <- function(){

if(is.null(input$selected_test_4))
  return()
if(input$selected_test_4 == 1){

  if (!file.exists("dataResults.csv")){

    try(return())
  }
  if(file.exists("dataResults.csv")){

    dataV <- read.csv(file='dataResults.csv')
    dataV$Mode <- as.character(dataV$Mode)
    dataV$Mode[dataV$Mode == 'B' & dataV$Test == input$Data_test] <- 'C'
    dataV <<-  dataV
    return(write.csv(dataV, "dataResults.csv", row.names = FALSE))

  }
}
}



