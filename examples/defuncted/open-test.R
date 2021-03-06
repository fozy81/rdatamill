# defuncted?
# for displaying test in UI for data entry

open_test <- function(){

inputTest <- input$selected_test_2


open_Test <- lapply(inputTest, function(test){
testForm <- read.csv(file="testForm.csv")
testForm <- testForm[testForm$Test == test,]
test_max <- max(testForm$Version)
testForm <- testForm[testForm$Version == test_max,]
test_name <- unique(testForm$Test)
test_active <-  unique(testForm$Active)


if(unique(testForm$Active) == TRUE){
output <- lapply(unique(testForm$Question_order),function(order){
# test order:
test_question_1 <- as.character(testForm$Question[testForm$Question_order == order])
# test questions:
name_question_1 <- as.character(testForm$Question_order_name[testForm$Question_order == order])
# test questions:
#name_question_1 <<- sub(test_question_1,"",name_question_1)

   List_test_1 <- as.character(testForm$lists[testForm$Question_order == order])
  if(length(List_test_1) == 0L){
    List_test_1 <- ""
  }
  if(length(List_test_1) != 0L){
    List_test_1 <- strsplit(List_test_1 , ",")
    names(List_test_1) <-  List_test_1}

   min_test_1 <- as.numeric(testForm$min[testForm$Question_order == order])
   if(length(min_test_1) == 0L){
     min_test_1 <- 0
   }

   max_test_1 <- as.numeric(testForm$max[testForm$Question_order == order])
   if(length(max_test_1) == 0L){
     max_test_1 <- 0
   }
   step_test_1 <- as.numeric(testForm$step[testForm$Question_order == order])
   if(length(step_test_1) == 0L){
     step_test_1 <- 0
   }

#    unit_test_1 <- as.character(testForm$step[testForm$Question_order == order])
#    if(length(unit_test_1 ) == 0L){
#      unit_test_1  <- ""
#    }

  Input_test_1 <-  testForm$types[testForm$Question_order == order]

  ### check if multiple tests can be entered per sample - if not return nothing
submit_another <- input$submit_another
ifelse(input$submit_another > 0, first_result_entry <- FALSE,first_result_entry <- TRUE)
if(input$submit_another > 0){
  if( first_result_entry == testForm$multiple_results){

           return(h3('no more results can be entered'))
        }

  }



labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

 return(list(
 #  shinyjs::useShinyjs(),
 if(order == "Question_test_1"){div(id = "form")},
if(order == "Question_test_1"){eval(h3(test))},

if(order == "Question_test_1"){eval(h5(paste("Version:",test_max,"",sep="")))},

if(Input_test_1== 'text box'){
textInput(name_question_1, label = test_question_1)},
if(Input_test_1== 'list'){
selectInput(name_question_1 ,label = test_question_1,choices = c(List_test_1))},
if(Input_test_1== 'numeric'){
  sliderInput(name_question_1 ,label = test_question_1, value = 0, min = min_test_1,max = max_test_1, step = step_test_1)}
)
)


})}

if(testForm$Active == FALSE){
output <- div(
  id = "form",
  h3("No active test available"))

}


return(list(c(output)))
})
return(open_Test)
}


