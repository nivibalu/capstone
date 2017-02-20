library(shiny)
library(stringr)

load("C:/Users/nivibalu/Documents/capstone/project//ngrams.Rda")
source("C:/Users/nivibalu/Documents/capstone/project//Ngrams_Tokenizer.R")

predict_fun <- function(inputString, unigram.df, bigram.df, trigram.df, ngram_tokenizer) {
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
      
      if (is.na(prediction1)) {
        prediction.df <- bigram.df[(bigram.df$word1==inputString.token[2]),]
        row.names(prediction.df) <- NULL
        prediction1 <- prediction.df$predicted[1]
        prediction2 <- prediction.df$predicted[2]
        prediction3 <- prediction.df$predicted[3]
      }
      
    } else if (length(inputString.token) == 2) {
      prediction.df <- trigram.df[(trigram.df$word1==inputString.token[1] & trigram.df$word2==inputString.token[2]),]
      row.names(prediction.df) <- NULL
      prediction1 <- prediction.df$predicted[1]
      prediction2 <- prediction.df$predicted[2]
      prediction3 <- prediction.df$predicted[3]
      
      if (is.na(prediction1)) {
        prediction.df <- bigram.df[(bigram.df$word1==inputString.token[2]),]
        row.names(prediction.df) <- NULL
        prediction1 <- prediction.df$predicted[1]
        prediction2 <- prediction.df$predicted[2]
        prediction3 <- prediction.df$predicted[3]
      }
      
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
return(c(prediction1,prediction2,prediction3))
}

shinyServer(
  function(input, output) {
    observe({
      if (input$goButton > 0) {
      param <- input$text
      prediction <- predict_fun(input$text, unigram.df, bigram.df, trigram.df, ngram_tokenizer)
      output$text1 <- renderText({ 
        paste("Top Prediction:    ", prediction[1])
      })
      output$text2 <- renderText({ 
        paste("Second Prediction: ", prediction[2])
      })
      output$text3 <- renderText({ 
        paste("Third Prediction:  ", prediction[3])
      })
      
    }
    })    
  }
)
