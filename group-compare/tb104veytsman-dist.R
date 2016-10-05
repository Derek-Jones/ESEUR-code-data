#
# tb104veytsman-dist.R, 21 Sep 16
#
# Data from:
# Towards evidence-based typography: First results
# Boris Veytsman and Leyla Akhmadeeva
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("dgof")
library("kSamples")
library("WRS")


typo=read.csv(paste0(ESEUR_dir, "group-compare/tb104veytsman-typo_data.csv.xz"), as.is=TRUE)

pal_col=rainbow(2)

serif=subset(typo, Font == "Serif")
sansserif=subset(typo, Font == "SansSerif")

serif$Standard_WPM=scale(serif$WordsPerMinute)
sansserif$Standard_WPM=scale(sansserif$WordsPerMinute)


# From WRS
ks(serif$Standard_WPM, sansserif$Standard_WPM)
# In fact unscaled measurements give the same result, i.e., not different
ks(serif$WordsPerMinute, sansserif$WordsPerMinute)


# dgof::ks.test uses stats::ecdf internally, but without the qualified name.
# WRS defines its own ecdf function, so both packages do not coexist!
# One of the arguments has to be the empirical cumulative distribution function

unloadNamespace("WRS")
# detach("package:WRS", unload=TRUE)
dgof::ks.test(serif$Standard_WPM,
	ecdf(sansserif$Standard_WPM))

# From base system
ks.test(serif$Standard_WPM,
	sansserif$Standard_WPM)

# Only applicable to continuous distributions
ad.test(serif$Standard_WPM, sansserif$Standard_WPM)


# plot(ecdf(serif$WordsPerMinute),
# 	main="",
# 	xlim=c(50, 350))
# par(new=TRUE)
# plot(ecdf(sansserif$WordsPerMinute), col="red",
# 	main="",
# 	xlim=c(50, 350))

