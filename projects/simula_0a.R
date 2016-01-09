#
# simula_0a.R,  5 Jan 16
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


pal_col=rainbow(2)

sim=read.csv(paste0(ESEUR_dir, "projects/simula_0a.csv.xz"), as.is=TRUE)


# sim_mod=glm(Actual ~ (Estimated+Communication+Contract+Cust_Score+Complexity+Knowledge)^2,
# sim_mod=glm(Actual ~ (Estimated+Communication+Contract+Complexity)^2,
# sim_mod=glm(Actual ~ (Estimated+Communication+Contract)^2,
sim_mod=glm(Actual ~ Estimated+Communication+Contract+Communication:Contract,
		data=sim)

sim_mod=glm(Actual ~ Estimated+Estimated:Communication, data=sim)
summary(sim_mod)

D=subset(sim, Communication == "Daily")
nD=subset(sim, Communication != "Daily")

plot(D$Estimated, D$Actual, col=pal_col[1],
	xlim=range(sim$Estimated), ylim=range(sim$Actual),
	xlab="Estimated", ylab="Actual\n")
simD_mod=glm(Actual ~ Estimated, data=D)
simD_pred=predict(simD_mod)
lines(D$Estimated, simD_pred, col=pal_col[1])

points(nD$Estimated, nD$Actual, col=pal_col[2])
simnD_mod=glm(Actual ~ Estimated, data=nD)
simnD_pred=predict(simnD_mod)
lines(nD$Estimated, simnD_pred, col=pal_col[2])


