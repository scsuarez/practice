#tell the program which working directory
#do this at the beginning
setwd("~/practice/Transcriptome Data")
##don't need to do this if the R file and target files are in the same directory
#import the datafile we want to search
#datahandle <- read.csv("filename.csv", header = TRUE)
##import csv file into "datahandle (object name)" into an object
##header = TRUE means the first row is the column labels

#tell the program which column to search
#search for a phrase within a given column context irrespective, such as "Ixodes scapularis"
#count the number of results for the column and print it.
#sum(grepl("[Ixodes scapularis]", data1stLeg$Hit.desc., fixed = TRUE))
#do this for all the files in "~/practice/Transcriptome Data"

#this is the whole enchilada
#break it up to make it run faster
## lapply = list apply, look in the directory for files with the pattern *.csv
## and put that into filename
aa = lapply(dir(pattern = "*.csv"), function(filename) {
    #for the list output from line 19, read each file into dat with the first row as columns
    dat = read.csv(filename, header = TRUE);
    #count rows in the files in dat and put it into nn
    nn = nrow(dat);
    nhits = sum(grepl("[Ixodes scapularis]", dat$Hit.desc., fixed = TRUE));
    answer = nhits/nn;
    return(c(filename,answer)) 
})
#semicolons are only necessary when writing the entire thing on one line.
#don't know what has happened, but overnight, the object aa returns an empty list



#this is the parts
allfiles = dir(pattern = "*.csv")
alldat = lapply(allfiles, function(filename) { 
    dat = read.csv(filename, header = TRUE);
    return(dat)
})

analysis = lapply(alldat, function(dat) { 
    nn = nrow(dat);
    nhits = sum(grepl("[Ixodes scapularis]", dat[,4], fixed = TRUE));
    answer = nhits/nn
    return(answer) 
})
names(analysis) = allfiles

