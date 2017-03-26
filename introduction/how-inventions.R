#
# how-inventions.R, 15 Mar 17
# Data from:
# How Invention Begins: {Echoes} of Old Voices in the Rise of New Machines
# John H. Lienhard
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

inven=read.csv(paste0(ESEUR_dir, "introduction/how-inventions.csv.xz"), as.is=TRUE)

air=subset(inven, Location == "Air")
land=subset(inven, Location == "Surface")

plot(air$Year, air$MPH, log="y", col=pal_col[1],
	xlim=range(inven$Year), ylim=range(inven$MPH),
	xlab="Year", ylab="Speed (MPH)\n")
points(land$Year, land$MPH, col=pal_col[2])

legend(x="topleft", legend=c("Air transport", "Surface transport"), bty="n", fill=pal_col, cex=1.2)

