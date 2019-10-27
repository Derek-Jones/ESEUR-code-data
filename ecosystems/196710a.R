#
# 196710.R, 18 Oct 19
# Data from:
# Computer Time Sharing: {Its} Origins and Development
# T. James Glauthier
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG time-sharing_growth

source("ESEUR_config.r")


pal_col=rainbow(2)


multi=read.csv(paste0(ESEUR_dir, "ecosystems/196710a.csv.xz"), as.is=TRUE)

plot(1900+multi$Year, multi$Systems, log="y", col=pal_col[1],
	ylim=c(1, 45),
	xlab="Date", ylab="Time-sharing systems\n")

sys_mod=glm(log(Systems) ~ Year, data=multi)

pred=predict(sys_mod)

lines(1900+multi$Year, exp(pred), col=pal_col[2])

