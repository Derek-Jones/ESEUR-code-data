#
# jeabehav_N1356.R, 25 Oct 16
# Data from:
# Probability Relations Within Response Sequences Under Ratio Reinforcement
# Francis Mechner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

rats=read.csv(paste0(ESEUR_dir, "developers/jeabehav_N1356.csv.xz"), as.is=TRUE)

pal_col=rainbow(length(unique(rats$Center)))

N1=subset(rats, N == 1)
N1$col=pal_col[N1$Center/4]

plot(0, type="n",
	xlim=range(N1$Offset), ylim=range(N1$Prob),
	xlab="Number of presses", ylab="Probability\n")

d_ply(N1, .(Center), function(df) lines(df$Offset, df$Prob, type="b", col=df$col))

legend(x="topright", legend=c(" 4", " 8", "12", "16"), bty="n", fill=pal_col, cex=1.2)


