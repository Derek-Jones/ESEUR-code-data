#
# 2018_005_tf.R, 21 Aug 20
# Data from:
# Composing Effective Software Security Assurance Workflows
# William R. Nichols and James D. McHale and David Sweeney and William Snavely and Aaron Volkman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


library("lubridate")
library("plyr")



# Cumulative hours for an individual
pweek_time=function(df)
{
lines(df$wnum, cumsum(df$V1)/60, col=pal_col[df$pnum])
}


# Fit a straight line to person's cumulative work time
fit_person=function(person_n)
{
pi7=subset(person_wtime, pnum == person_n)
pi7$csum=cumsum(pi7$V1)

pi7_mod=glm(csum ~ wnum, data=pi7)
# print(summary(pi7_mod))

pred=predict(pi7_mod)
lines(pi7$wnum, pred/60, col="grey", lty=2)
}


# project_key     foreign key, unique project ID
# person_key      foreign key, unique developer ID
# team_key        foreign key, unique team ID
# wbs_element_key foreign key, unique work breakdown structure element ID
# plan_item_key   foreign key, unique  ID for the planned item associated with the task
# task_actual_start_date  time stamp for first work on task
# task_actual_complete_date       time stame when task was completed
# task_actual_time_minutes        total effort actually logged for the task
# task_plan_time_minutes  total effort planned for the task
# phase_key       unique key for the process phase in which the task work was done
# phase_short_name        readable name for process workflow phase
# process_name    readable name for process workflow

tf=read.csv(paste0(ESEUR_dir, "projects/2018_005_tf.csv.xz"), as.is=TRUE)

tf$start_date=as.Date(tf$task_actual_start_date, format="%m/%d/%Y")
tf$end_date=as.Date(tf$task_actual_complete_date, format="%m/%d/%Y")

p615=subset(tf, project_key == 615) # 14,005 entries

p615$year=year(p615$start_date)
p615$week=week(p615$start_date)

p615=subset(p615, year >= 2010) # remove 2008 'mistake'

u_person=unique(p615$person_key)
p615$pnum=mapvalues(p615$person_key, u_person, 1:length(u_person))
p615$wnum=(p615$year-2010)*52+p615$week-20

sd=count(p615$start_date)


person_time=ddply(p615, .(person_key), function(df) sum(df$task_actual_time_minutes))

person_pday=ddply(p615, .(start_date), function(df) length(unique(df$person_key)))

person_wtime=ddply(p615, .(wnum, pnum),
				function(df)
				   sum(df$task_actual_time_minutes))

pal_col=rainbow(length(u_person))

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 235), ylim=c(0, 3200),
	xlab="Weeks", ylab="Individual time on project (hours)\n")

d_ply(person_wtime, .(pnum), pweek_time)

# 26  33  27  31  18  23   2  28 
# 91  92  99 101 114 119 134 147 
#  8   9   1  12  15   3   7 
#153 171 180 181 190 198 209 

fit_person(7)
fit_person(3)
fit_person(8)

