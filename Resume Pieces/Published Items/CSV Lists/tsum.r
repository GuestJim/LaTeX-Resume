time = c(sum(hour(as.period(value))),sum(minute(as.period(value))),sum(second(as.period(value))))
timesec = time[1]*3600 + time[2]*60 + time[3]
timesum = c(timesec %/% 3600, timesec %%3600 %/% 60, timesec %% 60)

timepad = sprintf("%02d",timesum)