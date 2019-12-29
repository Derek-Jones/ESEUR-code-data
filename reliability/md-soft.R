#
# md-soft.r,  6 Nov 19
# Data from:
# FDA...
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG hardware_medical FDA_software

source("ESEUR_config.r")


library(plyr)


md=read.csv(paste0(ESEUR_dir, "reliability/md-soft.csv.xz"), as.is=TRUE)
# str(m)

md$date=as.Date(md$DECISIONDATE, format="%m/%d/%Y")

ud=ddply(md, .(PMANUMBER), function(df) min(df$date))

plot(sort(ud$V1), 1:nrow(ud), col=point_col,
	yaxs="i",
	xlab="Date", ylab="Medical devices involving software\n")


