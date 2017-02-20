library(tm)
library(RWeka)
library(SnowballC)

setwd("C:/Users/nivibalu/Documents/capstone/project/")

load("rdata//samples.Rdata")

sample.corpus <- c(sample.blogs,sample.news,sample.twitter)
my.corpus <- Corpus(VectorSource(list(sample.corpus)))

my.corpus <- tm_map(my.corpus, content_transformer(tolower))
my.corpus <- tm_map(my.corpus, removePunctuation)
my.corpus <- tm_map(my.corpus, removeNumbers)
#my.corpus <- tm_map(my.corpus, removeWords, stopwords("english"))

googlebadwords <- read.delim("google_bad_words.txt",sep = ":",header = FALSE)
googlebadwords <- googlebadwords[,1]
my.corpus <- tm_map(my.corpus, removeWords, googlebadwords)

my.corpus <- tm_map(my.corpus, stripWhitespace)

writeCorpus(my.corpus, filenames="output//my.corpus.txt")

save(my.corpus, file="rdata//corpus.Rda")

rm(list = ls())

gc()
