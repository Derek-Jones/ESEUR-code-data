#
# li2016.R,  3 Aug 19
# Data from:
# Accessing Inaccessible Android {APIs}: {An} Empirical Study
# Li Li and Tegawend{\'e} and F. Bissyand{\'e} and Yves Le Traon and Jacques Klein
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Android API evolution_releases


source("ESEUR_config.r")


pal_col=rainbow(2)


fit_range=function(f_range)
{
f_mod=glm(log(APIs) ~ Age, data=li, subset=f_range)
summary(f_mod)

pred=predict(f_mod)
lines(li$Age[f_range], exp(pred), col=pal_col[2])
}


li=read.csv(paste0(ESEUR_dir, "ecosystems/li2016.csv.xz"), as.is=TRUE)

plot(li$Age, li$APIs, log="y", col=pal_col[1],
	xlab="Age (releases)", ylab="APIs\n")

f_range=1:11
f_mod=glm(log(APIs) ~ Age, data=li, subset=f_range)
summary(f_mod)

pred=predict(f_mod)
lines(li$Age[f_range], exp(pred))


fit_range(1:11)
fit_range(12:16)


