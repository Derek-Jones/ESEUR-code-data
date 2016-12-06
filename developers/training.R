#
# training.R, 13 Nov 16
# Data from:
# https://docs.google.com/spreadsheets/d/1iMg64bjkQDaBA9O-NmjYnaNOARc20p9x878UcC9VG9s/edit?usp=sharing
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


devtime=read.csv(paste0(ESEUR_dir, "developers/training.csv.xz"), as.is=TRUE)

pal_col=rainbow(nrow(devtime))

plot_time=function(df)
{
lines(1:5, c(df$R1, df$R2, df$R3, df$R4, df$R5), col=pal_col[df$col-2])
}


plot(0, type="n",
	xlim=c(1, 5), ylim=c(0, 160),
	xlab="Round", ylab="Time (minutes)\n")

d_ply(devtime, .(Name), plot_time)

