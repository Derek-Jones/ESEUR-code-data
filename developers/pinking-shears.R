#
# pinking-shears.R, 28 Jan 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# So things look ok when scaled down
plot_wide()

pal_col=rainbow(11)

# x,y points from a digitized image
pink=read.csv(paste0(ESEUR_dir, "developers/pinking-shears.csv.xz"), as.is=TRUE)

plot(pink, type="n", bty="n", xaxt="n", yaxt="n",
	xlab="", ylab="")

lines(pink[1:26,], col=pal_col[1])
lines(pink[39:51,], col=pal_col[3])

lines(rbind(pink[54:66,], pink[rev(119:140),], pink[1, ], pink[93:94, ], pink[27:38, ], pink[39, ], pink[54, ]), col=pal_col[2])

# lines(pink[39:53,], col=pal_col[3])
lines(pink[51:53,], col=pal_col[4])
# lines(pink[54:66,], col=pal_col[4])
lines(rbind(pink[54, ], pink[67:92,]), col=pal_col[5])
# lines(pink[93:94,], col=pal_col[6])
lines(rbind(pink[95:112,], pink[95, ]), col=pal_col[6])
lines(pink[113:118,], col=pal_col[7])
# lines(pink[119:140,], col=pal_col[8])
lines(rbind(pink[141:151,], pink[141, ]), col=pal_col[8])
lines(pink[152:173,], col=pal_col[9])
lines(pink[174:180,], col=pal_col[10])

lines(pink[181:204,], col=pal_col[11])

