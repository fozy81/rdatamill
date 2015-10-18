# Create test
#
# Special test for creating tests
# Need to DRY this out!!

create_test <- function() {

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
        numericInput("max_1", label = ('Max numeric values'), value=0),numericInput("min_1", label = ('Min numeric values'),value=0),numericInput("step_1", label = ('Step'),value=0),
        selectInput("Input_unit_1","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
        checkboxInput("mandatory_1", label = h4("Answer mandatory?"), value = F),
        actionButton("New_2","New Question"),


      conditionalPanel(
        condition = "input.New_2 >= '1'",
        textInput("Question_test_2", label = h3("Add question 2")),
        conditionalPanel(
          condition = "input.New_2 >= '1'",
        selectInput("Input_type_2","Select input widget type",c("text box","list","numeric"),selected="text box")),
        conditionalPanel(
          condition = "input.Input_type_2 == 'list'",
          textInput("List_2", label = ('Add list of comma separated values'))),
        conditionalPanel(
          condition = "input.Input_type_2 == 'numeric'",
          numericInput("max_2", label = ('Max numeric values'), value=0),numericInput("min_2", label = ('Min numeric values'),value=0),numericInput("step_2", label = ('Step'),value=0),
        selectInput("Input_unit_2","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
        checkboxInput("mandatory_2", label = h4("Answer mandatory?"), value = F),
        actionButton("New_3","New Question")),

      conditionalPanel(
        condition = "input.New_3 >= '1'",
        textInput("Question_test_3", label = h3("Add question 3")),
      selectInput("Input_type_3","Select input widget type",c("text box","list","numeric"),selected="text box"),
        conditionalPanel(
          condition = "input.Input_type_3 == 'list'",
          textInput("List_3", label = ('Add list of comma separated values'))),
        conditionalPanel(
          condition = "input.Input_type_3 == 'numeric'",
          numericInput("max_3", label = ('Max numeric values'), value=0),numericInput("min_3", label = ('Min numeric values'),value=0),numericInput("step_3", label = ('Step'),value=0),
          selectInput("Input_unit_3","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
        checkboxInput("mandatory_3", label = h4("Answer mandatory?"), value = F),
      actionButton("New_4","New Quesion")),

      conditionalPanel(
        condition = "input.New_4 >= '1'",
        textInput("Question_test_4", label = h4("Add question 4")),
        selectInput("Input_type_4","Select input widget type",c("text box","list","numeric"),selected="text box"),
        conditionalPanel(
          condition = "input.Input_type_4 == 'list'",
          textInput("List_4", label = ('Add list of comma separated values'))),
        conditionalPanel(
          condition = "input.Input_type_4 == 'numeric'",
          numericInput("max_4", label = ('Max numeric values'), value=0),numericInput("min_4", label = ('Min numeric values'),value=0),numericInput("step_4", label = ('Step'),value=0),
          selectInput("Input_unit_4","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
        checkboxInput("mandatory_4", label = h4("Answer mandatory?"), value = F),
         actionButton("New_5","New Question")),

    conditionalPanel(
      condition = "input.New_5 >= '1'",
      textInput("Question_test_5", label = h4("Add question 5")),
      selectInput("Input_type_5","Select input widget type",c("text box","list","numeric"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_5 == 'list'",
        textInput("List_5", label = ('Add list of comma separated values'))),
      conditionalPanel(
        condition = "input.Input_type_5 == 'numeric'",
        numericInput("max_5", label = ('Max numeric values'), value=0),numericInput("min_5", label = ('Min numeric values'),value=0),numericInput("step_5", label = ('Step'),value=0),
        selectInput("Input_unit_5","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
        checkboxInput("mandatory_5", label = h4("Answer mandatory?"), value = F),
      actionButton("New_6","New Question")),

    conditionalPanel(
      condition = "input.New_6 >= '1'",
      textInput("Question_test_6", label = h4("Add question 6")),
      selectInput("Input_type_6","Select input widget type",c("text box","list","numeric"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_6 == 'list'",
        textInput("List_6", label = ('Add list of comma separated values'))),
      conditionalPanel(
        condition = "input.Input_type_6 == 'numeric'",
        numericInput("max_6", label = ('Max numeric values'), value=0),numericInput("min_6", label = ('Min numeric values'),value=0),numericInput("step_6", label = ('Step'),value=0),
        selectInput("Input_unit_6","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
      checkboxInput("mandatory_6", label = h4("Answer mandatory?"), value = F),
      actionButton("New_7","New Question")),

    conditionalPanel(
      condition = "input.New_7 >= '1'",
      textInput("Question_test_7", label = h4("Add question 7")),
      selectInput("Input_type_7","Select input widget type",c("text box","list","numeric"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_7 == 'list'",
        textInput("List_7", label = ('Add list of comma separated values'))),
      conditionalPanel(
        condition = "input.Input_type_7 == 'numeric'",
        numericInput("max_7", label = ('Max numeric values'), value=0),numericInput("min_7", label = ('Min numeric values'),value=0),numericInput("step_7", label = ('Step'),value=0),
        selectInput("Input_unit_7","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
        checkboxInput("mandatory_7", label = h4("Answer mandatory?"), value = F),
      actionButton("New_8","New Question")),


    conditionalPanel(
      condition = "input.New_8 >= '1'",
      textInput("Question_test_8", label = h4("Add question 8")),
      selectInput("Input_type_8","Select input widget type",c("text box","list","numeric"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_8 == 'list'",
        textInput("List_8", label = ('Add list of comma separated values'))),
      conditionalPanel(
        condition = "input.Input_type_8 == 'numeric'",
        numericInput("max_8", label = ('Max numeric values'), value=0),numericInput("min_8", label = ('Min numeric values'),value=0),numericInput("step_8", label = ('Step'),value=0),
        selectInput("Input_unit_8","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
        checkboxInput("mandatory_8", label = h4("Answer mandatory?"), value = F),
    actionButton("New_9","New Question")),

    conditionalPanel(
      condition = "input.New_9 >= '1'",
      textInput("Question_test_9", label = h4("Add question 9")),
      selectInput("Input_type_9","Select input widget type",c("text box","list","numeric"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_9 == 'list'",
        textInput("List_9", label = ('Add list of comma separated values'))),
      conditionalPanel(
        condition = "input.Input_type_9 == 'numeric'",
        numericInput("max_9", label = ('Max numeric values'), value=0),numericInput("min_9", label = ('Min numeric values'),value=0),numericInput("step_9", label = ('Step'),value=0),
        selectInput("Input_unit_9","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
      checkboxInput("mandatory_9", label = h4("Answer mandatory?"), value = F),
    actionButton("New_10","New Question")),


    conditionalPanel(
      condition = "input.New_10 >= '1'",
      textInput("Question_test_10", label = h4("Add question 10")),
      selectInput("Input_type_10","Select input widget type",c("text box","list","numeric"),selected="text box"),
      conditionalPanel(
        condition = "input.Input_type_10 == 'list'",
        textInput("List_10", label = ('Add list of comma separated values'))),
      conditionalPanel(
        condition = "input.Input_type_10 == 'numeric'",
        numericInput("max_10", label = ('Max numeric values'), value=0),numericInput("min_10", label = ('Min numeric values'),value=0),numericInput("step_10", label = ('Step'),value=0),
        selectInput("Input_unit_10","Select unit type",c("none", "metre","%","kg","mm"),selected="none")),
              checkboxInput("mandatory_10", label = h4("Answer mandatory?"), value = F)),



    h3('Advanced options'),
    checkboxInput("check_box_test", label = h4(" Test active for data entry?"), value = TRUE),
#     checkboxInput("check_validation_function", label = h4(" Create boiler-plate validation function to add more complex validation rules to?"), value = FALSE),
    checkboxInput("multiple_results_test", label = h4("Allow multiple results to be entered per sample"), value = FALSE),
hr())))

}

