#
# design_fac.R, 17 Apr 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("DoE.base")

pm=c("+", "-")

fac.design(nlevels=c(2, 2, 2),
		factor.names=list(X=pm, Y=pm, Z=pm))

