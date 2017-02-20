# Set the correct working directory
setwd("C:/Users/nivibalu/Documents/capstone/project/")

# Read the blogs and twitter files
source.blogs <- readLines("en_US.blogs.txt", encoding="UTF-8")
source.twitter <- readLines("en_US.twitter.txt", encoding="UTF-8")

# Read the news file. using binary mode as there are special characters in the text
con <- file("en_US.news.txt", open="rb")
source.news <- readLines(con, encoding="UTF-8")
close(con)
rm(con)

# Binomial sampling of the data and create the relevant files
sample.fun <- function(data, percent)
{
  return(data[as.logical(rbinom(length(data),1,percent))])
}

# Remove all non english characters as they cause issues down the road
source.blogs <- iconv(source.blogs, "latin1", "ASCII", sub="")
source.news <- iconv(source.news, "latin1", "ASCII", sub="")
source.twitter <- iconv(source.twitter, "latin1", "ASCII", sub="")

# Set the desired sample percentage (we select 5% for speed)
percentage <- 0.02

sample.blogs   <- sample.fun(source.blogs, percentage)
sample.news   <- sample.fun(source.news, percentage)
sample.twitter   <- sample.fun(source.twitter, percentage)

dir.create("sample", showWarnings = FALSE)
write(sample.blogs, "sample/sample.blogs.txt")
write(sample.news, "sample/sample.news.txt")
write(sample.twitter, "sample/sample.twitter.txt")

dir.create("rdata", showWarnings = FALSE)
save(sample.blogs,sample.news,sample.twitter,file="rdata//samples.Rdata")

remove(source.blogs)
remove(source.news)
remove(source.twitter)

rm(list = ls())

gc()
