#
# sec12-final.R,  1 Feb 19
# Data from:
# Shashi Shekhar and Michael Dietz and Dan S. Wallach
# AdSplit: {Separating} smartphone advertising from applications
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG advertising app_store Google Amazon


source("ESEUR_config.r")


library("gamlss")


pal_col=rainbow(2)


sec=read.csv(paste0(ESEUR_dir, "economics/sec12-final.csv.xz"), as.is=TRUE)

# plot(sec$ad.library, sec$apps, log="y",
# 	xlab="Ad libraries", ylab="Apps")

a_libs=rep(sec$ad.library, times=sec$apps)

# mean(a_libs)
# sd(a_libs)

# There is overdispersion
# a_mod=glm(a_libs ~ 1, family=poisson)
# lines(0:8, sum(a_dist)*dpois(0:8, exp(coef(a_mod))))

# The fit is no better with NBII, Poisson inverse Gaussian is slightly better
g_control=gamlss.control(trace=FALSE) # Yes, the default really is true!
nbi_amod=gamlss(a_libs ~ 1, family=NBI, control=g_control)

plot(function(y) sum(a_libs)*
                        dNBI(y, mu=exp(coef(nbi_amod, what="mu")),
                                sigma=exp(coef(nbi_amod, what="sigma"))),
        from=0, to=8, n=8+1,
        log="y", col=pal_col[2],
        xlab="Ad libraries", ylab="Apps\n")

points(sec$ad.library, sec$apps, col=pal_col[1])

# library("COMPoissonReg")
# 
# The fit has a slightly higher AIC :-(
# cmp_mod=glm.cmp(a_libs ~ 1, formula.nu=a_libs~1, beta.init=0.84)
# summary(cmp_mod)
# 
# plot(function(y) sum(a_libs)*
#                         dcmp(y, lambda=exp(cmp_mod$beta),
#                                 nu=exp(cmp_mod$gamma)),
#         from=0, to=8, n=8+1,
#         log="y", col=pal_col[2],
#         xlab="Ad libraries", ylab="Apps\n")
# 
# points(sec$ad.library, sec$apps, col=pal_col[1])

