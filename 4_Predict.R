library(stringr)

setwd("C:/Users/nivibalu/Documents/capstone/project/")

load("ngrams.Rda")

source("../../../../Ngrams_Tokenizer.R")


# Input String

inputString <- "in the"

if (length(inputString) > 0) {

inputString <- tolower(inputString)
unigram.tokenizer <- ngram_tokenizer(1)
inputString.token <- unigram.tokenizer(inputString)
#inputString.token <- inputString.token[!inputString.token %in% stopwords("english")]

if (length(inputString.token) > 2) {
  inputString.token <- tail(inputString.token,2)
  prediction.df <- trigram.df[(trigram.df$word1==inputString.token[1] & trigram.df$word2==inputString.token[2]),]
  row.names(prediction.df) <- NULL
  prediction1 <- prediction.df$predicted[1]
  prediction2 <- prediction.df$predicted[2]
  prediction3 <- prediction.df$predicted[3]
} else if (length(inputString.token) == 2) {
  prediction.df <- trigram.df[(trigram.df$word1==inputString.token[1] & trigram.df$word2==inputString.token[2]),]
  row.names(prediction.df) <- NULL
  prediction1 <- prediction.df$predicted[1]
  prediction2 <- prediction.df$predicted[2]
  prediction3 <- prediction.df$predicted[3]
} else if (length(inputString.token) == 1) {
  prediction.df <- bigram.df[(bigram.df$word1==inputString.token[1]),]
  row.names(prediction.df) <- NULL
  prediction1 <- prediction.df$predicted[1]
  prediction2 <- prediction.df$predicted[2]
  prediction3 <- prediction.df$predicted[3]
} else if (length(inputString.token) < 1) {
  prediction1 <- "Please enter one or more words"
  prediction2 <- ""
  prediction3 <- ""
}

}
