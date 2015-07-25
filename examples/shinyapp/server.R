library(shiny)
library(rdatamill)
library(shinyjs)


load(file="counter.Rdata")

shinyServer(function(input, output, session) {

  # create counter to add unique number to each record saved
  output$counter <- renderText({
      if (!file.exists("counter.Rdata"))
        counter <- 0
      save(counter,file="counter.Rdata")
      paste0("Hits: ", counter)
      if (file.exists("counter.Rdata")) load(file="counter.Rdata")
      counter <- counter <<- counter + 1

      save(counter, file="counter.Rdata")
      return(paste0("Hits: ", counter))
    })


# output the survey/test in the UI
  output$analysisUI <- renderUI({
    UI()
  })

  # output the update in the UI
  output$test_update <- renderUI({
    test_edit()
  })

  # output the create in the UI
  output$testCreateUI <- renderUI({
    tCreate()
  })

  test_edit <- reactive({

   updateTest()


  })
  # load the test/survey based on the one selected
# testClick <- reactive({
#   if(!is.null(input$testClick)){
#   return(testclickstuff <- input$testClick)}
# })
#
# testClick  <<- testClick




 tCreate <- reactive({


      return(list(Create(),saveTestButton()))


  })


  UI <- reactive({

  if(input$Analysis == "testCreate"){

    return(list(eval(parse(text=paste(input$Analysis,"()",sep=""))),saveTestButton()))

  }


return(list(eval(parse(text=paste(input$Analysis,"()",sep=""))),saveButton()))

     })


# Make the input$ values global so answersDataFrame() function can access the answers

input <<- input

answersDF <- reactive({

  answersDataFrame()

})


testDF <- reactive({

  testDataFrame()

})

testDF <<- testDF
answersDF  <<- answersDF

# validiation table

output$table <- renderDataTable({

  dataMode <- read.csv(file='dataResults.csv')
  dataMode <- dataMode[dataMode$Mode == 'B' & dataMode$Test == input$Test,]
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

   observeEvent(input$testClick, {
     saveTest()
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
