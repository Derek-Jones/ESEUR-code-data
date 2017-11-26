#
# 0211_Computers.R, 16 Nov 17
# Data from:
# Intertemporal Pricing and Price Discrimination: {A} Semiparametric Hedonic Analysis of the Personal Computer Market
# Thanasis Stengos and Eleftherios Zacharias
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


hedon=read.csv(paste0(ESEUR_dir, "economics/0211_Computers.csv.xz"), as.is=TRUE)

h_mod=glm(price ~ (speed+hd+screen+cd+premium+ads+trend)^2
			+ram+multi
			-(cd+premium):trend
			,
			data=hedon)
summary(h_mod)

