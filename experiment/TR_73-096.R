#
# TR_73-096.R,  1 Sep 16
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

t=xyplot(total ~ iteration | algorithm, data=imp_alg,
		col=point_col, pch=point_pch, type="b",
                par.strip.text=list(cex=0.65),
		scales=list(x=list(at=c(1,2,3,4)),
                            y=list(log=TRUE, cex=0.7)),

		xlab="Iteration", ylab="Total time (minutes)")

plot(t,
	panel.height=list(2.5, "cm"),
		panel.width=list(3.0, "cm"))

# i_mod=glm(total ~ (log_it+algorithm+language)^2, data=imp_alg, family="poisson")
# step_mod=step(i_mod)
# i_mod=glm(total ~ log_it+algorithm+language, data=imp_alg, family="poisson")
# 

