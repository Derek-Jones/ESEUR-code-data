#
# debian-src-stats.R, 24 Jul 16
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

plot(deb$Source.files, deb$Source.lines)

lf_mod=glm(Source.lines ~ Source.files, data=deb)
summary(lf_mod)

lines(deb$Source.files, predict(lf_mod))

plot(deb$Source.packages, deb$Source.lines)

lp_mod=glm(Source.lines ~ Source.packages, data=deb)
summary(lp_mod)

lines(deb$Source.packages, predict(lp_mod))

lp2_mod=glm(Source.lines ~ Source.packages+I(Source.packages^2), data=deb)
summary(lp2_mod)

lines(deb$Source.packages, predict(lp2_mod))

plot(deb$Source.packages, deb$Disk.usage)

dp_mod=glm(Disk.usage ~ Source.packages, data=deb)
summary(dp_mod)

lines(deb$Source.packages, predict(dp_mod))

dp2_mod=glm(Disk.usage ~ Source.packages+I(Source.packages^2), data=deb)
summary(dp2_mod)

lines(deb$Source.packages, predict(dp2_mod))


