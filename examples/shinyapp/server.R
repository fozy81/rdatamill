library(shiny)
library(rdatamill)


saveCount <<- 1
shinyServer(function(input, output, session) {

  output$counter <-
    renderText({
      if (!file.exists("counter.Rdata"))
        counter <- 0
      save(counter,file="counter.Rdata")
      paste0("Hits: ", counter)
      if (file.exists("counter.Rdata")) load(file="counter.Rdata")
      counter <- counter <<- counter + 1

      save(counter, file="counter.Rdata")
      paste0("Hits: ", counter)
    })



inputSave <- reactive({

    return(input$saveClick)

  })

  output$analysisUI <- renderUI({
    UI()
  })

UI <- reactive({
  if(saveCount == 1){
return(list(eval(parse(text=paste(input$Analysis,"()",sep=""))),saveButton()))
  }
    if(saveCount == 2){
      return(list(eval(parse(text=paste(input$Analysis,"()",sep=""))),finishButton()))
    }

    })



# Make the input$ values global so answersDataFrame() function can access the answers
input <<- input

  answersDF <- reactive({

    answersDataFrame()

  })

# Make the answerDF values global so saveData() function can access the answersDF
  answersDF <<-  answersDF

   observeEvent(input$saveClick, {

     return(saveData())

     })

})
