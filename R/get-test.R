get_test <- function(columns=NULL) {
  if (file.exists("tests.csv")) {
    test_df <- read.csv(file = "tests.csv", stringsAsFactors = F)
    if(!is.null(columns)){
    test_df <- test_df[, c(columns)]}
    return(test_df)
  }

  # this is where linked database details should go:
  if (!file.exists("tests.csv")) {
    return()

  }
}
