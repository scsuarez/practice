import re

wikiDir = "carpen-group.wiki/"
dataFile = "HW02.md"
fullname = wikiDir + dataFile
f = open(fullname)

## for each line of file
for line in f:
    # print line
    ## search for, e.g. 2015-01-01 00:00:01
    dateline = re.search('(\d+-\d+-\d+) (\d+:\d+:\d+).*', line)
    ## if there's *any* match
    if (dateline):
        #print line
        ## print the pattern in the second group of parens 
        print dateline.group(2)
