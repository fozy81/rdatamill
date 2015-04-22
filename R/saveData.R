saveData <- function(){

if(is.null(input$saveClick))
  return()
if(input$saveClick == 1){

  if (!file.exists("dataResults.csv")){
    saveCount <<- 2
    try(return(write.csv(answersDF(), "dataResults.csv",row.names = FALSE)))
  }
  if(file.exists("dataResults.csv")){
    saveCount <<- 2
    dataResults <- read.csv("dataResults.csv")
    dataResults <- rbind(dataResults,answersDF())
    return(write.csv(dataResults, "dataResults.csv", row.names = FALSE))

  }
}
  }


