

create_validation <- function(){
  # create bioler plate validation rule function - perhaps make this optional in future - only use if custom validation rules required


# get some variables required to create validation rules
  test_questions <- test_input(update=F)
  name_test <- unique(as.character(test_questions$test))
  name_test_under_score <- gsub(" ","_",name_test)  # add unscore if spaces in test name
  tests <- get_test()
  version <- max(tests$version[tests$test == name_test])
file_name <- paste("valid_",name_test_under_score,"_",version,".R",sep="")
func_name <- paste("validate_",name_test_under_score,"_",version,"",sep="")


validation_test  <-  paste("# create validation rules:
#### add options for format validation checks or data valiation checks for
#### result, test or sample - option to run during initial data entry or at
#### valiation stage.


### Two sections:
### 1. Format validation checks - these are run before data is saved during
### data entry. If they fail, the data won't be saved. The format checks are
### based on data types and settings selected
### during test creation. More complex format or logical checks can added to
### this file after it is created. For instance, if the answer to a number of
### questions must be logically consistent (adding up to a particular value or
### depend or other questions). The main feature of format and logic checks are
### that they are internal to to a single test/result and can be determined
### without comparison to saved data.
### Format and logical checks should be used to check the raw data coming in is
### as expected not to convert, update, round or manipulate raw data.
### For instance, if data from a piece of equipment is expected to record data
### to two decimal points, a check should be in place to test this. But the data
### should not be rounded or extra decimals added. The data should be recorded
### as it is provided by laboratory machinery or direct observation without
### changes.
###
### 2. Data Validation checks - these are different from Format validation checks as
### they depend on comparison to previously entered results. These checks are
### not internal to the single sample/test/result but are comparisons to data or
### values previosuly saved. For instance, results that are greater than two
### standard deviations from previously results could be highlighted. Or a
### search for duplicated results/samples could be run. There are three types of validation tests:
### a) results level - e.g. check to find extreme values based on previous recorded data
### b) test level - e.g. test to look for tests that should not be duplicated
### c) sample - e.g. looking for sample that have been duplicated
### In general, valiation checks are run during data validation not during data entry - but this is optional


",func_name," <- function(results){
  tests <- read.csv(\"test.csv\")
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
valid <- data.frame(do.call(\"rbind\", valid))
return(valid)})
return(validate_test)}
",sep="")


validation_rule <-  eval(parse(text=validation_test))

save(validation_rule,file=paste("",file_name,"Data",sep=""))
newEnv <- new.env()
load(paste("",file_name,"Data",sep=""), newEnv)
dump(c(lsf.str(newEnv)), file=file_name, envir=newEnv)
wd <- getwd()
system(paste("rm ",wd,"/",file_name,"Data",sep=""))
}
