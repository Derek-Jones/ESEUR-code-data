#
# TR_73-096.R, 17 Mar 16
#
# Data from:
# AN EXPERIMENT IN ALGORITHM IMPLEMENTATION
# Paul M. Zislis
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
		col=point_col, pch=point_pch, type="b",
		scales=list(x=list(at=c(1,2,3,4))),
		xlab="Iteration", ylab="Total time (minutes)"),
		panel.height=list(1.2, "cm"))
#		panel.width=list(3.5, "cm"))

# i_mod=glm(total ~ (log_it+algorithm+language)^2, data=imp_alg, family="poisson")
# step_mod=step(i_mod)
# i_mod=glm(total ~ log_it+algorithm+language, data=imp_alg, family="poisson")
# 

