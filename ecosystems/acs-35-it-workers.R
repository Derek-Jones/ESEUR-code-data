#
# acs-35-it-workers.R, 21 Nov 17
# Data from:
# Occupations in Information Technology
# Julia Beckhusen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


itw=read.csv(paste0(ESEUR_dir, "ecosystems/acs-35-it-workers.csv.xz"), as.is=TRUE)

pal_col=rainbow(ncol(itw)-3)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xaxt="n",
	xlim=c(1, nrow(itw)), ylim=c(0, max(itw[, -(1:3)])),
	xlab="Age range", ylab="Employed")

axis(1, at=1:nrow(itw), labels=itw$Age)

t=sapply(4:ncol(itw), function(X) lines(itw[, X], col=pal_col[X-3]))

