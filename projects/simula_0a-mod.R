#
# simula_0a-mod.R,  6 Jan 16
#
# Data from:
#
# The Relationship between Customer Collaboration and Software Project Overruns
# Kjetil Mol{\o}kken-{\O}stvold and Kristian Marius Furulund
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("car")
library("MASS")


sim=read.csv(paste0(ESEUR_dir, "projects/simula_0a.csv.xz"), as.is=TRUE)


# sim_mod=glm(Actual ~ (Estimated+Communication+Contract+Cust_Score+Complexity+Knowledge)^2,
# sim_mod=glm(Actual ~ (Estimated+Communication+Contract+Complexity)^2,
#		data=sim)
#min_sim=stepAIC(sim_mod)
#summary(min_sim)
#Anova(min_sim)

# sim_mod=glm(Actual ~ (Estimated+Communication+Contract)^2,
#		data=sim)
#min_sim=stepAIC(sim_mod)
#Anova(min_sim)

# sim_mod=glm(Actual ~ Estimated+Communication+Contract+Communication:Contract,
sim_mod=glm(Actual ~ Estimated+Communication+Communication:Contract,
		data=sim)
summary(sim_mod)

sim_mod=glm(Actual ~ Estimated+Estimated:Communication+Communication:Contract,
		data=sim)
summary(sim_mod)

sim_mod=glm(Actual ~ Estimated+Estimated:Communication, data=sim)
summary(sim_mod)


