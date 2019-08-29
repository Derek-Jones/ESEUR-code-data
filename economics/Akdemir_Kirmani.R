#
# Akdemir_Kirmani.R, 20 Jul 19
# Data from:
# Synergy: {A} Synthetic Study on Teams
# Fahri Akdemir and Farooq Ahmad Kirmani
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG team performance student


source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(5)


team_means=function(df)
{
# Harmonic mean
# T_mean=(df$p1*df$p2*df$p3)^(1/3)
T_mean=(df$p1*df$p2)^(1/2)
# Harmonic mean over every member of a team
I_mean=prod(df$p4)^(1/nrow(df))

return(data.frame(T_mean, I_mean, Ip=df$p4, size=nrow(df), Indiv=df$Indiv, Exam_p=df$Exam_p,
						stringsAsFactors=FALSE))
}


ak=read.csv(paste0(ESEUR_dir, "economics/Akdemir_Kirmani.csv.xz"), as.is=TRUE)

T_mean=ddply(ak, .(Year, Team), team_means)

# length(which(T_mean$Ip > T_mean$I_mean))
plot(-200, type="n", main="",
	yaxs="i",
	xlim=range(T_mean$Ip - T_mean$T_mean), ylim=c(0, 0.036),
	xlab="Individual minus Team performance", ylab="Individuals (density)\n")

lines(c(0, 0), c(0, 0.04), col="grey")

t2=subset(T_mean, size == 2)
t3=subset(T_mean, size == 3)
t4=subset(T_mean, size == 4)
t5=subset(T_mean, size == 5)
t6=subset(T_mean, size == 6)

lines(density(t2$Ip - t2$T_mean, from=-90, to=40), col=pal_col[1])
lines(density(t3$Ip - t3$T_mean, from=-90, to=40), col=pal_col[2])
lines(density(t4$Ip - t4$T_mean, from=-90, to=40), col=pal_col[3])
lines(density(t5$Ip - t5$T_mean, from=-90, to=40), col=pal_col[4])
lines(density(t6$Ip - t6$T_mean, from=-90, to=40), col=pal_col[5])

legend(x="topleft", legend=paste0(2:6, " people"), bty="n", fill=pal_col, cex=1.3)

