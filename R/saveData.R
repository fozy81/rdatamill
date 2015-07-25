
# not sure why this works! - without the first two if statements...

saveData <- function(){

if(is.null(input$saveClick))
  return()
if(input$saveClick == 1){

  if (!file.exists("dataResults.csv")){

    try(return(write.csv(answersDF(), "dataResults.csv",row.names = FALSE)))
  }
  if(file.exists("dataResults.csv")){

    dataResults <- read.csv("dataResults.csv")
    dataResults <- rbind(dataResults,answersDF())
    return(write.csv(dataResults, "dataResults.csv", row.names = FALSE))

  }
}
  }


