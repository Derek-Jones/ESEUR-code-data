#
# tb104veytsman-typo.R,  2 Dec 15
#
# Data from:
# Towards evidence-based typography: First results
# Boris Veytsman and Leyla Akhmadeeva
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")



typo=read.csv(paste0(ESEUR_dir, "group-compare/tb104veytsman-typo_data.csv.xz"), as.is=TRUE)

pal_col=rainbow(2)

serif=subset(typo, Font == "Serif")
sansserif=subset(typo, Font == "SansSerif")

serif$Standard_WPM=scale(serif$WordsPerMinute, center=FALSE)
sansserif$Standard_WPM=scale(sansserif$WordsPerMinute, center=FALSE)

plot(density(serif$Standard_WPM),
	col=pal_col[1],
	main="",
	xlim=c(0.2, 1.7), ylim=c(0, 1.6),
	xlab="Words per minute", ylab="Density")
lines(density(sansserif$Standard_WPM), col=pal_col[2])

# plot(density(serif$CorrectAnswers))
# plot(density(sansserif$CorrectAnswers))


