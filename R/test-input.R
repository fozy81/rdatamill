# creates dataframe of test editing inputs

# need argument to change if receiving new test or updating old test. Create new test inputs should be distinct from old test inputs names?

test_input <- function(update=NULL,new=NULL) {

  all_input_values <- names(input)

  if(update==T){
    tests <- get_test()
    variables <- names(tests)
    values <- lapply(variables,function(x){

   if(is.null(input[[x]])){
     return("FALSE")}

    else{ return(input[[x]])}
    }
    )}


  if(update==F){
    variables <- c("n_test","_type","List","min","max","step","unit","required")
    values <- lapply(variables,function(x){
      test_name <- grep(pattern=x,all_input_values, value=T)
     value <- lapply(test_name, function(test_name){

        value <- input[[test_name]]
            if(length(value)==0){
        value <- data.frame("")
      }
    else value <- data.frame(value)
    })
     value <- data.frame(do.call("rbind", value))
     return(value)

     })
  answers <- data.frame(do.call("cbind", values))
  names(answers) <- c("question", "types", "lists", "max", "min", "step","unit","required")
  answers$question_order <-  grep(pattern="n_test",all_input_values, value=T)
    # crete some extra column of useful info - may add more or develop further in future
  answers$'date_created' <- Sys.time()
  answers$'constraint_message' <- ""
  answers$hint <- ""
  # test if can add name to question_test_1 et so that multiple results for the same question can be returned in the same sample
  answers$'active' <- as.character(input$check_box_test)
  # name of test
  answers$test <- input$name_test
  answers$'multiple_results' <- as.character(input$multiple_results_test)
  answers <- answers[!answers$question == "",]
  row.names(answers) <- NULL
  answers$num <- row.names(answers)
  answers$question_order_name <- paste(answers$question,answers$'test',answers$num,sep="")
    answers <- answers[,c('question','question_order','test', 'active','multiple_results','types','lists','max','min','step','unit','required','date_created','constraint_message','hint','num','question_order_name')]

return(answers)
}

# input values from shiny GUI include active button, text boxes etc from all the
# html widgets (in all panels/tabs within app). We only want to keep inputs
# from the form itself:

questions <- grep(pattern ='n_test',all_input_values, value=T)


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
if(length(lists)==0){
  lists <- data.frame("")
}
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
if(length(maxis)==0){
  maxis <- data.frame("")
}
names(maxis) <- c("max")

minis <- grep(pattern ='min',all_input_values, value=T)

minis <- lapply(minis,function(mini){
 mini <- eval(parse(text=paste("input$",mini,sep="")))
  return(mini)
})

minis <- data.frame(do.call("rbind", minis))
if(length(minis)==0){
  minis <- data.frame("")
}
names(minis) <- c("min")

steps <- grep(pattern ='step',all_input_values, value=T)

steps <- lapply(steps,function(step){
  step <- eval(parse(text=paste("input$",step,sep="")))
  return(step)
})

steps <- data.frame(do.call("rbind", steps))
if(length(steps)==0){
  steps <- data.frame("")
}
names(steps) <- c("step")

# get answers about units input arguments - - this becomes a separate column in the dataframe
unit_types <- grep(pattern = 'unit',all_input_values, value=T)

unit_types <- lapply(unit_types,function(unit_type){
  unit_type <- eval(parse(text=paste("input$",unit_type,sep="")))
   return(unit_type)
})

unit_types <- data.frame(do.call("rbind", unit_types))
if(length(unit_types)==0){
 unit_types <- data.frame("")
}
names(unit_types) <- "unit"

# get answers about mandatory input arguments - - this becomes a separate column in the dataframe

 required <- grep(pattern = 'required_',all_input_values, value=T)
required <- lapply(required,function(required1){
  required1 <- eval(parse(text=paste("input$",required1,sep="")))
  return(required1)
})

required <- data.frame(do.call("rbind", required))
names(required) <- "required"


questions <- data.frame(questions)
names(questions) <- "questions"
answers <- data.frame(cbind(answers,questions))
names(answers) <- c("answer","questions")

answers$'test' <- as.character(input$tests_to_edit)

#remove test name as question
answers <- answers[!answers$questions == 'test',]

# save the checkbox for if test is active for data entry or not:

answers$'active' <- as.character(input$check_box_test)
answers <- answers[!answers$questions == 'check_box_test',]


answers$'multiple_results' <- as.character(input$multiple_results_test)
answers <- answers[!answers$questions == 'multiple_result_test',]

answers <- data.frame(cbind(answers,types))
answers <- data.frame(cbind(answers,lists))
answers <- data.frame(cbind(answers,maxis))
answers <- data.frame(cbind(answers,minis))
answers <- data.frame(cbind(answers,steps))
answers <- data.frame(cbind(answers,unit_types))
answers <- data.frame(cbind(answers,required))
answers <- answers[!answers$answer == "",]

# crete some extra column of useful info - may add more or develop further in future
answers$'date_created' <- Sys.time()
#answers$'Required' <- ""
answers$'constraint_message' <- ""
answers$hint <- ""
# test if can add name to question_test_1 et so that multiple results for the same question can be returned in the same sample

answers$num <- row.names(answers)
answers$question_order_name <- paste(answers$questions,answers$'test',answers$num,sep="")
#answers$questions <- NULL

names(answers) <- c('question','question_order','test', 'active','multiple_results','types','lists','max','min','step','unit','required','date_created','constraint_message','hint','num','question_order_name')
#answers$'active' <- answers$Answer[answers$questions == 'check_box_test']


# get rid of blank questions i.e. where no question added to form
#answers <- answers[!answers$Answer == "",]
#answers <<- answers
return(answers)

}
