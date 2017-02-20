library(tidyr)

setwd("C:/Users/nivibalu/Documents/capstone/project/")

my.corpus <- readLines("output//my.corpus.txt")

source("../../../Ngrams_Tokenizer.R")

## Unigram Analysis
unigram.tokenizer <- ngram_tokenizer(1)
unigrams <- unigram.tokenizer(my.corpus)
unigram.df <- data.frame(V1 = as.vector(names(table(unlist(unigrams)))), V2 = as.numeric(table(unlist(unigrams))))
names(unigram.df) <- c("word","freq")
unigram.df <- unigram.df[with(unigram.df, order(-unigram.df$freq)),]
row.names(unigram.df) <- NULL

## Bigram Analysis
bigram.tokenizer <- ngram_tokenizer(2)
bigrams <- bigram.tokenizer(my.corpus)
bigram.df <- data.frame(V1 = as.vector(names(table(unlist(bigrams)))), V2 = as.numeric(table(unlist(bigrams))))
bigram.df <- bigram.df[bigram.df[,2]>2,]
bigram.df <- separate(data = bigram.df, col = V1, into = c("word1", "word2"), sep = " ")
names(bigram.df) <- c("word1", "word2", "freq")
row.names(bigram.df) <- NULL

bigram.df <- merge(bigram.df, unigram.df, by.x = "word1", by.y = "word")
bigram.df <- cbind(bigram.df, bigram.df[,3]/bigram.df[,4])
bigram.df <- bigram.df[,c(1,2,3,5)]
names(bigram.df) <- c("word1", "word2", "freq", "probability")
bigram.df <- bigram.df[order(bigram.df$probability, decreasing=TRUE), ];

## Trigram Analysis
trigram.tokenizer <- ngram_tokenizer(3)
trigrams <- trigram.tokenizer(my.corpus)
trigram.df <- data.frame(V1 = as.vector(names(table(unlist(trigrams)))), V2 = as.numeric(table(unlist(trigrams))))
trigram.df <- separate(data = trigram.df, col = V1, into = c("word1", "word2", "word3"), sep = " ")
names(trigram.df) <- c("word1", "word2", "word3", "freq")
row.names(trigram.df) <- NULL

trigram.df <- merge(trigram.df, bigram.df[,c("word1","word2","freq")], by = c("word1", "word2"))
trigram.df <- cbind(trigram.df, trigram.df[,4]/trigram.df[,5])
trigram.df <- trigram.df[,c(1,2,3,4,6)]
names(trigram.df) <- c("word1", "word2", "word3", "freq", "probability")
trigram.df <- trigram.df[order(trigram.df$probability, decreasing=TRUE), ];

## Quadrigram Analysis
#quadrigram.tokenizer <- ngram_tokenizer(4)
#quadrigrams <- quadrigram.tokenizer(my.corpus)
#quadrigram.df <- data.frame(V1 = as.vector(names(table(unlist(quadrigrams)))), V2 = as.numeric(table(unlist(quadrigrams))))
#names(quadrigram.df) <- c("word1","word2","word3","word4", "freq")
#quadrigram.df <- quadrigram.df[order(quadrigram.df$freq, decreasing=TRUE), ];
#row.names(quadrigram.df) <- NULL

#quadrigram.df <- merge(quadrigram.df, trigram.df[,c("word1","word2","word3", "freq")], by = c("word1", "word2", "word3"))
#quadrigram.df <- cbind(quadrigram.df, quadrigram.df[,5]/quadrigram.df[,6])
#quadrigram.df <- quadrigram.df[,c(1,2,3,4,5,7)]
#names(quadrigram.df) <- c("word1", "word2", "word3","predicted", "freq", "probability")

names(bigram.df) <- c("word1", "predicted", "freq", "probability")
names(trigram.df) <- c("word1", "word2", "predicted", "freq", "probability")

save(unigram.df, bigram.df, trigram.df, file="rdata//ngrams.Rda")

#save(unigram.df, file="rdata//unigram.Rda")
#save(bigram.df, file="rdata//bigram.Rda")
#save(trigram.df, file="rdata//trigram.Rda")

rm(list = ls())

gc()
