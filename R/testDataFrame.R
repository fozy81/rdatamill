# creates dataframe of answers

# currently excludes saveClick input - this is used to count number of times data has been entered. probably can remove in future
# as old feature borrowed from oline article in first attempt at creating forms


testDataFrame <- function() {

all_input_values <- names(input)
all_input_values <<- all_input_values
# input values from shiny GUI include active button, text boxes etc from all the
# html widgets (in all panels/tabs with in app). We only want to keep inputs
# from the form:

questions <- grep(pattern ='_test',all_input_values, value=T)

answers <- lapply(questions,function(question){
  answer <- eval(parse(text=paste("input$",question,sep="")))
  return(answer)
})
answers <<- answers
answers <- data.frame(do.call("rbind", answers))

questions <- data.frame(questions)

names(questions) <- "Questions"

answers <- data.frame(cbind(answers,questions))

names(answers) <- c("Answer","questions")
answers$'Test' <- answers$Answer[answers$questions == 'name_test']

# get rid of blank questions i.e. where no question added to form
answers <- answers[!answers$Answer == "",]

# add version number to test

     #  return(paste0("Version: ", testcounter))
     if (file.exists("testcounter.Rdata")){ load(file="testcounter.Rdata")
  answers$Test <- as.character(answers$Test)
  if (unique(unique(answers$Answer) %in% testcounter$name_test)){
    name_test <- as.character(unique(answers$Answer[answers$questions == 'name_test']))
     version <- unique(testcounter$Version[testcounter$name_test == name_test])
     testcounter$Version  <- version + 1
     save(testcounter, file="testcounter.Rdata")}
     if  (!unique(answers$Test) %in% testcounter){
       testcounter_update <- data.frame(c(1))
       testcounter_update$name_test <- as.character(unique(answers$Answer[answers$questions == 'name_test']))
       names(testcounter_update) <- c('Version','name_test')
       testcounter <- rbind(testcounter,testcounter_update)
     save(testcounter, file="testcounter.Rdata")
    }}

     if (!file.exists("testcounter.Rdata")){
       answers$Test <- as.character(answers$Test)
       testcounter <- data.frame(c(1))
       testcounter$name_test <- as.character(unique(answers$Answer[answers$questions == 'name_test']))
       names(testcounter) <- c('Version','name_test')
       save(testcounter,file="testcounter.Rdata")}
       save(testcounter, file="testcounter.Rdata")
      # return(paste0("Version: ", testcounter))

return(answers)

}
