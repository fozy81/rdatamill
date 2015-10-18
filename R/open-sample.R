
# for displaying samples in UI for data entry

open_sample <- function(){

inputSample <- input$sample_number
## inputTest <- input$test

open_Test <- lapply(inputSample, function(sample){
results <- read.csv(file="dataResults.csv")
results <- results[results$Sample_number == sample,]

results <- results[reuslts$Test %in% inputTest,]
#test_name <- unique(testForm$Test)
#test_active <-  unique(testForm$Active)

output <- lapply(unique(results$Result_Number),function(order){
# test order:
question <- as.character(results$Question[result$Result_Number == order])
# test questions
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

  Input_test_1 <-  testForm$types[testForm$Question_order == order]

submit_another <- input$submit_another
ifelse(input$submit_another > 0, first_result_entry <- FALSE,first_result_entry <- TRUE)
if(input$submit_another > 0){
  if( first_result_entry == testForm$multiple_results){
           return()
        }

  }



labelMandatory <- function(label) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

 return(list(
# if(order == "Question_test_1"){ paste("div(id = \"form\",")},
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


})

if(testForm$Active == FALSE){
output <- div(
  id = "form",
  h3("No active test available"))

}


return(list(c(output)))
})
return(list(open_Test))
}


