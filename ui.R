library(shiny)

shinyUI(navbarPage("Menu",
                   tabPanel("Application",
                            pageWithSidebar(
                              headerPanel("Text Prediction"),
                              sidebarPanel(
                                textInput("text", label = h5("Please type your text below (characters only)")),
                                actionButton("goButton", "Predict")
                              ),
                              mainPanel(
                                h3('Closest matches'),
                                textOutput("text1"),
                                textOutput("text2"),
                                textOutput("text3")
                              )
                            )
                   ),
                   tabPanel("Help",
                            h3('Summary'),
                            p('This application aims to predict the most likely next word based on a string of text that you enter in the input box.'),
                            h3('Databases Used'),
                            p('To make prediction the application uses a mixed sample of news, blogs and twitter text, which has been manipulated in order to facilitate the prediction process'),
                            h3('Input Explanation'),
                            p('You can type any text in the input box. The only limitation is that it needs to consist of only non-numeric, non-special characters and spaces. If the text length is 2 words or more, the algorithm will isolate the last two words and make a prediction based on these. If you only input one word, the algorithm will make a prediction based on that. Since the maximum input has been restricted to two words to make the application faster, some of the predictions might not make sense when inputting large sentences.'),
                            h3('Output Explanation'),
                            p('The algorithm calculates the probabilities of the next word occuring and presents three words that have the highest probability to be the next word based on the input you proivided. If there is no prediction based on the input, the output will display NA'),
                            h3('Source Code'),
                            div(p('The source code can be found in my GutHub repository:'), a("https://github.com/nivibalu/capstone", href="https://github.com/nivibalu/capstone"))
                   )
)
)

    Contact GitHub API Training Shop Blog About 

    © 2017 GitHub, Inc. Terms Privacy Security Status Help 

