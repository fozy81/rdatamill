# add another question


AddQuestion <- function() {


  return(list(
    div(
      id = "form", textInput("Question_test_2", label = h3("Add question")),

      selectInput("Input_type_2","Select input widget type",c("text box")),
      actionButton("New2","New Question"),
      conditionalPanel(
        condition = "input.New2 == '1'",
        textInput("Question_test_3", label = h3("Add question")),

        selectInput("Input_type_3","Select input widget type",c("text box")),
        actionButton("New3","New Question")))

      ))

}
