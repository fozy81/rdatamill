library(shiny)
library(rdatamill)
library(shinyjs)


#load(file="counter.Rdata")

shinyServer(function(input, output, session) {

  # create counter to add unique number to each record saved
  output$counter <- renderText({
    counters <- counter_test()
    return(paste0("Test count: ", counters))})

### this next bit create UI selectInput to pick from list of available tests -
### updates when new test created, after page refresh.
### This repeats three times! - But can't re-use same element on different tabs. Needs fixing!!

output$test_list_one <- renderUI({
  if(file.exists("testForm.csv")){
    getTestForms <- read.csv(file="testForm.csv")
    getTestForms$Test <- as.character(getTestForms$Test)
    getChoices2 <- unique(getTestForms$Test)
    getChoices2 <- setNames(getChoices2,getChoices2)
    getTestFunctions <- getChoices2
    getChoices3 <<- getChoices2
  }
  if(!file.exists("testForm.csv")){
    getChoices2 <- setNames("","")
    getTestFunctions <- getChoices2
    # combine all tests (in table and write into functions) so all tests can be selected:
    getChoices3 <- getChoices2
    getChoices3 <<-  getChoices2
  }
 ui <- selectInput("select_Test","Select test to update",getChoices3)
  return(ui)
})

output$test_list_two <- renderUI({
  if(file.exists("testForm.csv")){
    getTestForms <- read.csv(file="testForm.csv")
    getTestForms$Test <- as.character(getTestForms$Test)
    tests_name <<-    getTestForms$Test
    getChoices2 <- unique(getTestForms$Test)
    getChoices2 <- setNames(getChoices2,getChoices2)
    getTestFunctions <- getChoices2
    getChoices3 <<- getChoices2
    }
  if(!file.exists("testForm.csv")){
    tests_name <<-  ""
    getChoices2 <- setNames("","")
    getTestFunctions <- getChoices2
    getChoices3 <- getChoices2
  getChoices3 <<-  getChoices2
  }
  ui <- selectInput("Analysis","Select test to enter data",multiple= T,getChoices3)
  return(ui)
})

output$test_list_three <- renderUI({
  if(file.exists("testForm.csv")){
    getTestForms <- read.csv(file="testForm.csv")
    getTestForms$Test <- as.character(getTestForms$Test)
    tests_name <<-    getTestForms$Test
    getChoices2 <- unique(getTestForms$Test)
    getChoices2 <- setNames(getChoices2,getChoices2)
    getTestFunctions <- getChoices2
    getChoices3 <<- getChoices2
  }
  if(!file.exists("testForm.csv")){
    tests_name <<-  ""
    getChoices2 <- setNames("","")
    getTestFunctions <- getChoices2
    getChoices3 <- getChoices2
    getChoices3 <<-  getChoices2
  }
  ui <- selectInput("Analysis","Select test to upload data",getChoices3)
  return(ui)
})

output$test_list_four <- renderUI({
  if(file.exists("testForm.csv")){
    getTestForms <- read.csv(file="testForm.csv")
    getTestForms$Test <- as.character(getTestForms$Test)
    tests_name <<-    getTestForms$Test
    getChoices2 <- unique(getTestForms$Test)
    getChoices2 <- setNames(getChoices2,getChoices2)
    getTestFunctions <- getChoices2
    getChoices3 <<- getChoices2
  }
  if(!file.exists("testForm.csv")){
    tests_name <<-  ""
    getChoices2 <- setNames("","")
    getTestFunctions <- getChoices2
    getChoices3 <- getChoices2
    getChoices3 <<-  getChoices2
  }
  ui <- selectInput("Data_test","Select test data to validate",getChoices3)
  return(ui)
})


#       if (!file.exists("counter.Rdata"))
#         counter <<- 1
#       save(counter,file="counter.Rdata")
#       paste0("Hits: ", counter)
#       if (file.exists("counter.Rdata")) load(file="counter.Rdata")
#       counter <<- counter + 1
#
#       save(counter, file="counter.Rdata")
#       return(paste0("Sample count: ", counter))



# output the survey/test in the UI for data entry
  output$analysisUI <- renderUI({

         return(list(openTest(),saveButton()))

  })

  # output the 'update test' in the UI
  output$test_updateUI <- renderUI({
    # if statement no quite right - sometimes needs two clicks:
    if(input$edit_Test > input$create_new_Test ){
      return(list(updateTest(),saveTestButton()))}
    return()
  })

  # output the 'create a new' test in the UI
  output$testCreateUI <- renderUI({
    if(input$create_new_Test > input$edit_Test){
      return(list(createTest(),saveTestButton()))}
    return()
  })

  # upload data
  output$uploadDataUI <- renderUI({
  return(uploadData())
  })

# Make the input$ values global so answersDataFrame() function can access the answers

input <<- input

#creates a dataframe reactively for saveData function to save to file
answersDF <- reactive({
  answersDataFrame()
})

#creates a dataframe reactively for saveTest function to save to file
testDF <- reactive({
  testDataFrame()
})

#count number of samples saved and and increase by one each time data is saved.
counter_test <<- reactive({
 counter_t <- testCounter()
 return(counter_t)
})

#count number of tests saved and and increase by one each time data is saved.
counter_sample <<- reactive({
  counter_s <- sampleCounter()
  return(counter_s)
})

#make these functions global so that saveTest and saveData can find the dataframe to save to file:
testDF <<- testDF
answersDF  <<- answersDF

# Data validation table output:
output$result_table <- renderDataTable({

  dataMode <- read.csv(file='dataResults.csv')
  dataMode <- dataMode[dataMode$Mode == 'B' & dataMode$Test == input$Data_test,]
  return(dataMode)})

output$validate_table <- renderDataTable({

  dataMode <- read.csv(file='dataResults.csv')
  dataMode <- dataMode[dataMode$Mode == 'B' & dataMode$Test == input$Data_test,]
  # needs updating so different rules used for different verions:
  validation_name <<- paste('valid_',unique(dataMode$Test),'_',max(dataMode$Version),'.R',sep="")
  source(validation_name)
  dataMode <- as.data.frame(validation_rule(dataMode))
  return(dataMode)})

observeEvent(input$validate, {
  validateData()

})


   observeEvent(input$saveClick, {
      saveData()
     shinyjs::hide("form")
     shinyjs::hide("saveButton")
     shinyjs::show("thankyou_msg")
       })

   observeEvent(input$submit_another, {

     shinyjs::reset("form")
     shinyjs::show("form")
     shinyjs::show("saveButton")
     shinyjs::hide("thankyou_msg")

   })

   observeEvent(input$submit_finish, {
     counter <- counter_sample()
     counter <- counter + 1
     save(counter, file="sampleCounter.Rdata")
     shinyjs::reset("form")
     shinyjs::hide("form")
     shinyjs::hide("thankyou_msg")
   })

   observeEvent(input$testClick, {
     saveTest()
    createValidation()
      shinyjs::hide("form")
     shinyjs::hide("saveTest")
     shinyjs::show("another_test_msg")
   })

   observeEvent(input$submit_another_Test, {

     shinyjs::reset("form")
     shinyjs::show("form")
     shinyjs::show("saveTest")
     shinyjs::hide("another_test_msg")

   })



})
