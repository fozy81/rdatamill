# Create test
#
# Special test for creating tests


create_test <- function() {


  test <- data.frame("new_question","new_question_order","new_types","new_lists","new_min","new_max","new_step","new_unit","new_required","new_active","new_multiple_results","new_test")
  names(test) <- c("question","question_order","new_types","lists","min","max","step","unit","required","active","multiple_results","test")

  if(file.exists("test.csv")){
  test <- get_test()
  names <- names(test)
  test <- t(data.frame(paste('new_',names,"",sep="")))
  colnames(test) <- names
  test <- data.frame(test)}


  unit_types <- c("none", "metre","%","kg","mm")
  input_types <- c("text box","list","numeric")


# bit of the test creation UI that gets repeated lots of times for each question:
 create_test_ui <- lapply(2:25, function(x){

   conditionalPanel(
    condition = paste("input.New_",x,"%'2'",sep=""),
    textInput(paste(test$question_order,x,"",sep=""), label = h3(paste("Add question ",x,"",sep=""))),
    conditionalPanel(
    condition = paste("input.New_",x," >= '1'",sep=""),
       selectInput(paste("new_types",x,"",sep=""),"Select input widget type",input_types,selected="text box")),
    conditionalPanel(
     condition = paste("input.new_types",x," == 'list'",sep=""),
        textInput(paste(test$lists,x,"",sep=""), label = ("Add list of comma separated values"))),
   conditionalPanel(
     condition = paste("input.new_types",x," == 'numeric'",sep=""),
      numericInput(paste(test$max,x,"",sep=""), label = ('Max numeric values'), value=0),
     numericInput(paste(test$min,x,"",sep=""), label = ('Min numeric values'),value=0),
     numericInput(paste(test$step,x,"",sep=""), label = ('Step'),value=0),
     selectInput(paste(test$unit,x,"",sep=""),"Select unit type",unit_types,selected="none")),
   checkboxInput(paste(test$required,x,"",sep=""), label = h4("Answer mandatory?"), value = F),
   actionButton(paste("New_",x+1,"",sep=""),"New Question"))

})

 create_test <-  list(create_test_ui)

# start of the test creation which doesn't get repeated:
return(list(
  div(
    id = "form",
    textInput(test$test, label = list(h3("Add Form name"),h5("Please don't use special characters in Form name (*?!) etc"))),
    textInput(paste(test$question_order,"1",sep=""), label = h3("Add question 1")),
    selectInput("new_types1","Select input widget type",c("text box","list","numeric"),selected="text box"),
    conditionalPanel(
      condition = "input.new_types1 == 'list'",
      textInput(paste(test$lists,"1",sep=""), label = ('Add list of comma separated values'))),
    conditionalPanel(
      condition = "input.new_types1 == 'numeric'",
      numericInput(paste(test$max,"1",sep=""), label = ('Max numeric values'), value=0),numericInput(paste(test$min,"1",sep=""), label = ('Min numeric values'),value=0),numericInput(paste(test$step,"1",sep=""), label = ('Step'),value=0),
      selectInput(paste(test$unit,"1",sep=""),"Select unit type",unit_types,selected="none")),
    checkboxInput(paste(test$required,"1",sep=""), label = h4("Answer mandatory?"), value = F),
    actionButton("New_2","New Question"),

    # insert the bit which does get repeat:
    create_test,

# end of the test creation which doesn't get repeated:
    h3('Advanced options'),
    checkboxInput(paste(test$active,"1",sep=""), label = h4(" Test active for data entry?"), value = TRUE),
    #     checkboxInput("check_validation_function", label = h4(" Create boiler-plate validation function to add more complex validation rules to?"), value = FALSE),
    checkboxInput(paste(test$multiple_results,"1",sep=""), label = h4("Allow multiple results to be entered per sample"), value = FALSE),
    hr())))

}



