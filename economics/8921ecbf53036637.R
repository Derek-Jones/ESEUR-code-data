#
# 8921ecbf53036637.R, 8 Jun 20
# Data from:
# Note on the Drawing Power of Crowds of Different Size
# Stanley Milgram and Leonard Bickman and Lawrence Berkowitz
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human group-size


source("ESEUR_config.r")


library("betareg")


pal_col=rainbow(2)


mil=read.csv(paste0(ESEUR_dir, "economics/8921ecbf53036637.csv.xz"), as.is=TRUE)

mil$frac=mil$percent/100

pstop=subset(mil, action == "stop")
plookup=subset(mil, action == "lookup")

plot(0, type="n",
	xaxs="i", yaxs="i",
	xaxt="n",
	xlim=c(1, 15), ylim=c(0, 100),
	xlab="Crowd size", ylab="Passers-by (percent)\n")

crowd_size=c(1:5, 10, 15)
axis(1, at=crowd_size)

points(pstop$crowd_size, pstop$percent, col=pal_col[2])
points(plookup$crowd_size, plookup$percent, col=pal_col[1])

legend(x="right", legend=c("Looking up", "Stopping"), bty="n", fill=pal_col, cex=1.2)


lu_mod=betareg(frac ~ crowd_size, data=plookup)
# summary(lu_mod)

pred=predict(lu_mod)
lines(plookup$crowd_size, pred*100, col=pal_col[1])

st_mod=betareg(frac ~ crowd_size, data=pstop)
# summary(st_mod)

pred=predict(st_mod)
lines(plookup$crowd_size, pred*100, col=pal_col[2])


