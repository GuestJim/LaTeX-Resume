library(readr)
library(lubridate)

results <- read_csv("Reviews - Released.csv", na=character())

time = function(value) {
	PTime = results[value$PlayTime != "", ]$PlayTime
	temp = matrix(sapply(sapply(strsplit(PTime, ":"), as.character), as.numeric), ncol = 3, byrow = TRUE)
}

timesec = function(Tvalue) {
	Tvalue %*% matrix(c(3600, 60, 1))
}

timepad = function(timesec) {
	sprintf("%02d",c(timesec %/% 3600, timesec %%3600 %/% 60, timesec %% 60))
}

Tall = time(results)
TPall = timepad(sum(timesec(Tall)))

YT = results[results$YTPlaythrough != "", ]
YTall = matrix(sapply(sapply(strsplit(YT$PlayTime, ":"), as.character), as.numeric), ncol = 3, byrow = TRUE)
YTPall = timepad(sum(timesec(YTall)))


sink("Review Summary.txt", split=TRUE)
writeLines(paste("All Reviews - ", nrow(results), sep=''))
writeLines(paste(TPall[1], TPall[2], TPall[3], sep=':'))
writeLines("\n")

writeLines(paste("Captured Playthroughs - ", nrow(YT), sep=''))
writeLines(paste(YTPall[1], YTPall[2], YTPall[3], sep=':'))
#writeLines("\n")
sink()
