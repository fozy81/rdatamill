
# save sample number to .Rdata file

sampleCounter <- function(){

  if (!file.exists("sampleCounter.Rdata")){
    counter <- 1
  save(counter,file="sampleCounter.Rdata")}

  if (file.exists("sampleCounter.Rdata")){ load(file="sampleCounter.Rdata")
    counter <- counter
  save(counter, file="sampleCounter.Rdata")}
  return(counter)

  }




