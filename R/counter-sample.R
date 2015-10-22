
# save sample number to .Rdata file

count_sample <- function(){

  if (!file.exists("sampleCounter.Rdata")){
    counter <- 1
  save(counter,file="sampleCounter.Rdata")}

  if (file.exists("sampleCounter.Rdata")){ load(file="sampleCounter.Rdata")
    counter <- counter + 1
  save(counter, file="sampleCounter.Rdata")}
  return(counter)

  }




