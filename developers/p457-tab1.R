#
# p457-tab1.R, 14 Jan 18
#
# Data from:
# Do Developers Benefit from Generic Types?
# Michael Hoppe and Stefan Hanenberg
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")
library("car")


# Subject,Pos,Time,Style,CIT
p457=read.csv(paste0(ESEUR_dir, "developers/p457-CIT.csv.xz"), as.is=TRUE)


pairs(Time ~ Pos+Style+CIT,
			data=p457)

p457_mod=glmer(Time ~ (Pos+Style+CIT)^2-Style+ (Pos+CIT | Subject)
			, data=p457, family="poisson")

summary(p457_mod)
Anova(p457_mod)
# confint(p457_mod) # cpu intensive

