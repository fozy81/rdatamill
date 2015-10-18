upload_data <- function(){

  return(list(

h4('Upload csv matching following definition:'),

fileInput('file1', 'Choose CSV File',
          accept=c('text/csv',
                   'text/comma-separated-values,text/plain',
                   '.csv')))


  )



}
