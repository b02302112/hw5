rm(list=ls(all.names = TRUE))
#install.packages("http://download.r-forge.r-project.org/src/contrib/tmcn_0.1-4.tar.gz", repos = NULL, type = "source")
library(tmcn)
#install.packages("rvest")
library(rvest)

URL = "https://www.ptt.cc/bbs/IA/index.html"
html = read_html(URL)
title = html_nodes(html, "a")
href = html_attr(title, "href")
data = data.frame(title = toUTF8(html_text(title)), href = href)
View(data)


getContent <- function(href)
{
  subURL = paste0("http://www.ptt.cc", href)
  subhtml = read_html(subURL)
  content = html_nodes(subhtml, "div#main-content.bbs-screen.bbs-content")
  return(toUTF8(html_text(content)))
}
#practice
#getContent(data$href[14])
#clean
data = data[-c(1:10),]
#getContent(data$href[alltext])
allText = sapply(data$href, getContent)
allText
write.table(allText, "mydata.txt")

