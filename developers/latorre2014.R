#
# latorre2014.R, 21 Jul 17
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
points(df$Time, type="b", col=pal_col[df$Subj_num])
}


devt=read.csv(paste0(ESEUR_dir, "developers/dev-time.csv.xz"), as.is=TRUE)

pal_col=rainbow(max(devt$Subj_num))

plot(0, type="n",
	xlim=c(1, nrow(devt)), ylim=c(0.85, 1.4),
	xlab="Subject", ylab="Time")

points(sort(devt$G3), col=pal_col[1])
points(sort(devt$G4), col=pal_col[2])
points(sort(devt$G6), col=pal_col[3])
points(sort(devt$G8), col=pal_col[4])

dev_long=melt(devt, id.vars=c("Subj_lev", "Subj_num", "P_cluster"),
			measure.vars=c("G3_T", "G4_T", "G5_T", "G6_T", "G7_T", "G8_T"),
			variable.name="Task", value.name="Time")

plot(0, type="n", log="y",
	xlim=c(1, 6), ylim=c(0.85, 1.6),
	xlab="Task", ylab="Time")

d_ply(dev_long, .(Subj_num), plot_subj)

dev_long=melt(devt, id.vars=c("Subj_lev", "Subj_num", "P_cluster"),
			measure.vars=c("G3", "G4", "G5", "G6", "G7", "G8"),
			variable.name="Task", value.name="Time")

dev_long$Task_num=as.numeric(dev_long$Task)

# t_lme=lmer(Time ~ Task+Subj_lev+(1 | Subj_num), data=dev_long)
t_lme=lmer(Time ~ Task_num*Subj_lev+(1 | Subj_num), data=dev_long)
summary(t_lme)

# lt_lme=lmer(log(Time) ~ Task+Subj_lev+(1 | Subj_num), data=dev_long)
# lt_lme=lmer(log(Time) ~ Task_num*Subj_lev+(1 | Subj_num), data=dev_long)
# summary(lt_lme)

plot(0, type="n",
	xlim=c(1, 6), ylim=c(0.85, 1.4),
	xlab="Task", ylab="Time")

d_ply(dev_long, .(Subj_num), plot_subj)


