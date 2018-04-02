#
# coverage_icse-2014.R, 14 Jan 18
# Data from:
# Coverage Is Not Strongly Correlated with Test Suite Effectiveness
# Laura Inozemtseva and Reid Holmes
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")


cover=read.csv(paste0(ESEUR_dir, "reliability/coverage_icse-2014.csv.xz"), as.is=TRUE)
cover$perc.killed=cover$mutants.killed/cover$num.mutants

POI=subset(cover, program == "POI")

pairs(~ perc.killed+I(suite.size^0.38)+stmt.coverage+branch.coverage+mc.coverage,
		data=POI)

mut_mod=nls(perc.killed ~ a*suite.size^b, start=list(a=1e-2, b=0.25), data=POI)
summary(mut_mod)

sc_mod=nls(stmt.coverage ~ a*suite.size^b, start=list(a=1e-2, b=0.25), data=POI)
summary(sc_mod)

bc_mod=nls(branch.coverage ~ a*suite.size^b, start=list(a=1e-2, b=0.25), data=POI)
summary(bc_mod)

mc_mod=nls(mc.coverage ~ a*suite.size^b, start=list(a=1e-2, b=0.25), data=POI)
summary(mc_mod)

stmt_bc=nls(branch.coverage ~ a*stmt.coverage^b, start=list(a=1, b=0.95), data=POI)
summary(stmt_bc)

stmt_mc=nls(mc.coverage ~ a*stmt.coverage^b, start=list(a=1, b=0.95), data=POI)
summary(stmt_mc)


power.f=deriv(~ a*stmt.coverage^b,
                      namevec=c("a", "b"),
                      function.arg=c("stmt.coverage", "a", "b"))
bc_nlme=nlmer(branch.coverage ~ power.f(stmt.coverage, a, b) ~ b | program,
              data=cover,
              start=c(a=1.0, b=1.3))
summary(bc_nlme)
confint(bc_nlme, method="Wald") # The only method that does not give an error

mc_nlme=nlmer(mc.coverage ~ power.f(stmt.coverage, a, b) ~ b | program,
              data=cover,
              start=c(a=0.95, b=1.7))
summary(mc_nlme)
confint(mc_nlme, method="Wald") # The only method that does not give an error

