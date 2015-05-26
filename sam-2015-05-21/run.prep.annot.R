## depends on read.data.R
## pull RefSeq annotation ids into separate table
annot.df <- subset(allchem, select=c(test_id, gene))
annot.df <- within(annot.df, {
    gene <- as.character(annot.df$gene)
    test_id <- as.character(test_id)
    ## and remove from original tab
    #allchem <- subset(allchem, select=-gene)
})
## need to split these
.rep.ids <- subset(annot.df, grepl(',',gene))
## remove from main df
annot.df <- subset(annot.df, !grepl(',',gene))

.splitlist <- strsplit(.rep.ids$gene, ',')

## manually split compound gene fields
## this takes a while...
.annot.split <- ldply(1:nrow(.rep.ids), function(ii) {
    .row <- .rep.ids[ii,]
    .genes <- .splitlist[[ii]]
    ret <- data.frame(test_id=.row$test_id, gene=.genes)
    return(ret)
}, .progress='text')

## merge back in
annot.df <- rbind(annot.df, .annot.split)
annot.df <- within(annot.df, {
    gene <- factor(gene)
    test_id <- factor(test_id)
    #find genes with NCBI reference NR_, indicates noncoding, reviewed
    # for detail see http://en.wikipedia.org/wiki/RefSeq
    is.nr <- grepl("NR_", gene, fixed=TRUE)
    #find genes with NCBI reference XR_, indicates noncoding, predicted
    is.xr <- grepl("XR_", gene, fixed=TRUE)
})

## remove gene col from rna reads df
allchem$gene <- NULL
#levels(allchem$test_id) <- levels(annot.df$test_id)


