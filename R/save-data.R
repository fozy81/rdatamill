# saves user entered results

save_data <- function(){

  if (!file.exists("dataResults.csv")){
    dataResults <- answers_df()
    dataResults$Result_Number <- row.names(dataResults)
    try(return(write.csv(dataResults, "dataResults.csv",row.names = FALSE)))
  }
  if(file.exists("dataResults.csv")){

    dataResults <- read.csv("dataResults.csv",stringsAsFactors = FALSE)
    newResults <- answers_df()
    newResults$Result_Number <- row.names(newResults)
    dataResults <- rbind(dataResults,newResults)
    dataResults$Result_Number <- row.names(dataResults)

    return(write.csv(dataResults, "dataResults.csv", row.names = FALSE))

  }
}
#}


