#
# Gonzaga.R, 18 Jun 18
# Data from:
# Empirical Studies on Fine-Grained Feature Dependencies
# IRAN RODRIGUES GONZAGA JUNIOR
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java parameters globals


source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)

dep=read.csv(paste0(ESEUR_dir, "sourcecode/Gonzaga.csv.xz"), as.is=TRUE)


dep=subset(dep, Parameters < 10)

# glob_mod=glm(Ref_globals ~ Parameters, data=dep, family=binomial)
# summary(glob_mod)

proj_params=function(proj_num)
{
proj=subset(dep, Project == proj_list[proj_num])

no_globals=subset(proj, !Ref_globals)
with_globals=subset(proj, Ref_globals)

ng=count(no_globals$Parameters)
wg=count(with_globals$Parameters)

lines(ng, col=pal_col[proj_num])
lines(wg, col=pal_col[proj_num], lty=2)
}


# ng_mod=glm(Parameters ~ 1, data=no_globals, family=poisson(link="identity"))
# summary(ng_mod)
# points(0:8, dpois(0:8, coef(ng_mod)[1])*nrow(no_globals), col=pal_col[1])

# wg_mod=glm(Parameters ~ 1, data=with_globals, family=poisson(link="identity"))
# summary(wg_mod)
# points(0:8, dpois(0:8, coef(wg_mod)[1])*nrow(with_globals), col=pal_col[2])


pal_col=rainbow(4)

plot(1, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 8), ylim=c(1, 1050),
	xlab="Parameters", ylab="Functions\n")

# proj=dep

proj_list=c("apache", "bash2.01", "cherokee", "sylpheed")

proj_params(1)
proj_params(2)
proj_params(3)
proj_params(4)

legend(x="topright", legend=proj_list, bty="n", fill=pal_col, cex=1.2)

# library("gamlss")
# 
# zp_mod=gamlss(no_globals$Parameters ~ 1, family=ZIP)
# 
# xbounds=0:10
# 
# lines(xbounds, nrow(no_globals)*dZIP(x=xbounds, mu=exp(coef(zp_mod, what="mu")),
#            sigma=exp(coef(zp_mod, what="sigma"))), col=pal_col[1])
# 

