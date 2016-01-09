#
# proj-bidding.R, 19 Jun 14
#
# Data from:
# An Empirical Study of Software Project Bidding
# Magne Jorgensen and Gunnar J. Carelius
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# CompId,Group,CompSize,ExpApp,ExpTech,DevMeth,Delay,Completeness,Bid,Pre_Bid
comp_bid=read.csv(paste0(ESEUR_dir, "ecosystem/proj-bidding.csv.xz"), as.is=TRUE)

# price_mod=glm(Bid ~ CompSize*Group*ExpApp*ExpTech*DevMeth, data=comp_bid)
# price_mod=glm(Bid ~ CompSize*Group*ExpApp*ExpTech, data=comp_bid)
price_mod=glm(Bid ~ (CompSize+Group+ExpApp+ExpTech)^2, data=comp_bid)
summary(price_mod)

library(MASS)

t=stepAIC(price_mod)

summary(t)

