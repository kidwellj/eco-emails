
# Script to parse email newsletters from environmental groups

# Note: There doesn't seem to be a good package for ingesting email mbox files in R, 
# so I have already processed an exported mbox file using python (https://github.com/jarrodparkes/mbox-to-csv)

# PRELIMINARIES, load libraries and data

require(tm)
require(wordcloud)
require(stringr)

# Start by generating wordcloud from CCF applications stored in CSV

# Clean data set

newsletters <- Corpus (DirSource("CCF/"))
ccf <- tm_map(ccf, stripWhitespace)
ccf <- tm_map(ccf, tolower)
ccf <- tm_map(ccf, removeNumbers)
ccf <- tm_map(ccf, removePunctuation)

# tweak by adding extra stopwords, "will"

myStopwords <- c(stopwords('english'), "will", "project")

# tweak by removing extra stopwords, in this example "r"
# idx <- which(myStopwords == "r")
# myStopwords <- myStopwords[-idx]

ccf <- tm_map(ccf, removeWords, myStopwords)
# ccf <- tm_map(ccf, stemDocument)
ccf <- tm_map(ccf, PlainTextDocument)

# Create word cloud

# wordcloud(ccf, scale=c(5,0.5), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark2"))
# wordcloud(ccf, scale=c(8,.2), min.freq=2, max.words=Inf, random.order=FALSE, rot.per=.15, colors=brewer.pal(8, "Dark2"))
wordcloud(ccf, scale=c(5,.3), max.words=250, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=brewer.pal(8, "Dark3"))

# Extract URLs

https://stackoverflow.com/questions/26496538/extract-urls-with-regex-into-a-new-data-frame-column#26498790