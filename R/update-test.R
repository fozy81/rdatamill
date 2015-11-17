
# for updating test

update_test <- function(selected_tests=NULL){

  tests <- get_test()
  names <- names(tests)
  test <- t(data.frame(paste('update_',names,"",sep="")))
  colnames(test) <- names
  test <- data.frame(test)


  unit_types <- c("none", "metre","%","kg","mm")
  input_types <- c("text box","list","numeric")


   tests <- tests[tests$test == selected_tests,]
    tests <- tests[tests$version == max(tests$version),]

    test_output <- lapply(unique(tests$question_order),function(question_order){

        tests <- tests[tests$question_order == question_order,]

        question_order <-  sub("new","update",question_order)
return(
div(
  id = "form",
  if(question_order == "update_question_order1"){h3(tests$test)},

 if(question_order == "update_question_order1"){eval(checkboxInput("update_active", label = h4(" Test active for data entry?"), value = unique(tests$active)))},

 if(question_order == "update_question_order1"){eval(checkboxInput("update_multiple_results", label = h4(" Multiple results can be entered"), value = tests$multiple_results))},

  textInput(question_order, label = paste("Question ",tests$num,sep=""), value = tests$question),
selectInput(paste("update_types_",tests$num,sep=""),"Select input widget type",choices =   input_types, selected = tests$types),

conditionalPanel(
    condition = paste("input.update_types_",tests$num,"== 'list'",sep=""),
textInput(paste("update_list_",tests$num,sep=""), label = ('Add list of comma separated values'), value = tests$lists)),

  conditionalPanel(
    condition = paste("input.update_types_",tests$num,"  == 'numeric'",sep=""),
    numericInput(paste("update_max_",tests$num,sep=""), label = ('Max numeric values'), value=tests$max),numericInput(paste("update_min_",tests$num,sep=""), label = ('Min numeric values'),value=tests$min),numericInput(paste("update_step_",tests$num,sep=""), label = ('Step'),value=tests$step)),

  conditionalPanel(
    condition = paste("input.update_types_",tests$num,"  == 'numeric'",sep=""),
selectInput(paste("update_unit_",tests$num,sep=""),"Select unit type",choices = unit_types,selected = tests$unit)),
eval(checkboxInput(test$required, label = h4(" Answer mandatory?"), value = tests$required))


))
  })



return(list(test_output,eval(h5(paste("version:",max(tests$version),"",sep=""),hr()))))

}


