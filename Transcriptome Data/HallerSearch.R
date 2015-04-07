require(plyr)
setwd("~/practice/Transcriptome Data")
searchfile = "SearchTerm.csv"
datfile = "Hallers_organ_no_dup.csv"
dat = read.csv(datfile, header = TRUE)
searchlist = read.csv(searchfile, header = TRUE)
coltypes = lapply(dat,class)
seqcolnames = c("Sequence.desc.","Hit.desc.")


hits.search = ldply(seqcolnames, function(.colname) {
    cat(sprintf('Processing %s\n', .colname))
    .datcol = dat[[.colname]]
    .outer.result = ddply(searchlist, c('Class', 'Keyword'), function(.searchdf) {
        .term = .searchdf$Keyword
        result = data.frame(rowid=grep(.term, .datcol))
        return(result)
    }, .progress='text')
    .outer.result$searchCol = .colname
    return(.outer.result)
})

hits.search = ddply(hits.search, c('Class', 'Keyword'), function(.hitsdf){
    .rowid = unique(.hitsdf$rowid)
    return(data.frame(rowid = .rowid))
})
hits.search = cbind(hits.search, dat[ hits.search$rowid, ])

write.table(hits.search, file = "searchhits.csv", sep = ',', row.names = FALSE)

# for histograms in our desired style
# ?histogram for explanation
# require(lattice)
# histogram( ~ Keyword | Class, hits.search, scales=list(x=list(rot=45), y=list(relation="free"), alternating=F), layout=c(1,3), type="count")