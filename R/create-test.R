# Create test
#
# Special test for creating tests


create_test <- function() {

# bit of the test creation UI that gets repeated lots of times for each question:
 create_test_ui <- lapply(2:25, function(x){

   conditionalPanel(
    condition = paste("input.New_",x,"%'2'",sep=""),
    textInput(paste("Question_test_",x,"",sep=""), label = h3(paste("Add question ",x,"",sep=""))),
    conditionalPanel(
    condition = paste("input.New_",x," >= '1'",sep=""),
       selectInput(paste("Input_type_",x,"",sep=""),"Select input widget type",c("text box","list","numeric"),selected="text box")),
    conditionalPanel(
     condition = paste("input.Input_type_",x," == 'list'",sep=""),
        textInput(paste("List_",x,"",sep=""), label = ("Add list of comma separated values"))),
   conditionalPanel(
      condition = paste("input.Input_type_",x," == 'numeric'",sep=""),
      numericInput(paste("max_",x,"",sep=""), label = ('Max numeric values'), value=0),numericInput(paste("min_",x,"",sep=""), label = ('Min numeric values'),value=0),numericInput(paste("step_",x,"",sep=""), label = ('Step'),value=0),
     selectInput(paste("Input_unit_",x,"",sep=""),"Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
   checkboxInput(paste("required_",x,"",sep=""), label = h4("Answer mandatory?"), value = F),
   actionButton(paste("New_",x+1,"",sep=""),"New Question"))

})

 create_test <-  list(create_test_ui)

# start of the test creation which doesn't get repeated:
return(list(
  div(
    id = "form",
    textInput("name_test", label = h3("Add Test name")),
    textInput("Question_test_1", label = h3("Add question 1")),
    selectInput("Input_type_1","Select input widget type",c("text box","list","numeric"),selected="text box"),
    conditionalPanel(
      condition = "input.Input_type_1 == 'list'",
      textInput("List_1", label = ('Add list of comma separated values'))),
    conditionalPanel(
      condition = "input.Input_type_1 == 'numeric'",
      numericInput("max_1", label = ('Max numeric values'), value=0),numericInput("min_1", label = ('Min numeric values'),value=0),numericInput("step_1", label = ('Step'),value=0),
      selectInput("Input_unit_1","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
    checkboxInput("required_1", label = h4("Answer mandatory?"), value = F),
    actionButton("New_2","New Question"),

    # insert the bit which does get repeat:
    create_test,

# end of the test creation which doesn't get repeated:
    h3('Advanced options'),
    checkboxInput("check_box_test", label = h4(" Test active for data entry?"), value = TRUE),
    #     checkboxInput("check_validation_function", label = h4(" Create boiler-plate validation function to add more complex validation rules to?"), value = FALSE),
    checkboxInput("multiple_results_test", label = h4("Allow multiple results to be entered per sample"), value = FALSE),
    hr())))

}



