#
# Korotayev-Tsirel.R  1 Jan 17
# Data from:
# The First Update of the Maddison Project Re-Estimating Growth Before 1820
# Jutta Bolt and Jan Luiten van Zanden
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

gdp=read.csv(paste0(ESEUR_dir, "introduction/wp4-mpd_2013-01.csv.xz"), as.is=TRUE)

gdp=subset(gdp, Year >= 1870)


plot(gdp$Year, gdp$USA, type="l", col=pal_col[1],
	xlab="Year", ylab="GDP growth (%)\n")
lines(gdp$Year, gdp$W12.Europe, col=pal_col[2])

gdp_change=100*diff(gdp$USA)/head(gdp$USA, n=-1)
plot(gdp$Year[-1], gdp_change, type="l",
	xlab="Year", ylab="GDP growth (%)")

pow_gdp=spectrum(gdp_change)
plot(1/pow_gdp$freq, pow_gdp$spec, log="x", type="l")

