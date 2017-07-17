#
# 2015-MSR-coinstevol.R, 12 Jun 17
# Data from:
# A historical analysis of {Debian} package conflicts
# S{\'e}bastien Drobisz and Tom Mens and Roberto {Di Cosmo}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("survival")


pal_col=rainbow(2)


deb_pack=read.csv(paste0(ESEUR_dir, "ecosystems/2015-MSR-coinstevol.csv.xz"), as.is=TRUE)
deb_pack$first=as.Date(deb_pack$first, format="%Y-%m-%d")
deb_pack$last=as.Date(deb_pack$last, format="%Y-%m-%d")
deb_pack$first.conflict=as.Date(deb_pack$first.conflict, format="%Y-%m-%d")
deb_pack$last.conflict=as.Date(deb_pack$last.conflict, format="%Y-%m-%d")
END_DATE=max(deb_pack$last)

deb_pack$conf_free_time=as.numeric(deb_pack$first.conflict-deb_pack$first)
deb_pack$conf_free_time[deb_pack$no.conflicts]=deb_pack$lifetime[deb_pack$no.conflicts]

conf_mod=survfit(Surv(deb_pack$conf_free_time, !deb_pack$no.conflicts) ~ 1)
life_mod=survfit(Surv(deb_pack$lifetime, deb_pack$last!=END_DATE) ~ 1)

plot(conf_mod, col=pal_col[1],
	xlab="Days", ylab="Survival")
lines(life_mod, col=pal_col[2])

legend(x="bottom", legend=c("No conflict", "Debian package"), bty="n", fill=pal_col, cex=1.2)

