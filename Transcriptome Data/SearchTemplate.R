# set working directory
setwd("~/practice/Transcriptome Data")
# all files is all files in the directory with the pattern "*.csv"
allfiles = dir(pattern = "*.csv")
# for the object allfiles, read all csv files into an object alldat
## this is a function calling a function
### ? lapply (object, ?why function(filename), we haven't defined filename?
### ? is filename inherent to the program ?
### ? is function(filename) anything we define in {}?
#### That's what my gut tells me
alldat = lapply(allfiles, function(filename) { 
    dat = read.csv(filename, header = TRUE);
    return(dat)
})
# list all files imported
list(allfiles)