# tell the program which working directory
# do this at the beginning
setwd("~/practice/Transcriptome Data")
## don't need to do this if the R file and target files are in the same directory
## default wd on open is "~/practice", so we do need to do this on every time we initialize Rstudio
# import the datafile we want to search
# datahandle <- read.csv("filename.csv", header = TRUE)
## import csv file into "datahandle (object name)" into an object
## header = TRUE means the first row is the column labels

# tell the program which column to search
# search for a phrase within a given column context irrespective, such as "Ixodes scapularis"
# count the number of results for the column and print it.
# sum(grepl("[Ixodes scapularis]", data1stLeg$Hit.desc., fixed = TRUE))
# do this for all the files in "~/practice/Transcriptome Data"

# this is the whole enchilada
# break it up to make it run faster
## lapply = list apply, look in the directory for files with the pattern *.csv
## and put that into filename
### { starts the process for all the files
aa = lapply(dir(pattern = "*.csv"), function(filename) {
    # for the list output from line 19, read each file into dat with the first row as columns
    dat = read.csv(filename, header = TRUE);
    # count rows in the files in dat and put it into nn
    nn = nrow(dat);
    # this line puts the sum of the search into the object nhits
    # grepl is a function that is for logical searching of strings
    # order in grepl("what we're searching for", where we're searching for it [in this case,
    # we're searching the files in object(dat)$column(Hit.desc.), fixed = TRUE means we're
    # searching for only "[Ixodes scapularis]")
    nhits = sum(grepl("[Ixodes scapularis]", dat$Hit.desc., fixed = TRUE));
    # answer is dividing the object nhits by total rows to give the answer we're looking for
    answer = nhits/nn;
    # return gives the output of the object answer in order
    # in order to give both the output and the filename, we must concatenate (c())
    return(c(filename,answer)) 
    # }) closes the whole thing
})
# semicolons are only necessary when writing the entire thing on one line.
# don't know what has happened, but overnight, the object aa returns an empty list
# this is because we didn't set the working directory
# add in the setwd("~/practice/Transcriptome Data")
# quotes are necessary for directory recognition
# getwd() is pwd


# this is the parts of above broken into 2 
# so we can use alldat independently and the search in 2 parts
allfiles = dir(pattern = "*.csv")
alldat = lapply(allfiles, function(filename) { 
    dat = read.csv(filename, header = TRUE);
    return(dat)
})

analysis = lapply(alldat, function(dat) { 
    nn = nrow(dat);
    # in grepl(search, columns, find exactly), we can manually specify column
    # number to search for by object[row number, column number]
    ## not sure if this is totally true, but it definitely works for a specified column number
    nhits = sum(grepl("[Ixodes scapularis]", dat[,4], fixed = TRUE));
    answer = nhits/nn
    return(answer) 
})
#gives the names for the file belonging to each result along with the result
names(analysis) = allfiles

#now, how do we run this as an integrated file?
## source("~practice/Transcriptome Data/transcriptome search comparison.R")
