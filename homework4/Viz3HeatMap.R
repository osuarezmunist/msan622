require(tm) # corpus
require(SnowballC) # stemming
require(plyr)
require(ggplot2)
require(reshape2)

dq_source <- DirSource(
  # indicate directory
  directory = file.path("DQenC"),
  # encodingencoding = "UTF-8", 
  pattern = "*.htm", # filename pattern
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
dq_df <- data.frame(dq_matrix,
  word = rownames(dq_matrix),
  # necessary to call rowSums if have more than 1 document
  freq = rowSums(dq_matrix),
  stringsAsFactors = FALSE) 
dq_df <- dq_df[with(
  dq_df,
  order(freq, decreasing = TRUE)), ]

# Do not need the row names anymore
rownames(dq_df) <- NULL
row.names(dq_df) <- NULL




bar_df <- head(dq_df, 30)
bar_df$word <- factor(bar_df$word,
                      levels = bar_df$word,
                      ordered = TRUE)

df_melt <- melt(head(bar_df,30), id=c("word","freq"))

df_melt$variable <- factor(df_melt$variable,
                          levels = unique(df_melt$variable),
                          ordered = TRUE)


p <- ggplot(df_melt, aes(x = word, y = variable)) +
  geom_tile(aes(fill = value)) + scale_fill_gradient(low="black", high="red")+
  ggtitle("Don Quixote's Top 30 Most Frequently Appearing Word Stems by Chapter") +
  xlab("Word") + scale_y_discrete(labels=1:52)+
  ylab("Chapter") +theme(axis.text.x = element_text(angle = -45))

print(p)

ggsave(
  filename = "Viz3HeatMap.png",
  width = 10,
  height = 6,
  dpi = 100
)