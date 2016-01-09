#
# debian-src-stats.R,  9 Dec 15
#
# Data from:
#
# https://sources.debian.net/stats/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


deb=read.csv(paste0(ESEUR_dir, "regression/misc/debian-src-stats.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)

pairs(deb[,-1])

plot(deb$Source.packages)

x_points=1:nrow(deb)

deb_mod=glm(Source.packages ~ x_points, data=deb)
summary(deb_mod)

lines(predict(deb_mod))

