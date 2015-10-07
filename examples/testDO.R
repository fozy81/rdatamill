# Dissolved Oxygen Test
#
# Example test for DO


testDO <- function() {


  return(list(
    div(
      id = "form",sliderInput(inputId= "obs",
                          "DO - Dissolved Oxygen",
                          min = 0,
                          max = 1000,
                          value = 0))
            ))
  shinyjs::reset("form")
}
