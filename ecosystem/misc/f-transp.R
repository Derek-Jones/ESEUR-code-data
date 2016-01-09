#
# f-transp.R, 15 Aug 15
#
# Data from:
#
# Long Waves, Technology Diffusion, and Substitution
# Arnulf Gr{\"u}bler and Neboj\u{s}a Naki{\'c}enovi{\'c}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(7)

#year,population,GDP,waterways,horses,railways,2-wheelers,buses,cars,air,TGV,walking
infra=read.csv(paste0(ESEUR_dir, "ecosystem/misc/f-transp.csv.xz"), as.is=TRUE)

plot(infra$year, infra$horses, type="l", log="y",
	col=pal_col[1],
	xlab="Year", ylab="Number (million???)",
	xlim=c(1805,1995), ylim=c(0.1, 18000))
lines(infra$year, infra$cars, col=pal_col[2])
lines(infra$year, infra$walking, col=pal_col[5])

lines(infra$year, infra$railways, col=pal_col[3])
lines(infra$year, infra$X2.wheelers, col=pal_col[4])
lines(infra$year, infra$air, col=pal_col[6])

legend(x="topleft", legend=c("horses", "cars", "railways", "2-wheelers", "walking", "air"), bty="n", fill=pal_col)

