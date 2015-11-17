

format_validation <- function(results){

### Format validation checks - these are run before data is saved for all tests
### during data entry. If they fail, the data won't be saved. The format checks
### are based on data types and settings selected during test creation. The main
### feature of format and logic checks are that they are internal to to a single
### test/result and can be determined without comparison to saved data. Format
### and logical checks should be used to check the raw data coming in is as
### expected not to convert, update, round or manipulate raw data. For instance,
### if data from a piece of equipment is expected to record data to two decimal
### points, a check should be in place to test this. But the data should not be
### rounded or extra decimals added. The data should be recorded as it is
### provided by laboratory machinery or direct observation without changes.
###

tests <- get_test()
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
if(result_valid_check == TRUE){
  result_list$valid_msg <- "Result is of class character"
result_list$result_msg <- "PASS"}
if(result_valid_check == FALSE){
  result_list$valid_msg <- "Result is not of class character"
result_list$result_msg <- "FAIL"}
return(result_list[,c("question","result","types","sample_number","result_number","test","result_msg","valid_msg")])
                        }
  if(result_list$types == 'numeric'){
   result_list$result <- as.numeric(result_list$result)
   result_valid_check <- is.numeric(result_list$result)
#   ifelse(result_list$result == 11,result_valid_check_2 <- FALSE, result_valid_check_2 <- TRUE)
     if(result_valid_check == TRUE){
     result_list$valid_msg <- "PASS - Result is of class numeric"}
   result_list$result_msg <- "PASS"
   if(result_valid_check == FALSE){
     result_list$valid_msg <- "FAIL - Result is not of class numeric"}
   result_list$result_msg <- "FAIL"
   return(result_list[,c("question","result","types","sample_number","result_number","test","result_msg","valid_msg")])
}
})
                   valid <- data.frame(do.call("rbind", valid))
})

}
