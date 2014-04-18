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


bar_df <- head(dq_df,20)
bar_df$word <- factor(bar_df$word,
                      levels = bar_df$word,
                      ordered = TRUE)

p <- ggplot(bar_df, aes(x = word, y = freq)) +
  geom_bar(stat = "identity", fill = "grey60") +
  ggtitle("Don Quixote of La Mancha Most Frequently Appearing Words") +
  xlab("Top 20 Word Stems (Stop Words Removed)") +
  ylab("Frequency") +
  theme_minimal() +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  theme(panel.grid = element_blank()) +
  theme(axis.ticks = element_blank())

print(p)

ggsave(
  filename = "Viz1ScatterPlot.png",
  width = 10,
  height = 6,
  dpi = 100
)