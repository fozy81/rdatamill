
# for displaying test in UI for data entry

listTest <- function(){


  if(file.exists("testForm.csv")){
      getTestForms <- read.csv(file="testForm.csv")
      getTestForms$Test <- as.character(getTestForms$Test)
      getChoices2 <- unique(getTestForms$Test)
      getChoices2 <- setNames(getChoices2,getChoices2)
      getTestFunctions <- getChoices2
      getChoices3 <- getChoices2
      return(getChoices3)
    }
    if(!file.exists("testForm.csv")){
      getChoices2 <- setNames("","")
      getTestFunctions <<- getChoices2
      # combine all tests (in table and write into functions) so all tests can be selected:
      getChoices3 <- getChoices2
      return(getChoices3)
    }


  }

