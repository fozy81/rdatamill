# Customer survey demo

testCustomerSurvey <- function(){

      return(list(
        div(
          id = "form",
        selectInput(inputId= "satisfaction",
                            "Is this R package useful?",
                            c("yes","no","maybe")),
                  selectInput("Where_you_hear",
                              "Where did you first hear about this package?",
                              c("R-blogs","Twitter","Web search")),
                  selectInput(inputId= "fixing",
                              "Can you fix the issue with the 'save' actionButton - so that it disappears when survey compeleted?",
                              c("yes","no","maybe"),selected = "yes"),
                   selectInput(inputId= "fix",
                                 "Can you fix the issue with the 'save' actionButton - so that it disappears when survey compeleted?",
                                c("yes","no","maybe")))
      ))
                  }








