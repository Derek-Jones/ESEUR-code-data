#
# how-inventions.R,  2 Jun 19
# Data from:
# How Invention Begins: {Echoes} of Old Voices in the Rise of New Machines
# John H. Lienhard
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG transport_air transport_land speed year


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

air_mod=glm(log(MPH) ~ Year, data=air)
summary(air_mod)
pred=predict(air_mod)
lines(air$Year, exp(pred), col=pal_col[1])

land_mod=glm(log(MPH) ~ Year, data=land)
summary(land_mod)
pred=predict(land_mod)
lines(land$Year, exp(pred), col=pal_col[2])

