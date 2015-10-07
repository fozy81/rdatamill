
# save test number to .Rdata file

testCounter <- function(){

  if (!file.exists("counter.Rdata")){
    counter <- 1
  save(counter,file="counter.Rdata")}

  if (file.exists("counter.Rdata")){ load(file="counter.Rdata")
    counter <- counter

  save(counter, file="counter.Rdata")}
  return(counter)

  }




