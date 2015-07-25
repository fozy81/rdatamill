
# not sure why this works! - without the first two if statements...

validateData <- function(){

if(is.null(input$validate))
  return()
if(input$validate == 1){

  if (!file.exists("dataResults.csv")){

    try(return())
  }
  if(file.exists("dataResults.csv")){

    dataV <- read.csv(file='dataResults.csv')
    dataV$Mode <- as.character(dataV$Mode)
    dataV$Mode[dataV$Mode == 'B' & dataV$Test == input$Test] <- 'C'
    dataV <<-  dataV
    return(write.csv(dataV, "dataResults.csv", row.names = FALSE))

  }
}
}



