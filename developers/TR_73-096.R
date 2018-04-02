#
# TR_73-096.R, 11 Nov 17
#
# Data from:
# AN EXPERIMENT IN ALGORITHM IMPLEMENTATION
# Paul M. Zislis
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# library("lattice")
library("lme4")
library("plyr")


plot_alg=function(df)
{
lines(df$iteration, df$total, col=pal_col[df$col_num])
}


imp_alg=read.csv(paste0(ESEUR_dir, "developers/TR_73-096.csv.xz"), as.is=TRUE)
imp_alg$total=imp_alg$coding+imp_alg$declarations+
		imp_alg$desk_check+imp_alg$correct
imp_alg$log_it=log(imp_alg$iteration)


alg_str=unique(imp_alg$algorithm)
pal_col=rainbow(length(alg_str))

imp_alg$col_num=as.numeric(mapvalues(imp_alg$algorithm, alg_str, 1:length(alg_str)))

plot(imp_alg$iteration, imp_alg$total, type="n", log="y",
	lab=c(4, 5, 7),
	xlab="Iteration", ylab="Implementation time\n")

d_ply(imp_alg, .(algorithm), plot_alg)


# t=xyplot(total ~ iteration | algorithm, data=imp_alg,
# 		col=point_col, pch=point_pch, type="b",
#                 par.strip.text=list(cex=0.65),
# 		scales=list(x=list(at=c(1,2,3,4)),
#                             y=list(log=TRUE, cex=0.7)),
# 
# 		xlab="Iteration", ylab="Total time (minutes)")
# 
# plot(t,
# 	panel.height=list(2.5, "cm"),
# 		panel.width=list(3.0, "cm"))

# i_mod=glm(log(total) ~ (iteration+algorithm+language)^2, data=imp_alg)
# step_mod=step(i_mod)
# i_mod=glm(log(total) ~ iteration+algorithm+language, data=imp_alg)
# 

# # a_lme=lmer(log(total) ~ language+iteration+(iteration | algorithm), data=imp_alg)
# a_lme=lmer(log(coding) ~ language+iteration+(iteration | algorithm), data=imp_alg)
# summary(a_lme)
# confint(a_lme)

