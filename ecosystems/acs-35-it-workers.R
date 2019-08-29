#
# acs-35-it-workers.R, 23 Aug 19
# Data from:
# Occupations in Information Technology
# Julia Beckhusen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG occupation employ_age


source("ESEUR_config.r")


itw=read.csv(paste0(ESEUR_dir, "ecosystems/acs-35-it-workers.csv.xz"), as.is=TRUE)

pal_col=rainbow(ncol(itw)-3)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xaxt="n",
	xlim=c(1, nrow(itw)), ylim=c(0, max(itw[, -(1:3)])/1e3),
	xlab="Age range", ylab="Employed (thousands)\n")

axis(1, at=1:nrow(itw), labels=itw$Age)

t=sapply(4:ncol(itw), function(X) lines(itw[, X]/1e3, col=pal_col[X-3]))

# legend(x="topright", legend=colnames(itw)[-1], bty="n", fill=pal_col, cex=1.2)

