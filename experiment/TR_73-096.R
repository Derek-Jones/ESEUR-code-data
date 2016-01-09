#
# TR_73-096.R, 23 Aug 14
#
# Data from:
# AN EXPERIMENT IN ALGORITHM IMPLEMENTATION
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(lattice)

imp_alg=read.csv(paste0(ESEUR_dir, "experiment/TR_73-096.csv.xz"), as.is=TRUE)
imp_alg$total=imp_alg$coding+imp_alg$declarations+
		imp_alg$desk_check+imp_alg$correct
imp_alg$log_it=log(imp_alg$iteration)

plot(xyplot(total ~ iteration | algorithm, data=imp_alg,
		xlab="Iteration", ylab="Total time"))

# i_mod=glm(total ~ (log_it+algorithm+language)^2, data=imp_alg, family="poisson")
# step_mod=step(i_mod)
# i_mod=glm(total ~ log_it+algorithm+language, data=imp_alg, family="poisson")
# 

