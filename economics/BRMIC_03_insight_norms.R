#
# BRMIC_03_insight_norms.R, 27 May 19
# Data from:
# Normative data for 144 compound remote associate problems
# Edward M. Bowden and Mark Jung-Beeman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human Eureka-problem word-association

source("ESEUR_config.r")


pal_col=rainbow(4)


BR=read.csv(paste0(ESEUR_dir, "economics/BRMIC_03_insight_norms.csv.xz"), as.is=TRUE)

# lg=data.frame(BR$Remote_Associate_Items,BR$Solutions,
# 	n=c(rep(89, nrow(BR)), rep(85, nrow(BR)), rep(76, nrow(BR)), rep(39, nrow(BR))),
# 	sec=c(rep(2, nrow(BR)), rep(7, nrow(BR)), rep(15, nrow(BR)), rep(30, nrow(BR))),
# 
# 	p_solved=c(BR$n89_2p_solved,BR$n85_7p_solved,BR$n76_15p_solved,BR$n39_30p_solved),
# 	time=c(rep(NA, nrow(BR)),BR$n85_7_time,BR$n76_15p_time,BR$n39_30p_time),
# 	SD=c(rep(NA, nrow(BR)),BR$n85_7_SD,BR$n76_15p_SD,BR$n39_30p_SD))

BR_2=subset(BR, sec == 2)
BR_7=subset(BR, sec == 7)
BR_15=subset(BR, sec == 15)
BR_30=subset(BR, sec == 30)

# plot(sort(BR_2$p_solved), col=pal_col[1],
# 	ylim=c(0, 100),
# 	ylab="Solved (percent)")
# points(sort(BR_7$p_solved), col=pal_col[2])
# points(sort(BR_15$p_solved), col=pal_col[3])
# points(sort(BR_30$p_solved), col=pal_col[4])

# plot(sort(BR_7$time)/7, col=pal_col[1],
# 	ylim=c(0, 1),
# 	ylab="Time (fraction)")
# points(sort(BR_15$time)/15, col=pal_col[3])
# points(sort(BR_30$time)/30, col=pal_col[4])

# ord=order(BR_7$time/BR_30$time)
# plot((BR_7$time/BR_30$time)[ord], col=pal_col[1],
# 	ylim=c(0.1, 1),
# 	xlab="Problem", ylab="Time (fraction)\n")
# points(sort(BR_15$time[ord]/BR_30$time[ord]), col=pal_col[2])
# 
# legend(x="bottomright", legend=c("7 seconds", "15 seconds"), bty="n", fill=pal_col, cex=1.2)

pal_col=rainbow(3)

plot(BR_7$p_solved, BR_7$time, col=pal_col[1],
	xlim=c(0, 100), ylim=c(3, 19),
	xlab="Solved (percent)", ylab="Time (secs)")
points(BR_15$p_solved, BR_15$time, col=pal_col[2])
points(BR_30$p_solved, BR_30$time, col=pal_col[3])

legend(x="topright", legend=rev(c(" 7 seconds", "15 seconds", "30 seconds")), bty="n", fill=rev(pal_col), cex=1.2)

for(i in c(20, 30, 60, 80, 85, 140))
   lines(c(BR_7$p_solved[i], BR_15$p_solved[i], BR_30$p_solved[i]),
         c(BR_7$time[i], BR_15$time[i], BR_30$time[i]), col=point_col)

# # A multiplicative models seems to be better
# # br_mod=glm(time ~ p_solved*sqrt(sec), data=BR)
# br_mod=glm(log(time) ~ p_solved*log(sec), data=BR)
# summary(br_mod)

