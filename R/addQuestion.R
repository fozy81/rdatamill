
# NOT IN USE - currently not using this
# add another question


addQuestion <- function() {

#id = "form"
  return(list(
    div(
      textInput("Question_test_2", label = h3("Add question 2")),

      selectInput("Input_type_2","Select input widget type",c("text box","list"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_2 == 'list'",
        textInput("List_2", label = ('Add list of comma separated values'))),

      actionButton("New2","New Question"),
      conditionalPanel(
        condition = "input.New2 == '1'",
        textInput("Question_test_3", label = h3("Add question 3")),
        selectInput("Input_type_3","Select input widget type",c("text box","list"),selected="text box"),
        conditionalPanel(
          condition = "input.Input_type_3 == 'list'",
          textInput("List_3", label = ('Add list of comma separated values'))),

        actionButton("New3","New Question"),
        conditionalPanel(
          condition = "input.New3 == '1'",
          textInput("Question_test_4", label = h3("Add question 4"))),
          selectInput("Input_type_4","Select input widget type",c("text box","list"),selected="text box"),
          conditionalPanel(
            condition = "input.Input_type_4 == 'list'",
            textInput("List_4", label = ('Add list of comma separated values')))
        )

      )))

}
