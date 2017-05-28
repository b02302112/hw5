rm(list=ls(all.names = TRUE))
library(NLP)
library(tm)
library(jiebaRD)
library(jiebaR)
library(RColorBrewer)
library(wordcloud)
filenames <- list.files(getwd(), pattern="*.txt")
files <- lapply(filenames, readLines)
docs <- Corpus(VectorSource(files)) #Corpus是一種文字檔資料格式--文本
#移除可能有問題的符號-Corpus文本清理與改寫
toSpace <- content_transformer(function(x, pattern) {
  return (gsub(pattern, " ", x))
}
)
docs <- tm_map(docs, toSpace, "的")
docs <- tm_map(docs, toSpace, "發信站")
docs <- tm_map(docs, toSpace, "文章")
docs <- tm_map(docs, toSpace, "作者")
docs <- tm_map(docs, toSpace, "推")
docs <- tm_map(docs, toSpace, "了")
docs <- tm_map(docs, toSpace, "不")
docs <- tm_map(docs, toSpace, "也")
docs <- tm_map(docs, toSpace, "都")
docs <- tm_map(docs, toSpace, "在")
docs <- tm_map(docs, toSpace, "有")
docs <- tm_map(docs, toSpace, "就")
docs <- tm_map(docs, toSpace, "會")
docs <- tm_map(docs, toSpace, "跟")
docs <- tm_map(docs, toSpace, "沒")
docs <- tm_map(docs, toSpace, "到")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "他")
docs <- tm_map(docs, toSpace, "們")
docs <- tm_map(docs, toSpace, "說")
docs <- tm_map(docs, toSpace, "與")
docs <- tm_map(docs, toSpace, "上")
docs <- tm_map(docs, toSpace, "對")
docs <- tm_map(docs, toSpace, "但")
docs <- tm_map(docs, toSpace, "只")
docs <- tm_map(docs, toSpace, "還")
docs <- tm_map(docs, toSpace, "和")
docs <- tm_map(docs, toSpace, "或")
docs <- tm_map(docs, toSpace, "從")
docs <- tm_map(docs, toSpace, "以")
docs <- tm_map(docs, toSpace, "被")
docs <- tm_map(docs, toSpace, "讓")
docs <- tm_map(docs, toSpace, "將")
docs <- tm_map(docs, toSpace, "更")
docs <- tm_map(docs, toSpace, "為")
docs <- tm_map(docs, toSpace, "這個")
docs <- tm_map(docs, toSpace, "‧")
docs <- tm_map(docs, toSpace, "我")
docs <- tm_map(docs, toSpace, "是")
docs <- tm_map(docs, toSpace, "看板")
docs <- tm_map(docs, toSpace, "網址")
docs <- tm_map(docs, toSpace, "標題")
docs <- tm_map(docs, toSpace, "來")
docs <- tm_map(docs, toSpace, "批踢踢實業坊")
docs <- tm_map(docs, toSpace, "[a-zA-Z]")
#移除標點符號(punctuation)
#移除數字跟空白(digits) (white space)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, stripWhitespace)

#segment 使用範例：
#library(jiebaRD)
#library(jiebaR)
#mixseg = worker()
#segment("新聞資料處理與視覺呈現是一門好課", mixseg)
#[1] "新聞資料" "處理"     "與"       "視覺"     "呈現"     "是"       "一門"     "好課"

mixseg = worker()
jieba_tokenizer=function(d){
  unlist(segment(d[[1]],mixseg))
}
seg = lapply(docs, jieba_tokenizer)

freqFrame = as.data.frame(table(unlist(seg)))
freqFrame = freqFrame[order(freqFrame$Freq,decreasing=TRUE), ]
head(freqFrame)
library(knitr)
kable(head(freqFrame), format = "markdown")

#文字雲
par(family=("Heiti TC Light"))
wordcloud(freqFrame$Var1,freqFrame$Freq,
          scale=c(5,0.1),min.freq=20,max.words=180,
          random.order=TRUE, random.color=FALSE,
          rot.per=.1, colors=brewer.pal(8, "Dark2"),
          ordered.colors=FALSE,use.r.layout=FALSE,
          fixed.asp=TRUE)
