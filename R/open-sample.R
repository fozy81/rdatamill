
# for displaying samples in UI for data entry

open_sample <- function(sample_number,test=NULL){
check_stop <- "check"
#sample_number <- sample_number
open_test <- lapply(unique(sample_number), function(sample){
results <- read.csv(file="results.csv")
results <- results[results$sample_number == sample,]

if(!is.null(test)){
results <- results[results$test %in% test,]}
# split results by unique question(s) only
#results <- results[unique(results$question),]

output <- lapply(unique(results$result_number),function(order){

results <- results[results$result_number == order,]

# question
label <- as.character(results$question[results$result_number == order])
# result
result <- as.character(results$result[results$result_number == order])
#test name
test <- as.character(results$test[results$result_number == order])

test_form <- get_test()
test_form <-test_form[test_form$test == results$test & test_form$version == results$version,]
test_form <- test_form[test_form$question == results$question,]

question <- as.character(test_form$question_order_name[test_form$question == label])

   List_test_1 <- as.character(test_form$lists)
  if(length(List_test_1) == 0L){
    List_test_1 <- ""
  }
  if(length(List_test_1) != 0L){
    List_test_1 <- strsplit(List_test_1 , ",")
    names(List_test_1) <-  List_test_1}

   min_test_1 <- as.numeric(test_form$min)
   if(length(min_test_1) == 0L){
     min_test_1 <- 0
   }

   max_test_1 <- as.numeric(test_form$max)
   if(length(max_test_1) == 0L){
     max_test_1 <- 0
   }
   step_test_1 <- as.numeric(test_form$step)
   if(length(step_test_1) == 0L){
     step_test_1 <- 0
   }

 # Input_test_1 <-  test_form$types

  # check to see if entry submitted and only render test if multiple entries allowed:
  # input$submit_another should be argument?
submit_another <- input$submit_another
ifelse(input$submit_another > 0, first_result_entry <- FALSE,first_result_entry <- TRUE)
if(input$submit_another > 0){
  if( first_result_entry == test_form$multiple_results){
           return()
        }

  }
   if (try(is.null(input$submit_another)))
      return()
if(input$submit_another > 0){

  result <- NULL
}
fields_mandatory <- test_form$question[test_form$required == T]


labelMandatory <- function(fields_mandatory) {
  tagList(
    label,
    span("*", class = "mandatory_star")
  )
}

if(length(fields_mandatory) != 0){

  label <- labelMandatory(label)
}

if(test_form$active == FALSE){
  output <- div(
    id = "form",
   return(h3("No active test available")))

}


 return(list(

if(test_form$question_order == "question_test_1"){eval(h3(results$test))},
 #  eval(h3(test)),
if(order == "question_test_1"){eval(h5(paste("version:",test_max,"",sep="")))},

if(test_form$types == 'text box'){
textInput(question, label = label, value=result)},
if(test_form$types == 'list'){
selectInput(question ,label = label,choices = c(List_test_1), selected = result)},
if(test_form$types == 'numeric'){
  sliderInput(question,label = label, value = result, min = min_test_1,max = max_test_1, step = step_test_1)}

))
})

return(list(c(output)))
})
return(list(open_test,eval(h5(paste("Sample Number:",unique(sample_number),"",sep="")))))
}


