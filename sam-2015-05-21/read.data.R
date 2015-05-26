
## data from http://cole-trapnell-lab.github.io/cufflinks/cuffdiff/index.html#cuffdiff-output-files
## manually removed annotation cols (regen from col gene)
## and log2fold + test_stat cols due to =inf / =nan values
## vector of data filenames
.files <- dir('data', pattern='all.expr.*csv', full.names=T)
## for each file
.datlist <- lapply(.files, function(.file) {
    ret <- read.table(.file, header=T, sep=',')
    return(ret)
})

## rowbind all 3 data.frames into a single table 
allchem <- do.call(rbind, .datlist)

allchem <- within(allchem,{
    ## change w/treatment
    prop.diff <- value_2/value_1
    log2.prop.diff <- log2(prop.diff)
    ## prepare a factor
    ## all relevant states of difference w/treatemtn
    ## e.g. increase, decrease
    diffName <- ''
    diffName[prop.diff == 1 ] = 'NC'
    diffName[prop.diff >1 ] = 'Increase'
    diffName[prop.diff <1 ] = 'Decrease'
    diffName[prop.diff==0] = 'ToZero'
    diffName[is.infinite(prop.diff)] = 'FromZero'
    diffName[is.nan(prop.diff)] = 'AllZero'
    diffName <- as.factor(diffName)
    ## 
    updown <- ''
    updown[prop.diff == 1 ] = 'NC'
    updown[prop.diff >1 | is.infinite(prop.diff) ] = 'Increase'
    updown[prop.diff <1 | is.nan(prop.diff) ] = 'Decrease'
    updown <- as.factor(updown)
    
    #find genes with NCBI reference NR_, indicates noncoding, reviewed
    # for detail see http://en.wikipedia.org/wiki/RefSeq
    is.nr <- grepl("NR_", gene, fixed=TRUE)
    #find genes with NCBI reference XR_, indicates noncoding, predicted
    annot.df$is.xr <- grepl("XR_",annot.df$gene, fixed=TRUE)
X})
