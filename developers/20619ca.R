#
# 20619ca.R, 20 Feb 19
# Data from:
# THE SERIAL POSITION EFFECT OF FREE RECALL
# Bennet B. Murdoch, Jr
# via
# A Temporal Ratio Model of Memory
# Gordon D. A. Brown and Ian Neath and Nick Chater
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human subjects memory

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(6)

#visible,position,probability
recall=read.csv(paste0(ESEUR_dir, "developers/20619brown.csv.xz"), as.is=TRUE)

# There are two lists of length 20
recall$vis_len=paste0(recall$length, "_", recall$visible)
list_len=unique(recall$vis_len)

recall$col_str=mapvalues(recall$vis_len, list_len, pal_col)

plot(0, type="n",
	yaxs="i",
	xlim=c(1, 40), ylim=c(0, 1),
	xlab="Serial position", ylab="Recall probability\n")

d_ply(recall, .(vis_len), function(df)
			lines(1:nrow(df), df$recall, type="b", col=df$col))

# legend(x="bottomright", legend=list_len, bty="n", fill=pal_col, cex=1.2)

