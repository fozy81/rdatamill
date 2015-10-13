# Create test
#
# Special test for creating tests


createTest <- function() {



return(list(
    div(
      id = "form",
      textInput("name_test", label = h3("Add Test name")),

      textInput("Question_test_1", label = h3("Add question 1")),

      selectInput("Input_type_1","Select input widget type",c("text box","list","numeric"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_1 == 'list'",
        textInput("List_1", label = ('Add list of comma separated values'))),
         conditionalPanel(
        condition = "input.Input_type_1 == 'numeric'",
        numericInput("max_1", label = ('Max numeric values'), value=0),numericInput("min_1", label = ('Min numeric values'),value=0),numericInput("step_1", label = ('Step'),value=0)),
      actionButton("New_2","New Question"),
      conditionalPanel(
        condition = "input.New_2 == '1'",
        textInput("Question_test_2", label = h3("Add question 2")),
        conditionalPanel(
          condition = "input.New_2 == '1'",
        selectInput("Input_type_2","Select input widget type",c("text box","list","numeric"),selected="text box")),
        conditionalPanel(
          condition = "input.Input_type_2 == 'list'",
          textInput("List_2", label = ('Add list of comma separated values'))),
        conditionalPanel(
          condition = "input.Input_type_2 == 'numeric'",
          numericInput("max_2", label = ('Max numeric values'), value=0),numericInput("min_2", label = ('Min numeric values'),value=0),numericInput("step_2", label = ('Step'),value=0)),
         actionButton("New_3","New Question"),
      conditionalPanel(
        condition = "input.New_3 == '1'",
        textInput("Question_test_3", label = h3("Add question 3"))),
      conditionalPanel(
        condition = "input.New_3 == '1'",
        selectInput("Input_type_3","Select input widget type",c("text box","list","numeric"),selected="text box")),
        conditionalPanel(
          condition = "input.Input_type_3 == 'list'",
          textInput("List_3", label = ('Add list of comma separated values'))),
        conditionalPanel(
          condition = "input.Input_type_3 == 'numeric'",
          numericInput("max_3", label = ('Max numeric values'), value=0),numericInput("min_3", label = ('Min numeric values'),value=0),numericInput("step_3", label = ('Step'),value=0)),
      conditionalPanel(
        condition = "input.New_3 == '1'",
      actionButton("New_4","New Question")),
      conditionalPanel(
        condition = "input.New_4 == '1'",
        textInput("Question_test_4", label = h4("Add question 4"))),

        selectInput("Input_type_4","Select input widget type",c("text box","list","numeric"),selected="text box"),
        conditionalPanel(
          condition = "input.Input_type_4 == 'list'",
          textInput("List_4", label = ('Add list of comma separated values'))),
        conditionalPanel(
          condition = "input.Input_type_4 == 'numeric'",
          numericInput("max_4", label = ('Max numeric values'), value=0),numericInput("min_4", label = ('Min numeric values'),value=0),numericInput("step_4", label = ('Step'),value=0))),

#       actionButton("New","New Question"),
#                         conditionalPanel(
#                                 condition = "input.New == '1'",
#                                 addQuestion()),
    h3('Advanced options'),
    checkboxInput("check_box_test", label = h4(" Test active for data entry?"), value = TRUE),
    checkboxInput("check_validation_function", label = h4(" Create boiler-plate validation function to add more complex validation rules to?"), value = FALSE),
    checkboxInput("multiple_results_test", label = h4("Allow multiple results to be entered per sample"), value = FALSE),
hr())))

}

