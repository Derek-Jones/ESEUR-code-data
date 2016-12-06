#
# viability.R, 10 Jan 15
#
# Data from:
#
# Joseph David Lucente
# On the Viability of Quantitative Assessment Methods in Software Engineering and Software Services
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


viability=read.csv(paste0(ESEUR_dir, "faults/viability.csv.xz"), as.is=TRUE)

plot(viability$installs, viability$incidents, log="xy", col=point_col,
	xlab="Installs", ylab="Incidents\n")

# viab_mod=glm(incidents ~ installs, data=viability)
# summary(viab_mod)
# 
# viab_lmod=glm(log(incidents) ~ log(installs), data=viability)
# summary(viab_lmod)

