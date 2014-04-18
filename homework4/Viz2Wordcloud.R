require(wordcloud) 
require(tm) # corpus
require(ggplot2)
require(SnowballC) # stemming

dq_source <- DirSource(
  # indicate directory
  directory = file.path("DQen"),
  # encodingencoding = "UTF-8", 
  pattern = "*.txt", # filename pattern
  recursive = FALSE, # visit subdirectories?
  ignore.case = FALSE) # ignore case in pattern?

dq_corpus <- Corpus(
  dq_source,
  readerControl = list(
    reader = readPlain, # read as plain text
    language = "en")) # 

dq_corpus <- tm_map(dq_corpus, tolower)

dq_corpus <- tm_map(
  dq_corpus,
  removePunctuation,
  preserve_intra_word_dashes = TRUE)

dq_corpus <- tm_map(
  dq_corpus,
  removeWords,
  stopwords("english"))

# Remove specific words
dq_corpus <- tm_map(
  dq_corpus,
  removeWords,
  c("the","meta","-"))

# getStemLanguages()
dq_corpus  <- tm_map(
  dq_corpus,
  stemDocument,
  lang = "english") #

dq_corpus <- tm_map(
  dq_corpus,
  stripWhitespace)

# Remove specific words
dq_corpus <- tm_map(
  dq_corpus,
  removeWords,
  c("the","meta","-"))


dq_tdm <- TermDocumentMatrix(dq_corpus)
dq_matrix <- as.matrix(dq_tdm)
dq_df <- data.frame(
  word = rownames(dq_matrix),
  # necessary to call rowSums if have more than 1 document
  freq = rowSums(dq_matrix),
  stringsAsFactors = FALSE) 
dq_df <- dq_df[with(
  dq_df,
  order(freq, decreasing = TRUE)), ]

# Do not need the row names anymore
rownames(dq_df) <- NULL

png(
  file.path(".", "Viz2Wordcloud.png"),
  width = 600,
  height = 600)

wordcloud(
  dq_df$word,
  dq_df$freq,
  scale = c(6, .5), # size of words
  min.freq = 150, # drop infrequent
  max.words = 300, # max words in plot
  random.order = FALSE, # plot by frequency
  rot.per = 0.3, # percent rotated
  # set colors
  # colors = brewer.pal(9, "GnBu")
  colors = brewer.pal(12, "Paired"),
  # color random or by frequency
  random.color = TRUE,
  # use r or c++ layout
  use.r.layout = FALSE
)


 dev.off()