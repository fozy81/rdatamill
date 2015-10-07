
# not sure why this works! - without the first two if statements...

saveData <- function(){

if(is.null(input$saveClick))
  return()
if(input$saveClick >= 1){

  if (!file.exists("dataResults.csv")){
    dataResults <- answersDF()
    dataResults$Result_Number <- row.names(dataResults)
    try(return(write.csv(dataResults, "dataResults.csv",row.names = FALSE)))
  }
  if(file.exists("dataResults.csv")){

    dataResults <- read.csv("dataResults.csv",stringsAsFactors = FALSE)
    newResults <- answersDF()
    newResults$Result_Number <- row.names(newResults)
    dataResults <- rbind(dataResults,newResults)
    dataResults$Result_Number <- row.names(dataResults)

    return(write.csv(dataResults, "dataResults.csv", row.names = FALSE))

  }
}
  }


