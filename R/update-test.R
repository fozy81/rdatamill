
# for updating test

update_test <- function(selected_tests=NULL){

tests <- get_test()
tests <- tests[tests$test == selected_tests,]
# open the most recent version of the test:
tests <- tests[tests$version == max(tests$version),]

  test_output <- lapply(unique(tests$question_order),function(order){

    test_question_1 <- as.character(tests$question[tests$question_order == order])

    num <- as.character(tests$num[tests$question_order == order])

    List_test_1 <- as.character(tests$lists[tests$question_order == order])
    if(length(List_test_1) == 0L){
      List_test_1 <- ""
    }

    max_test_1 <- as.character(tests$max[tests$question_order == order])
    if(length(max_test_1) == 0L){
      List_test_1 <- ""
    }

    min_test_1 <- as.character(tests$min[tests$question_order == order])
    if(length( min_test_1) == 0L){
      List_test_1 <- ""
    }
    step_test_1 <- as.character(tests$step[tests$question_order == order])
    if(length(step_test_1) == 0L){
      List_test_1 <- ""
    }

    unit_test_1 <- as.character(tests$unit[tests$question_order == order])
    if(length(unit_test_1) == 0L){
      List_test_1 <- ""
    }

    multiple_test_1 <- tests$multiple_results[tests$question_order == order]
    if(length(multiple_test_1) == 0L){
      List_test_1 <- ""
    }

    required_test_1 <- tests$required[tests$question_order == order]
    if(length(required_test_1) == 0L){
      List_test_1 <- ""
    }

    Input_test_1 <-  tests$types[tests$question_order == order]
    if(Input_test_1 == 'text box')
      input_type_test_1_2 <- 'textInput'


order2 <- sub("test","type",order)
required <- sub("test","required",order)

return(
div(
  id = "form",
  if(order == "Question_test_1"){eval(textInput("name_test", label = 'Test', value = unique(tests$test)))},

 if(order == "Question_test_1"){eval(checkboxInput("check_box_test", label = h4(" Test active for data entry?"), value = unique(tests$active)))},

 if(order == "Question_test_1"){eval(checkboxInput("multiple_results_test", label = h4(" Multiple results can be entered"), value = multiple_test_1))},
# textInput("name_test", label = 'test', value = unique(tests$test)),

  textInput(order, label = order, value = test_question_1),
selectInput(order2,"Select input widget type",choices = c("text box","list","numeric"), selected =  Input_test_1),

conditionalPanel(
    condition = paste("input.Question_type_",num,"  == 'list'",sep=""),
textInput("List_1", label = ('Add list of comma separated values'), value = List_test_1)),

  conditionalPanel(
    condition = paste("input.Question_type_",num,"  == 'numeric'",sep=""),
    numericInput("max_2", label = ('Max numeric values'), value=max_test_1 ),numericInput("min_2", label = ('Min numeric values'),value=min_test_1 ),numericInput("step_2", label = ('Step'),value=step_test_1)),

  conditionalPanel(
    condition = paste("input.Question_type_",num,"  == 'numeric'",sep=""),
selectInput("unit_2","Select unit type",choices = c("none", "metre","%","kg","mm"),selected = unit_test_1)),
eval(checkboxInput(required, label = h4(" Answer mandatory?"), value = required_test_1))



))
  })

return(list(test_output,eval(h5(paste("version:",max(tests$version),"",sep=""),hr()))))

}


