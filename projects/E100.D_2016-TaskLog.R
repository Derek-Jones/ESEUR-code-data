#
# E100.D_2016-TaskLog.R, 11 Oct 19
# Data from:
# Industry Application of Software Development Task Measurement System: {TaskPit}
# Pawin Suthipornopas and Pattara Leelaprute and Akito Monden and Hidetake Uwano and Yasutaka Kamei and Naoyasu Ubayashi and Kenji Araki and Kingo Yamada and Ken-ichi Matsumoto
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_activities


source("ESEUR_config.r")


library("plyr")


hrminsec_to_secs=function(df)
{
tim=unlist(strsplit(df, ":"))
tim=subset(tim, rep(c(FALSE, TRUE), nrow(E100)))
return(3600*as.numeric(substr(tim, 1, 2))+
	60*as.numeric(substr(tim, 3, 4))+
	as.numeric(substr(tim, 5, 6)))
}

# Eight hours of activity for one person
E100=read.csv(paste0(ESEUR_dir, "projects/E100.D_2016-TaskLog.csv.xz"), as.is=TRUE)

E100$s_time=hrminsec_to_secs(E100$start.time)
E100$e_time=hrminsec_to_secs(E100$end.time)
E100$duration=E100$e_time-E100$s_time

# Get total seconds for each activity
act_time=ddply(E100, .(Task.name), function(df) sum(df$duration))
act_time$percent=100*act_time$V1/sum(act_time$V1)


# How many changes of task?
task_chng=rle(E100$Task.name)
str(task_chng)

