
# save sample number to .Rdata file

count_sample <- function(){

  if (!file.exists("sample_counter.Rdata")){
    counter <- 1
  save(counter,file="sample_counter.Rdata")}

  if (file.exists("sample_counter.Rdata")){ load(file="sample_counter.Rdata")
    counter <- counter + 1
  save(counter, file="sample_counter.Rdata")}
  return(counter)

  }




