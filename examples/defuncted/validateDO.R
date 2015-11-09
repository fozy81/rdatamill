# tests for DO results dataframe

library(testdat)
data <- read.csv("dataResults.csv", header=T)
test_utf8(data)
test_NA(data)
test_white_spaces(as.character(data$Result))
