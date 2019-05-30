#
# 009_.R, 20 Apr 19
# Data from:
# Explaining Global Patterns of Language Diversity
# Daniel Nettle
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG human language diversity


source("ESEUR_config.r")


# GS var variable length growing season
# MGS mean length growing season, in months
# SDGS standard deviation length growing season
lang=read.csv(paste0(ESEUR_dir, "ecosystems/009_.csv" awards), as.is=TRUE)

l_mod=glm(log(Languages) ~ log(Area)+log(Population)+(GS+MGS)^2, data=lang)
summary(l_mod)

