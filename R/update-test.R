
# for updating test

update_test <- function(){

testForm <- read.csv(file="testForm.csv")
inputTest <- input$selected_test_1
testForm <- testForm[testForm$Test == inputTest,]
test_max <- max(testForm$Version)
testForm <- testForm[testForm$Version == test_max,]
test_name <- unique(testForm$Test)
test_active <-  unique(testForm$Active)



if(unique(testForm$Active) == TRUE){
  output <- lapply(unique(testForm$Question_order),function(order){

    test_question_1 <- as.character(testForm$Question[testForm$Question_order == order])

    List_test_1 <- as.character(testForm$lists[testForm$Question_order == order])
    if(length(List_test_1) == 0L){
      List_test_1 <- ""
    }

    max_test_1 <- as.character(testForm$max[testForm$Question_order == order])
    if(length(List_test_1) == 0L){
      List_test_1 <- ""
    }

    min_test_1 <- as.character(testForm$min[testForm$Question_order == order])
    if(length(List_test_1) == 0L){
      List_test_1 <- ""
    }
    step_test_1 <- as.character(testForm$step[testForm$Question_order == order])
    if(length(List_test_1) == 0L){
      List_test_1 <- ""
    }

    Input_test_1 <-  testForm$types[testForm$Question_order == order]
    if(Input_test_1 == 'text box')
      input_type_test_1_2 <- 'textInput'


order2 <- sub("test","type",order)

return(
div(
  id = "form",
  if(order == "Question_test_1"){eval(textInput("name_test", label = 'Test', value = test_name))},

 if(order == "Question_test_1"){eval(checkboxInput("check_box_test", label = h4(" Test active for data entry?"), value = test_active))},


#  textInput("name_test", label = 'Test', value = test_name),

  textInput(order, label = order, value = test_question_1),
selectInput(order2,"Select input widget type",choices = c("text box","list","numeric"), selected =  Input_test_1),
if(order2 == 'Question_type_1'){
conditionalPanel(
    condition = "input.Question_type_1  == 'list'",
textInput("List_1", label = ('Add list of comma separated values'), value = List_test_1))},
if(order2 == 'Question_type_1'){
  conditionalPanel(
    condition = "input.Question_type_1  == 'numeric'",
    numericInput("max_2", label = ('Max numeric values'), value=max_test_1 ),numericInput("min_2", label = ('Min numeric values'),value=min_test_1 ),numericInput("step_2", label = ('Step'),value=step_test_1))},
if(order2 == 'Question_type_2'){conditionalPanel(
       condition = "input.Question_type_2 == 'list'",
   textInput("List_2", label = ('Add list of comma separated values'), value = List_test_1))},
if(order2 == 'Question_type_2'){
  conditionalPanel(
    condition = "input.Question_type_2  == 'numeric'",
    numericInput("max_3", label = ('Max numeric values'), value=max_test_1 ),numericInput("min_3", label = ('Min numeric values'),value=min_test_1 ),numericInput("step_3", label = ('Step'),value=step_test_1))},
h5(paste("Version:",test_max,"",sep=""))
))
  })

return(output)}
}


