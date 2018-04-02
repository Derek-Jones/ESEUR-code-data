#
# Business_Cycles.R  2 Apr 18
# Data from:
# http://www.ggdc.net/maddison/oriindex.htm
# Cited:
# Angus Maddison
# Business Cycles, Long Waves and Phases of Capital Development
# which contains much less data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(6)

gdp=read.csv(paste0(ESEUR_dir, "introduction/Business_Cycles.csv.xz"), as.is=TRUE)

# A World total starting from 1870
gdp$A_world=gdp$W12.Europe+gdp$W.Offshoots+
		gdp$Brazil+gdp$Chile+gdp$Uruguay+
		gdp$Japan+gdp$Sri.Lanka
		# gdp$Indonesia no data between 1942-1948
		# gdp$India data starts from 1884

gdp=subset(gdp, Year >= 1870)

# plot(gdp$Year, gdp$USA, type="l", log="y", col=pal_col[1],
# 	xlim=c(1770, 2010),
# 	xlab="Year", ylab="GDP\n")
# lines(gdp$Year, gdp$W12.Europe, col=pal_col[2])
# lines(gdp$Year, gdp$W.Offshoots, col=pal_col[3])
# lines(gdp$Year, gdp$Brazil, col=pal_col[5])
# lines(gdp$Year, gdp$Japan, col=pal_col[4])
# lines(gdp$Year, gdp$A_world, col=pal_col[6])

# gdp_change=100*diff(gdp$A_world)/head(gdp$A_world, n=-1)
gdp_change=100*(tail(gdp$A_world, n=-1)/head(gdp$A_world, n=-1)-1)
# plot(gdp$Year[-1], gdp_change, type="l",
# 	xlab="Year", ylab="GDP growth (%)")
# 
# lines(loess.smooth(gdp$Year[-1], gdp_change, span=0.1), col="red")


# igraph defines a spectrum function, and during build this is used
pow_gdp=stats::spectrum(gdp_change, plot=FALSE)
plot(1/pow_gdp$freq, pow_gdp$spec, log="x", type="l", col=point_col,
	xaxs="i", yaxs="i",
	xlab="Years", ylab="Spectral density\n")

# gdp_WWII=subset(gdp, Year <= 1940)
#
# gdp_WWIIchange=100*diff(gdp_WWII$USA)/head(gdp_WWII$USA, n=-1)
# plot(gdp_WWII$Year[-1], gdp_WWIIchange, type="l",
# 	xlab="Year", ylab="GDP growth (%)")
# 
# pow_gdp_WWII=spectrum(gdp_WWIIchange)
# plot(1/pow_gdp_WWII$freq, pow_gdp_WWII$spec, log="x", type="l")
# 
