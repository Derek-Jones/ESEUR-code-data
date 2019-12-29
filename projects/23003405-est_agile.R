#
# 23003405-est_agile.R, 12 Dec 19
# Data from:
# Combining Data Analytics with Team Feedback to Improve the Estimation Process in Agile Software Development
# Antonio Vetro\`{o} and Rupert D{\"u}rre and Marco Conoscenti and Daniel M\'{e}ndez Fern\'{a}ndez and Magne J{\o}rgensen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG story-point_time-taken agile_estimate

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)

sum_sprint=function(df)
{
return(data.frame(story_s=sum(df$Story.Points),
		  time_s=sum(df$Overall.Time)))
}


ea=read.csv(paste0(ESEUR_dir, "projects/23003405-est_agile.csv.xz"), as.is=TRUE)

#  ts0=subset(ss, Time.Spent == 0)
#  table(ts0$Resolution)
# 
#     Done Duplicate     Fixed 
#        1         1       130 
#  table(ts0$Project)
#
#   P1 P2 P3 
#   77 11 44 

# There are 17+ instances of stories spanning multiple sprints
# table(ss$Sprint)

ea$Overall.Time=ea$Time.Spent+ea$SubTask.Time

ea$Sprint_num=as.numeric(ea$Sprint)
ea=subset(ea, Story.Points < 50)

ss=subset(ea, Sprint_num > 0)
ss=subset(ss, Story.Points > 0)
ss=subset(ss, Time.Spent > 0)

# plot(ss$Story.Points, ss$Overall.Time, log="xy")

# ts_mod=glm(Overall.Time ~ I(Story.Points^0.8)*Sub.Tasks-Sub.Tasks+Project, data=ss)
# summary(ts_mod)
# 
# mts_mod=glm(log(Overall.Time) ~ log(Story.Points)*I(Sub.Tasks^0.5)+Project, data=ss)
# summary(mts_mod)

P1=subset(ea, Project == "P1")

# plot(P1$Sprint_num, P1$Overall.Time/P1$Story.Points, log="y")
# 
# plot(P1$Sprint_num, P1$Story.Points, col=point_col,
# 	xlab="Sprint", ylab="Story points\n")
# 
# plot(P1$Story.Points, P1$Overall.Time, log="xy", col=point_col,
# 	xlab="Story points", ylab="Overall time\n")

st_p_sp=ddply(P1, .(Sprint_num), sum_sprint)

plot(st_p_sp$Sprint_num, st_p_sp$time_s, col=pal_col[1],
	xaxs="i", yaxs="i",
	ylim=c(0, 400),
	xlab="Sprint", ylab="Totals\n")
points(st_p_sp$Sprint_num, st_p_sp$story_s, col=pal_col[2])

legend(x="topright", legend=c("Hours", "Story points"), bty="n", fill=pal_col, cex=1.2)


# plot(st_p_sp$Sprint_num, st_p_sp$story_s/st_p_sp$time_s, col=pal_col[1],
# 	ylim=c(0, 1),
# 	xlab="Sprint", ylab="Story points/Time (for Sprint)\n")

