#check if packages are installed
packages <- c("Rfacebook", "tm", "RColorBrewer", "wordcloud")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

#Load the neccessary libraries.
library(Rfacebook)
library(tm)
library(RColorBrewer)
library(wordcloud)
library(MASS)




#Load "Facebook Credentials"
load("fb_oauth")

getTerm_Matrix  = function(search_result){
  # Read the text file
  text <- search_result$message
  
  # Load the data as a corpus
  docs <- Corpus(VectorSource(text))
  
  #Text transformation_Replacing “/”, “@” and “|” with space
  toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  docs <- tm_map(docs, toSpace, "/")
  docs <- tm_map(docs, toSpace, "@")
  docs <- tm_map(docs, toSpace, "\\|")
  
  
  #Cleaning Data
  # Convert the text to lower case
  docs <- tm_map(docs, content_transformer(tolower))
  # Remove numbers
  docs <- tm_map(docs, removeNumbers)
  # Remove english common stopwords
  docs <- tm_map(docs, removeWords, stopwords("english"))
  
  # Remove your own stop word
  # specify your stopwords as a character vector
  #docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
  
  
  # Remove punctuations
  docs <- tm_map(docs, removePunctuation)
  
  # Eliminate extra white spaces
  docs <- tm_map(docs, stripWhitespace)
  
  #Build a term-document matrix
  dtm <- TermDocumentMatrix(docs)
  m <- as.matrix(dtm)
  v <- sort(rowSums(m),decreasing=TRUE)
  d <- data.frame(word = names(v),freq=v)
  return(d)
}