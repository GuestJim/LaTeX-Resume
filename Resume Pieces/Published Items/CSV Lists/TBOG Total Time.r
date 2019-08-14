library(readr)
library(lubridate)

results <- read_csv("TBOG Videos.csv")

time = function(value) {
	c(sum(hour(as.period(value))),sum(minute(as.period(value))),sum(second(as.period(value))))
}

timesec = function(Tvalue) {
	Tvalue[1]*3600 + Tvalue[2]*60 + Tvalue[3]
}

timepad = function(timesec) {
	sprintf("%02d",c(timesec %/% 3600, timesec %%3600 %/% 60, timesec %% 60))
}

PULS = results[which(results$Overlay == "Pulse"),]
GAZE = results[which(results$Overlay == "Gaze"),]
BOTH = results[which(results$Overlay == "Both"),]

Tall = time(results$Time)
TPall = timepad(timesec(Tall))
#	Total time

Pall = time(PULS$Time)
PPall = timepad(timesec(Pall))
#	Pulse only

Gall = time(GAZE$Time)
GPall = timepad(timesec(Gall))
#	Gaze only

Ball = time(BOTH$Time)
BPall = timepad(timesec(Ball))
#	Both only

PBall = time(c(PULS$Time, BOTH$Time))
PBPall = timepad(timesec(PBall))
#	Pulse and Both

GBall = time(c(GAZE$Time, BOTH$Time))
GBPall = timepad(timesec(GBall))
#	Gaze and Both


sink("TBOG Summary.txt", split=TRUE)
writeLines(paste("All Videos - ",sum(results$Videos), " -- Games - ", nrow(results), sep=''))
#writeLines(paste(TPall[1],TPall[2],TPall[3], sep=":"), sep='')
sink("TBOG Length.txt", split=TRUE)
	writeLines(paste(TPall[1],TPall[2],TPall[3], sep=":"), sep='')
sink()
writeLines("\n")

writeLines(paste("Heart Rate Videos - ", sum(PULS$Videos), " -- Games - ", nrow(PULS), sep=''))
writeLines(paste(PPall[1], PPall[2], PPall[3], sep=":"), sep='')
writeLines("\n")

writeLines(paste("Gaze Tracking Videos - ",sum(GAZE$Videos), " -- Games - ", nrow(GAZE), sep=''))
writeLines(paste(GPall[1], GPall[2], GPall[3], sep=":"), sep='')
writeLines("\n")

writeLines(paste("Both Heart Rate and Gaze Tracking Videos - ",sum(BOTH$Videos), " -- Games - ", nrow(BOTH), sep=''))
writeLines(paste(BPall[1], BPall[2], BPall[3], sep=":"), sep='')
writeLines("\n")

writeLines("Combined with Both")
writeLines(paste("All Heart Rate Videos - ", sum(c(PULS$Videos, BOTH$Videos)), " -- Games - ", nrow(PULS) + nrow(BOTH), sep=''))
writeLines(paste(PBPall[1], PBPall[2], PBPall[3], sep=":"), sep='')
writeLines("\n")

writeLines(paste("All Gaze Tracking Videos - ", sum(c(GAZE$Videos, BOTH$Videos)), " -- Games - ", nrow(GAZE) + nrow(BOTH), sep=''))
writeLines(paste(GBPall[1], GBPall[2], GBPall[3], sep=":"), sep='')
writeLines("\n")

sink()