#
# proj-bidding.R,  4 Oct 17
#
# Data from:
# An Empirical Study of Software Project Bidding
# Magne Jorgensen and Gunnar J. Carelius
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(MASS)


# CompId,Group,CompSize,ExpApp,ExpTech,DevMeth,Delay,Completeness,Bid,Pre_Bid
comp_bid=read.csv(paste0(ESEUR_dir, "projects/proj-bidding.csv.xz"), as.is=TRUE)

# price_mod=glm(Bid ~ CompSize*Group*ExpApp*ExpTech*DevMeth, data=comp_bid)
# price_mod=glm(Bid ~ CompSize*Group*ExpApp*ExpTech, data=comp_bid)
price_mod=glm(Bid ~ (CompSize+Group+ExpApp+ExpTech+DevMeth)^2, data=comp_bid)
summary(price_mod)

t=stepAIC(price_mod)
summary(t)

plot(~ Bid + as.factor(CompSize) + as.factor(Group) + as.factor(ExpTech), data = comp_bid)

bid_mod=glm(Bid ~ CompSize+ExpApp+Group
		# The following interaction has a big impact on deviance
			+ExpTech:DevMeth
			, data = comp_bid)
summary(bid_mod)


