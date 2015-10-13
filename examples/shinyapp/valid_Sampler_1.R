validation_rule <-
function(results){
  testForms <- read.csv("testForm.csv")
name_test <- unique(as.character(results$Test))
testForms <- testForms[testForms$Test == name_test,]
version <- max(testForms$Version)
testForms <- testForms[testForms$Test == name_test & testForms$Version == version,]
validate_test <- lapply(testForms$Question,function(question){
                  testQuestion <- testForms[testForms$Question == question,]

                   valid <-  lapply(results$Result_Number[results$Question == testQuestion$Question],function(result_number){
                      result_list <- results[results$Result_Number == result_number,]
                               result_list <- cbind(result_list,testQuestion)
                        if(result_list$types == 'text box'){
result_list$Result <- as.character(result_list$Result)
result_valid_check <- is.character(result_list$Result)
return(result_valid_check)
                        }
  if(result_list$types == 'numeric'){
   result_list$Result <- as.numeric(result_list$Result)
   result_valid_check_1 <- is.numeric(result_list$Result)
   ifelse(result_list$Result == 11,result_valid_check_2 <- FALSE, result_valid_check_2 <- TRUE)
   result_valid_check <- rbind(result_valid_check_1, result_valid_check_2)
  return(result_valid_check)
}
}
)
valid <- data.frame(do.call("rbind", valid))
return(valid)})
return(validate_test)}
