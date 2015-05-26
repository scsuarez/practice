require(sqldf)

## we only care about these
sigchem <- subset(allchem, significant=='yes')

## Test nobs in each category
nobs.per.name <- sqldf("select updown, count(*) as nobs from sigchem group by updown")
nobs.per.name.chem <- sqldf("select updown, sample_2 as sample, count(*) as nobs from sigchem group by sample_2, updown")
.plot.freq <- barchart(nobs ~ updown | sample, 
    nobs.per.name.chem, 
    ylim=c(0, max(nobs.per.name.chem$nobs)),
    scales=list(y=list(relation='free'), x=list(rot=90))
)

.qry <- 'select     
    x.test_id, x.sample_2 as sampleX, 
    y.sample_2 as sampleY, 
    x.updown as updownX, 
    y.updown as updownY,
    (y.updown == x.updown) as matchName
from sigchem x join sigchem y 
where 
    x.test_id == y.test_id and x.sample_2 != y.sample_2
'

joinDiff <- sqldf(.qry)

.qry <- "select sampleX, sampleY, updownX, updownY, count(*) as nmatch from joinDiff group by sampleX, sampleY, updownX, updownY"
updown.match <- sqldf(.qry, stringsAsFactors=TRUE)
updown.match <- subset(updown.match, sampleX < sampleY)

.plot.njoin <-  dotplot(
    paste(sampleX, updownX) ~ nmatch  | paste(sampleY, updownY), 
    updown.match, 
    scales=list(alternating=F, x=list(rot=90)), 
    horizontal=T, as.table=T, 
    xlab='Number of Samples',
    panel=function(x,y,...) {
        panel.grid(v=-1, h=0); panel.dotplot(x,y,...)
    }
)
#pdf('figure/updown.match.pdf', width=9, height=6)
#plot(.plot.njoin)
#dev.off()



aa = within(joinDiff, {
    sampleX <- factor(sampleX) 
    sampleY <- factor(sampleY) 
    updownX <- factor(updownX) 
    updownY <- factor(updownY) 
    compare <- factor(paste(sampleX, sampleY, sep = ' vs '))
})
bb = droplevels(subset(aa, 
    as.numeric(sampleX)>as.numeric(sampleY) & matchName ==1
))

cc = ddply(subset(bb, matchName==1), 'compare', function(.df){
    counts <- summary(.df$updownX)
    ret = data.frame(counts, updown=names(counts))
})
