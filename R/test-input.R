# creates dataframe of test editing input

test_input <- function() {

all_input_values <- names(input)

# input values from shiny GUI include active button, text boxes etc from all the
# html widgets (in all panels/tabs within app). We only want to keep inputs
# from the form itself:

questions <- grep(pattern ='_test',all_input_values, value=T)


answers <- lapply(questions,function(question){
  answer <- eval(parse(text=paste("input$",question,sep="")))
  return(answer)
})

answers <- data.frame(do.call("rbind", answers))


# get answers about list - this becomes a separate column in the dataframe
lists <- grep(pattern ='List',all_input_values, value=T)

lists <- lapply(lists,function(list){
  list <- eval(parse(text=paste("input$",list,sep="")))
  return(list)
})

lists <- data.frame(do.call("rbind", lists))
names(lists) <- "lists"


# get answers about types of list input arguments - - this becomes a separate column in the dataframe
types <- grep(pattern ='_type',all_input_values, value=T)

types <- lapply(types,function(type){
  answer <- eval(parse(text=paste("input$",type,sep="")))
  return(answer)
})


types <- data.frame(do.call("rbind", types))
names(types) <- "types"

# get answers about numeric input arguments

maxis <- grep(pattern ='max',all_input_values, value=T)

maxis <- lapply(maxis,function(maxi){
 maxi <- eval(parse(text=paste("input$",maxi,sep="")))
  return(maxi)
})

maxis <- data.frame(do.call("rbind", maxis))
names(maxis) <- c("max")

minis <- grep(pattern ='min',all_input_values, value=T)

minis <- lapply(minis,function(mini){
 mini <- eval(parse(text=paste("input$",mini,sep="")))
  return(mini)
})

minis <- data.frame(do.call("rbind", minis))
names(minis) <- c("min")

steps <- grep(pattern ='step',all_input_values, value=T)

steps <- lapply(steps,function(step){
  step <- eval(parse(text=paste("input$",step,sep="")))
  return(step)
})

steps <- data.frame(do.call("rbind", steps))
names(steps) <- c("step")

# get answers about units input arguments - - this becomes a separate column in the dataframe
unit_types <- grep(pattern = '_unit',all_input_values, value=T)

unit_types <- lapply(unit_types,function(unit_type){
  unit_type <- eval(parse(text=paste("input$",unit_type,sep="")))
   return(unit_type)
})

unit_types <- data.frame(do.call("rbind", unit_types))
names(unit_types) <- "unit"

# get answers about mandatory input arguments - - this becomes a separate column in the dataframe
required <- grep(pattern = 'mandatory_',all_input_values, value=T)

required <- lapply(required,function(required1){
  required1 <- eval(parse(text=paste("input$",required1,sep="")))
  return(required1)
})

required <- data.frame(do.call("rbind", required))
names(required) <- "Required"


questions <- data.frame(questions)
names(questions) <- "Questions"
answers <- data.frame(cbind(answers,questions))
names(answers) <- c("Answer","questions")

answers$'Test' <- as.character(unique(answers$Answer[answers$questions == 'name_test']))

#remove test name as question
answers <- answers[!answers$questions == 'name_test',]

# save the checkbox for if test is active for data entry or not:

answers$'Active' <- as.character(answers$Answer[answers$questions == 'check_box_test'])
answers <- answers[!answers$questions == 'check_box_test',]


answers$'multiple_results' <- as.character(answers$Answer[answers$questions == 'multiple_results_test'])
answers <- answers[!answers$questions == 'multiple_results_test',]

answers <- data.frame(cbind(answers,types))
answers <- data.frame(cbind(answers,lists))
answers <- data.frame(cbind(answers,maxis))
answers <- data.frame(cbind(answers,minis))
answers <- data.frame(cbind(answers,steps))
answers <- data.frame(cbind(answers,unit_types))
answers <- data.frame(cbind(answers,required))
answers <- answers[!answers$Answer == "",]

# crete some extra column of useful info - may add more or develop further in future
answers$'Date_created' <- Sys.time()
#answers$'Required' <- ""
answers$'constraint_message' <- ""
answers$Hint <- ""
# test if can add name to Question_test_1 et so that multiple results for the same question can be returned in the same sample
answers$Question_order_name <- paste(answers$questions,answers$Answer,sep="")
#answers$questions <- NULL

names(answers) <- c('Question','Question_order','Test', 'Active','multiple_results','types','lists','max','min','step','unit','required','Date_created','constraint_message','Hint','Question_order_name')
#answers$'Active' <- answers$Answer[answers$questions == 'check_box_test']


# get rid of blank questions i.e. where no question added to form
#answers <- answers[!answers$Answer == "",]
#answers <<- answers
return(answers)

}
