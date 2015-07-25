# Create test
#
# Special test for creating tests


Create <- function() {



return(list(
    div(
      id = "form",
      textInput("name_test", label = h3("Add Test name")),
      textInput("Question_test_1", label = h3("Add question")),

      selectInput("Input_type_test_1","Select input widget type",c("text box","list")),

      actionButton("New","New Question"),
                        conditionalPanel(
                                condition = "input.New == '1'",
                                AddQuestion())),
  hr()))


}

