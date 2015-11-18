validation_rule <-
function(results){
# create validation rules:
#### add options for format validation checks or data valiation checks for
#### result, test or sample.

## Data Validation checks - these are different from Format validation checks as
## they depend on comparison to previously entered results. These checks are not
## internal to the single sample/test/result but are comparisons to data or
## values previosuly saved. For instance, results that are greater than two
## standard deviations from previously results could be highlighted. Or a search
## for duplicated results/samples could be run. There are three types of
## validation tests: a) results level - e.g. check to find extreme values based
## on previous recorded data b) test level - e.g. test to look for tests that
## should not be duplicated c) sample - e.g. looking for sample that have been
## duplicated In general, valiation checks are run during data validation not
## during data entry. Below is a commented out wire-frame data validation check
## that returns FAIL if result is > 1000 Similar checks could be run on previous
## result - looking for results that a beyond two SD from the mean i.e. historic
## limit checks. Currently this function returns a default message. There is
## an example of  potential check in comments below

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

  result_list$valid_msg <- "PASS - No data validation rules defined!"
        return(result_list[,c("question","result","types","sample_number","result_number","test","valid_msg")])
})

# result_list <- results[results$result_number == result_number,]
# result_list <- cbind(result_list,testquestion)
#
# if(result_list$types == 'numeric'){
#
#
# ifelse(result_list$result => 1000 ,result_valid_check <- FALSE, result_valid_check <- TRUE)
#
# if(result_valid_check == TRUE){
# result_list$valid_msg <- "PASS - Result is of class numeric"}
# result_list$result_msg <- "PASS"
# if(result_valid_check == FALSE){
# result_list$valid_msg <- "FAIL - Result is not of class numeric"}
# result_list$result_msg <- "FAIL"
# return(result_list[,c("question","result","types","sample_number","result_number","test","result_msg","valid_msg")])
# }
 })
}
