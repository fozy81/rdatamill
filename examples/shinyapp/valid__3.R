validation_rule <-
function(results){
  tests <- read.csv("test.csv")
name_test <- unique(as.character(results$test))
tests <- tests[tests$test == name_test,]
version <- max(tests$version)
tests <- tests[tests$test == name_test & tests$version == version,]
validate_test <- lapply(tests$question,function(question){
                  testquestion <- tests[tests$question == question,]

                   valid <-  lapply(results$result_number[results$question == testquestion$question],function(result_number){
                      result_list <- results[results$result_number == result_number,]
                               result_list <- cbind(result_list,testquestion)
                        if(result_list$types == 'text box'){
result_list$result <- as.character(result_list$result)
result_valid_check <- is.character(result_list$result)
return(result_valid_check)
                        }
  if(result_list$types == 'numeric'){
   result_list$result <- as.numeric(result_list$result)
   result_valid_check_1 <- is.numeric(result_list$result)
   ifelse(result_list$result == 11,result_valid_check_2 <- FALSE, result_valid_check_2 <- TRUE)
   result_valid_check <- rbind(result_valid_check_1, result_valid_check_2)
  return(result_valid_check)
}
}
)
valid <- data.frame(do.call("rbind", valid))
return(valid)})
return(validate_test)}
