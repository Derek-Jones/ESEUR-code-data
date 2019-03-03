#
# trick93.R, 24 Feb 19
# Data from:
# What Enumeration Studies Can Show Us About Spatial Attention: {Evidence} for Limited Capacity Preattentive Processing
# Lana M. Trick and Zenon W. Pylyshyn
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human attention


source("ESEUR_config.r")


library("plyr")

plot_layout(2, 2, max_width=6.5, max_height=6.5)
par(mar=c(1.2, 4.4, 0, 0.0))

pal_col=rainbow(3)


trick=read.csv(paste0(ESEUR_dir, "developers/trick93.csv.xz"), as.is=TRUE)

plot_resp=function(df)
{
lines(df$response, col=pal_col[3-df$distractors/2])
}


plot(0, type="n", bty="o", fg="grey",
	xaxt="n", yaxt="n",
	xlim=c(0, 10), ylim=c(0, 10),
	xlab="", ylab="")

text(2, 8, "X", cex=2.2)
text(3, 3, "X", cex=2.2)
text(6, 4.5, "X", cex=2.2)
text(7.1, 7.4, "X", cex=2.2)
text(3.1, 6.2,"O", cex=2.2)
text(5, 2, "O", cex=2.2)
text(8, 6, "O", cex=2.2)

plot(trick$response, type="n", cex.axis=1.5,
	xlim=c(1, 8),
	xlab="Items", ylab="")

OX=subset(trick, symbol == "OX")
d_ply(OX, .(distractors), plot_resp)

legend(x="topleft", legend=c("4 distractors", "2 distractors", "0 distractors"), bty="n", fill=pal_col, cex=1.9)


plot(0, type="n", bty="o", fg="grey",
	xaxt="n", yaxt="n",
	xlim=c(0, 10), ylim=c(0, 10),
	xlab="", ylab="")

text(1, 8.2, "Q", cex=2.2)
text(4.5, 4.1, "Q", cex=2.2)
text(6.5, 4.8, "Q", cex=2.2)
text(8.5, 7.4, "Q", cex=2.2)
text(2.7, 3.9, "O", cex=2.2)
text(4.1, 7.0, "O", cex=2.2)
text(6.7, 7.1, "O", cex=2.2)


plot(trick$response, type="n", cex.lab=1.6,
	xlim=c(1, 8),
	xlab="Items", ylab="Response time\n")

OQ=subset(trick, symbol == "OQ")
d_ply(OQ, .(distractors), plot_resp)

legend(x="topleft", legend=c("4 distractors", "2 distractors", "0 distractors"), bty="n", fill=pal_col, cex=1.9)

