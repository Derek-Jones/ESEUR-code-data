#
# inspection.R, 16 Mar 16
#
# Data from:
# Understanding the Sources of Variation in Software Inspection
# Adam Porter and Harvey Siy and Audris Mockus and Lawrence Votta
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

inspect=read.csv(paste0(ESEUR_dir, "experiment/porter-siy/inspection.csv.xz"), as.is=TRUE)

inspect$AVAILMONTH=as.Date(paste0(inspect$AVAILMONTH, "/01"), format="%y/%m/%d")
inspect$month=as.numeric(inspect$AVAILMONTH) %/% (7*4)
inspect$sessions=as.numeric(substr(inspect$TREAT, 1, 1))
inspect$persons=as.numeric(substr(inspect$TREAT, 4, 4))
inspect$repair=substr(inspect$TREAT, 6, 6)

brew_col=rainbow_hcl(3)

plot(inspect$month, inspect$TRUEDEF+inspect$FALSEPOS)

lines(loess.smooth(inspect$month, inspect$TRUEDEF+inspect$FALSEPOS, span=0.3, family="gaussian"), col="green")

table(inspect$persons, inspect$sessions, inspect$repair)

inspect_mod=glm(TRUEDEF ~ (log(NCSL)+persons+sessions+repair)^2, data=inspect,
			family=poisson)
summary(inspect_mod)

# library("MASS")
# t=stepAIC(inspect_mod)

# inspect_mod=glm(TRUEDEF ~ log(NCSL)+persons*repair, data=inspect,
# 			family=poisson)
# summary(inspect_mod)


