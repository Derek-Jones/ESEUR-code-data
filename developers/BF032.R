#
# BF032.R, 16 Dec 16
# Data from:
# Michiel P. {van Oeffelen} and Peter G. Vos
# A probabilistic model for the discrimination of visual number
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(6)

human=read.csv(paste0(ESEUR_dir, "developers/BF032.csv.xz"), as.is=TRUE)

human$col=pal_col[mapvalues(human$s, c(8, 12, 16, 20, 25, 30), 1:6)]

human=human[order(human$d), ]

plot(0, type="n",
	xlim=c(-6, 6), ylim=c(0.5, max(human$p)),
	xlab="Difference (actual-target)", ylab="Probability correct\n")

d_ply(human, .(s), function(df)
			{
			is_neg=(df$d < 0)
			lines(df$d[is_neg], df$p[is_neg], type="b", col=df$col)
			lines(df$d[!is_neg], df$p[!is_neg], type="b", col=df$col)
			})

legend(x="bottomleft", legend=paste(c(8, 12, 16, 20, 25, 30), "target"), bty="n", fill=pal_col, cex=1.2)

