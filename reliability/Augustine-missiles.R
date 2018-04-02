#
# Augustine-missiles.R, 31 Dec 17
# Data from:
# Augustine's Laws
# Norman R. Augustine
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


missile=read.csv(paste0(ESEUR_dir, "reliability/Augustine-missiles.csv.xz"), as.is=TRUE)

plot(missile$unit_cost, missile$dev_flights, log="xy", col=pal_col[1],
	xlab="Unit cost ($)", ylab="Development flights\n")

m_mod=glm(log(dev_flights) ~ log(unit_cost), data=missile)

pred=predict(m_mod)

lines(missile$unit_cost, exp(pred), col=pal_col[2])

