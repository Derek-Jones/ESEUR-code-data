#
# Effectsofgroupsize_Peltokorpi.R, 10 Dec 18
# Data from:
# Effects of group size and learning on manual assembly performance: an experimental study
# Jaakko Peltokorpi and Esko Niemi
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment subjects learning group

source("ESEUR_config.r")


library("lme4")
library("plyr")


plot_layout(2, 1)


pelt=read.csv(paste0(ESEUR_dir, "projects/Effectsofgroupsize_Peltokorpi.csv.xz"), as.is=TRUE)

max_rep=max(pelt$Repetition)
pal_col=rainbow(max_rep)

plot(pelt$Group.size, pelt$Time, type="n",
	lab=c(4, 4, 7), # Stop x.5 points being labeled
	xlab="Group size", ylab="Time (hours)\n")

d_ply(pelt, .(Repetition), function(df) points(df$Group.size, df$Time,
						col=pal_col[df$Repetition[1]]))

# grp_mod=glm(Time ~ I(1/Group.size)*log(Repetition), data=pelt)
grp_mod=lmer(Time ~ I(1/Group.size)*log(Repetition)+(Repetition | Group.id),
								 data=pelt)
summary(grp_mod)

dummy=sapply(1:max_rep, function(X)
			{
			pred=predict(grp_mod, newdata=data.frame(Group.size=1:4,
						 		Repetition=X),
					re.form=NA) # No random effects
			lines(1:4, pred, col=pal_col[X])
			})

legend(x="topright", legend=paste0("Repetition = ", 1:4), bty="n", fill=pal_col, cex=1.2)

plot(pelt$Repetition, pelt$Time, type="n",
	lab=c(4, 4, 7), # Stop x.5 points being labeled
	xlab="Repetitions", ylab="Time (hours)\n")

d_ply(pelt, .(Group.size), function(df) points(df$Repetition, df$Time,
						col=pal_col[df$Group.size[1]]))

dummy=sapply(1:max_rep, function(X)
			{
			pred=predict(grp_mod, newdata=data.frame(Group.size=X,
						 		Repetition=1:4),
					re.form=NA) # No random effects
			lines(1:4, pred, col=pal_col[X])
			})

legend(x="topright", legend=paste0("Group size = ", 1:4), bty="n", fill=pal_col, cex=1.2)

