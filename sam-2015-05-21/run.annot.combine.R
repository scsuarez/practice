require(plyr)
## left-join: all from sigchem, matching from annot.df
combine.df <- join(sigchem, annot.df)

## just get rows with NR_ annotations
count.nr <- subset(combine.df, is.nr)
count.nr <- ddply(count.nr, c('sample_2', 'updown'), function(.df) {
    n_test_id <- length(unique(.df$test_id))
    return(data.frame(n_test_id))
})

## barplot of seq counts w/shared y axes
.plot.ncfreq <- barchart(n_test_id ~ updown | sample_2, 
                       count.nr, 
                       ylim=c(0, max(count.nr$n_test_id)),
                       scales=list(y=list(relation='free'), x=list(rot=90))
)
plot(.plot.ncfreq)

## pull out one "bar" worth of data
## remember, each rna read has multiple rows, one per annotation
summary(subset(combine.df, sample_2=="Chemical_B" & is.nr & updown=="Increase"))