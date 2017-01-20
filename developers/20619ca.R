#
# 20619ca.R, 17 Dec 16
# Data from:
# THE SERIAL POSITION EFFECT OF FREE RECALL
# Bennet B. Murdoch, Jr
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(6)

#length,position,probability
recall=read.csv(paste0(ESEUR_dir, "developers/20619ca.csv.xz"), as.is=TRUE)

list_len=unique(recall$length)

recall$col=pal_col[as.integer(mapvalues(recall$length, list_len, 1:6))]

plot(0, type="n",
	xlim=c(1, 40), ylim=c(0, 1),
	xlab="Serial position", ylab="Recall probability\n")

d_ply(recall, .(length), function(df)
			lines(df$position, df$probability, type="b", col=df$col))

legend(x="bottomright", legend=list_len, bty="n", fill=pal_col, cex=1.2)

