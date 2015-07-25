# Tree Test
#
# Example test for tree survey


testTree <- function() {
  return(list(
    div(
      id = "form",
    dateInput("dateTree", "Date", value = Sys.Date()),
    selectizeInput(inputId="surveyorTree", label="Surveyor", choices= c("Tim","Cathy","Dave",""), selected=''),

    selectizeInput(inputId="speciesTree", label="Species", choices= c("Oak","Birch","Pine",""),selected=''),
    sliderInput(inputId= "heightTree",
                          "Height",
                          min = 0,
                          max = 1000,
                          value = 0),
              sliderInput(inputId= "widthTree",
                          "Width",
                          min = 0,
                          max = 1000,
                          value = 0)

  )))

}
