#
# latorre2014.R, 10 Nov 17
# Data from:
# Effects of Developer Experience on Learning and Applying Unit Test-Driven Development
# Roberto Latorre
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")
library("plyr")
library("reshape2")


plot_subj=function(df)
{
points(3:8, df$Time, type="b", col=pal_col[df$col_num], lwd=0.75)
}


devt=read.csv(paste0(ESEUR_dir, "developers/dev-time.csv.xz"), as.is=TRUE)

# pal_col=rainbow(max(devt$Subj_num))
pal_col=rainbow(3)

# plot(0, type="n",
# 	xlim=c(1, nrow(devt)), ylim=c(0.85, 1.4),
# 	xlab="Subject", ylab="Time")
# 
# points(sort(devt$G3), col=pal_col[1])
# points(sort(devt$G4), col=pal_col[2])
# points(sort(devt$G6), col=pal_col[3])
# points(sort(devt$G8), col=pal_col[4])

dev_long=melt(devt, id.vars=c("Subj_lev", "Subj_num", "P_cluster"),
			measure.vars=c("G3_T", "G4_T", "G5_T", "G6_T", "G7_T", "G8_T"),
			variable.name="Task", value.name="Time")

subj_lev=unique(dev_long$Subj_lev)
dev_long$col_num=as.numeric(mapvalues(dev_long$Subj_lev, subj_lev, 1:3))

plot(0.1, type="n", log="y",
	xlim=c(3, 8), ylim=c(0.88, 1.5),
	xlab="Task", ylab="Implementation time (normalised)\n")

d_ply(dev_long, .(Subj_num), plot_subj)

legend(x="topright", legend=c("Junior", "Intermediate", "Senior"), bty="n", fill=pal_col, cex=1.2)


# dev_long=melt(devt, id.vars=c("Subj_lev", "Subj_num", "P_cluster"),
# 			measure.vars=c("G3", "G4", "G5", "G6", "G7", "G8"),
# 			variable.name="Task", value.name="Time")

# The first two tasks are not included in the data,
# which has been normalised (?!?) using their values!
dev_long$Task_num=1+as.numeric(dev_long$Task)

# # t_lme=lmer(Time ~ Task+Subj_lev+(1 | Subj_num), data=dev_long)
# t_lme=lmer(Time ~ Task_num*Subj_lev+(1 | Subj_num), data=dev_long)
# summary(t_lme)

# lt_lme=lmer(log(Time) ~ Task+Subj_lev+(1 | Subj_num), data=dev_long)
# lt_lme=lmer(log(Time) ~ Task_num*Subj_lev+(1 | Subj_num), data=dev_long)
# summary(lt_lme)

# plot(0,.1 type="n",
# 	xlim=c(3, 8), ylim=c(0.85, 1.4),
# 	xlab="Task", ylab="Time")

# d_ply(dev_long, .(Subj_num), plot_subj)


