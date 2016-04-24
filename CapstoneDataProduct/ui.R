## Loading dependencies
library(shiny)
require(markdown)

shinyUI(
        navbarPage("Data Science Capstone Project Next Word Prediction", inverse = FALSE, collapsable = FALSE, 
                   tabPanel("Prediction", (includeScript("GoogleAnalytics.js")),
                            # includeCSS("superhero.css"),
                            fluidRow(
                                    sidebarPanel(width=3,
                                                 h5("Text Input:"),
                                                 textInput("entry", 
                                                           "The app predicts the next possible word in the input phrase below:",
                                                           "Ohhhhh #PointBreak is on tomorrow. Love that film and haven't seen it in quite some"),
                                                 p("Give a couple moments for the app to initialize with this starting default phrase."),
                                                 p("Feel free to input your own phrase and predict the next word!"),
                                                 hr(),
                                                 helpText(h5("Instructions:")),
                                                 helpText("On the dashboard to the right, you can view the following output:"),
                                                 helpText("1. Type your sentence in the text field", style="color: #1e90ff"),
                                                 helpText("2. The value will be passed to the model while you are typing.", style="color:#1e90ff"),
                                                 helpText("3. Obtain predicted next word!", style="color:#1e90ff"),
                                                 hr(),
                                                 h6("This App is built for:"),
                                                 a("Data Science Capstone Project (SwiftKey)", href="https://www.coursera.org/course/dsscapstone"),
                                                 p("March-April 2016"),
                                                 hr(),
                                                 h6("Contact Links for Anuar Imanbayev:"),
                                                 a(img(src = "GitHub.png", height = 30, width = 30),href="https://github.com/anuarimanbayev/datasciencecoursera/tree/master/CapstoneProject"),
                                                 a(img(src = "linkedin.png", height = 26, width = 26),href="https://www.linkedin.com/in/anuarimanbayev"),
                                                 a(img(src = "gmail.jpeg", height = 30, width = 30),href="mailto: anuar.imanbayev@gmail.com"),
                                                 br()
                                                 ),
                                    mainPanel(
                                            column(5,
                                                   h3("Word Prediction"),hr(),
                                                   h5('The input phrase:'),                             
                                                   wellPanel(span(h4(textOutput('sent')),style = "color:#ff0000")),
                                                   hr(),
                                                   h5('Single Word Prediction:'),
                                                   wellPanel(span(h4(textOutput('top1')),style = "color:#00a86b")),
                                                   hr(),
                                                   h5('Other Possible Single Word Predictions:'),
                                                   wellPanel(span(h5(textOutput('top2')),style = "color:#40e0d0"),
                                                             span(h5(textOutput('top3')),style = "color:#40e0d0"),
                                                             span(h5(textOutput('top4')),style = "color:#40e0d0"),
                                                             span(h5(textOutput('top5')),style = "color:#40e0d0")),
                                                   hr(),
                                                   
                                                   p('More details of the prediction algorithm and source codes', 
                                                     code("server.R"), code("ui.R"), code("funcPredictNextWord.R"), code("funcPredictWordCloud.R"), code("funcTokenization.R"), code("funcNGramSplit.R"), 
                                                     'can be found at', a("Capstone Project Shiny App.",href="https://github.com/anuarimanbayev/datasciencecoursera/tree/master/CapstoneProject"))
                                            ),
                                            column(5,
                                                   h3("Word Cloud Diagram"),hr(),
                                                   h5("A", code("word cloud"), "or data cloud is a data display which uses font size and/
                                                      or color to indicate numerical values like frequency of words. Please click", code("Update Word Cloud"), 
                                                      "button and", code("Slider Input"), "in the slider bar below to update the plot for relevant prediction."),
                                                   br(),
                                                   actionButton("update", "Update Word Cloud"),
                                                   sliderInput("max", 
                                                               h5("Maximum Number of Wordcloud Words:"), 
                                                               min = 10,  max = 200,  value = 100),
                                                   br(),
                                                   plotOutput("wordCloud"), # wordcloud
                                                   br()
                                            )
                                            )
                                    )
                   ),
                   tabPanel("Methodology",
                            sidebarLayout(
                                    sidebarPanel(width=3,
                                                 helpText(h5("Instructions:")),
                                                 helpText("Please switch the panels on the right side to figure out:"),
                                                 helpText("1. How is the word being predicted?", style="color:#1e90ff"),
                                                 helpText("2. How does this App work?", style="color:#1e90ff"),
                                                 helpText("3. Key concepts & techniques implemented in model", style="color:#1e90ff"),
                                                 hr(),
                                                 helpText(h5("Note:")),
                                                 helpText("For more information, you can go to", code("Slide Deck tab"), "in the navi bar
                                                          to view the final report Slide Deck constructed with R Studio Presenter."),
                                                 hr(),
                                                 h6("This App is built for:"),
                                                 a("Data Science Capstone Project (SwiftKey)", href="https://www.coursera.org/course/dsscapstone"),
                                                 p("March-April 2016"),
                                                 hr(),
                                                 h6("Contact Links for Anuar Imanbayev:"),
                                                 a(img(src = "GitHub.png", height = 30, width = 30),href="https://github.com/anuarimanbayev/datasciencecoursera/tree/master/CapstoneProject"),
                                                 a(img(src = "linkedin.png", height = 26, width = 26),href="https://www.linkedin.com/in/anuarimanbayev"),
                                                 a(img(src = "gmail.jpeg", height = 30, width = 30),href="mailto: anuar.imanbayev@gmail.com"),
                                                 br(),hr()
                                                 ),
                                    mainPanel(
                                            tabsetPanel(type="tabs",
                                                        tabPanel("Predictive Model",                                                      
                                                                 h3("Predictive Model Establishment"),hr(),
                                                                 h4("Clean the training dataset"),
                                                                 p("The dataset was cleaned by ", code("tokenization()"), "and", code("nGramSplit()"),
                                                                   "functions. These functions transform the text data via tokenization and splitting into ngrams in an automated way,
                                                                   in order to reduce the", code("processing time"), "and avoid the", code("memory limits"), "issues."),
                                                                 p("The raw text datasets are about 580M in total-", code('en_US.blogs.txt-210M'),
                                                                   code('en_US.news.txt-206M'),code('en_US.twitter.txt-167M')),
                                                                 p("After preprocessing of the datasets including cleaning, tokenizing and ngram splitting, 
                                                                   the three raw datasets are combined and then 1-4 gram frequency matrices are produced. 
                                                                   The total size of the new dataset", code("nGrams_model.RData"), "is reduced to 36M."),
                                                                 hr(),
                                                                 h4("Craft the model"),
                                                                 p(a("Simple Good-Turing"),
                                                                   'and Back off techniques were used for estimating the probabilities corresponding to the observed frequencies, 
                                                                   and the joint probability of all unobserved species. The last three words of users\' input sentence will be extracted first and used
                                                                   for seach in 4-grams matrix. If none result is return, then we will move back to 3-grams, and then 2-grams and 1-gram.
                                                                   the final predictions will be chosen accordingly by the frequency and n-grams of the model.' ),                                                         
                                                                 hr(),
                                                                 h4("A glance of model table"),
                                                                 dataTableOutput('modelTable'),
                                                                 br(),
                                                                 br()
                                                                 ),
                                                        
                                                        tabPanel("App Workflow",                                                       
                                                                 h3("Shiny App Prediction Algorithm"),
                                                                 hr(),
                                                                 img(src="work_flow_shiny.png", height = 262, width = 800),
                                                                 hr(),
                                                                 h4("Preprocess"),
                                                                 p("1. Obtain the data from the", code("input box.")),
                                                                 p("2.", code("Cleaning"), "for the data sentence. Numbers, punctuations,
                                                                   extra spaces will be removed, and all words are converted to lowercase."),
                                                                 hr(),
                                                                 h4("Tokenize"),
                                                                 p("After preprocessing, the sentence will be truncated from the", code("last 3 words.")
                                                                   , "If there are less than 3 words, all the words will be used."),
                                                                 hr(),
                                                                 h4("Search pattern"),
                                                                 p("Search the pattern from the", code("n-gram model."), 
                                                                   "The algormithm will search the pattern from 
                                                                   the 3-grams frequency matrix, and then return the Top 5 frequent predictions.However, 
                                                                   if there is no result, it will automatically search the 2-grams, 
                                                                   and if it still no result, it will search the 1-gram matrix."),
                                                                 hr(),
                                                                 h4("Predict the next single word"),
                                                                 p("The next possible single word will be returned and displayed. 
                                                                   In addition, the top 5 possible words also could be found. The average predicting time for
                                                                   one input is usually", code("0.000 ~ 0.003s"), "by using this model, which 
                                                                   is pretty decent for a mobile predictive model based on such large datasets.")
                                                                 ),
                                                        
                                                        tabPanel("Key Concepts",                                                      
                                                                 h3("Key Concepts/Terminology"),hr(),
                                                                 h4("1. Tokenization() function"),
                                                                 p(code("Tokenization()"), "function is based on",code("tm package"),
                                                                   "for data cleanning process, it mainly provides users with reproducible functionalities such as:",
                                                                   code("Simple Transformation"), code("Lowercase Transformation"), code("Remove Numbers"), 
                                                                   code("Remove Punctuations"), code("Remove Stop Words"), code("Profanity Filtering"),"with only one command."),
                                                                 hr(),
                                                                 h4("2. nGramSplit() function"),
                                                                 p(code("nGramSplit()"),"function is developed to tackle the memory limits problem when generating
                                                                   ngrams model from database. It provides users with a reproducible functionality to split raw datasets into 
                                                                   a set of user defined number of transformed n-grams models."),
                                                                 hr(),
                                                                 h4("3. N-grams language model"),
                                                                 p("An", code("n-gram model"), "is a type of probabilistic language model for predicting the next item in such a sequence in the form of", 
                                                                   code("a (n - 1)"),"–order ", code("Markov model")),
                                                                 p("In this model, we are using 1-4 grams for prediction purpose, they are refering to", code("unigram"),
                                                                   code("bigram"),code("trigram"),code("quatrgram"),"respectively."),
                                                                 hr(),
                                                                 h4("4. Computing probabilities"),
                                                                 p("To compute the probabilities of each token,",a("Markov chain", href="http://en.wikipedia.org/wiki/Markov_chain"),"is introduced and implemented
                                                                   in our model."),
                                                                 p("A Markov chain is a sequence of random variables X1, X2, X3, ... with the Markov property, namely that, 
                                                                   given the present state, the future and past states are independent."),
                                                                 p("The equation for Markov chain is:"),
                                                                 img(src = "markov.png", height = 100, width = 900),
                                                                 hr(),
                                                                 h4("5. Smoothing"),
                                                                 p("Smoothing techniques are main used to cope with unseen n-grams in text modelling.",
                                                                   a("Katz's back-off model", href="http://en.wikipedia.org/wiki/Katz%27s_back-off_model"),"is introduced in this model."),
                                                                 p(code("Katz back-off"),"is a generative n-gram language model that estimates the conditional probability of a word given its history 
                                                                   in the n-gram. It accomplishes this estimation by \"backing-off\" to models with smaller histories under certain conditions. 
                                                                   By doing so, the model with the most reliable information about a given history is used to provide the better results."),
                                                                 p("The equation for Katz's back-off model is:"),
                                                                 img(src = "backoff.png", height = 100, width = 600),
                                                                 br(),hr()
                                                                 )
                                                                 )
                                                                 )
                                                                 )
                                                                 ),
                              tabPanel("Slide Deck",
                                       sidebarLayout(
                                               sidebarPanel(width=3,
                                                            helpText(h5("Note:")),
                                                            helpText("This document is a slide deck consisting of 5 slides created with", 
                                                                     a("R Studio Presenter", href="https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations"),
                                                                     "pitching the algorithm and app for the sake of presenting to management or an investor. It includes:"),
                                                            helpText("1. A description of the algorithm used to make the prediction", style="color:#428ee8"),
                                                            helpText("2. Description of app and instructions of how it functions", style="color:#428ee8"),
                                                            helpText("3. Description of the experience of using this app", style="color:#428ee8"),
                                                            hr(),
                                                            h6("This App is built for:"),
                                                            a("Data Science Capstone Project (SwiftKey)", href="https://www.coursera.org/course/dsscapstone"),
                                                            p("March-April 2016"),
                                                            hr(),
                                                            h6("Contact Links for Anuar Imanbayev:"),
                                                            a(img(src = "GitHub.png", height = 30, width = 30),href="https://github.com/anuarimanbayev/datasciencecoursera/tree/master/CapstoneProject"),
                                                            a(img(src = "linkedin.png", height = 26, width = 26),href="https://www.linkedin.com/in/anuarimanbayev"),
                                                            a(img(src = "gmail.jpeg", height = 30, width = 30),href="mailto: anuar.imanbayev@gmail.com"),
                                                            br()),
                                               mainPanel(width=9,
                                                         column(8,
                                                                a(img(src = "slide1.png", height=150, width=500),href="http://rpubs.com/anuariman87/capstoneSlideDeck"),hr(),
                                                                a(img(src = "slide2.png", height=150, width=500),href="http://rpubs.com/anuariman87/capstoneSlideDeck"),hr(),
                                                                a(img(src = "slide3.png", height=150, width=500),href="http://rpubs.com/anuariman87/capstoneSlideDeck"),hr(),
                                                                a(img(src = "slide4.png", height=150, width=500),href="http://rpubs.com/anuariman87/capstoneSlideDeck"),hr(),
                                                                a(img(src = "slide5.png", height=150, width=500),href="http://rpubs.com/anuariman87/capstoneSlideDeck"),hr()
                                                         ),
                                                         column(4,
                                                                h5("Please use the slides", code("navigation bar"), 
                                                                   "on the right-bottom corner of the page."),
                                                                hr(),
                                                                h5("To browse the full version of this slides presentation,
                                                                   please visit through the following link."),
                                                                a("Capstone Slide Deck", href="http://rpubs.com/anuariman87/capstoneSlideDeck")
                                                                )
                                               )
                                               )
                                       )
                              
                   )
)