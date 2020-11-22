#
# simula_0a-Anova.R,  5 Jan 16
#
# Data from:
#
# The Relationship between Customer Collaboration and Software Project Overruns
# Kjetil Mol{\o}kken-{\O}stvold and Kristian Marius Furulund
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_overrun customer_collaboration

source("ESEUR_config.r")

library("car")
library("MASS")


pal_col=rainbow(2)

sim=read.csv(paste0(ESEUR_dir, "projects/simula_0a.csv.xz"), as.is=TRUE)

sim_mod=glm(Actual ~ (Estimated+Communication+Contract+Complexity)^2,
		data=sim)
min_sim=stepAIC(sim_mod, trace=0)
#summary(min_sim)

print(Anova(min_sim))


