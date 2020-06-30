#
# Gonzaga.R,  8 Jun 20
# Data from:
# Empirical Studies on Fine-Grained Feature Dependencies
# IRAN RODRIGUES GONZAGA JUNIOR
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C function_parameters global_accesses


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
	xlim=c(0, 7), ylim=c(1, 1050),
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

# 
# # Sumary information about each project
# # In particular average number of parameters for functions that
# # do/don't access globals.
# cnt_params=function(df)
# {
# num_funcs=nrow(df)
# glob=subset(df, Ref_globals)
# no_glob=subset(df, !Ref_globals)
# return(data.frame(num_funcs, num_glob_ref=nrow(glob),
# 		av_gparam=mean(glob$Parameters), sd_gparam=sd(glob$Parameters),
# 		av_ngparam=mean(no_glob$Parameters), sd_ngparam=sd(no_glob$Parameters)
# 	))
# }
# 
# 
# # table(dep$Parameters, dep$Ref_globals)
# 
# # Iterate over each project 
# num_param=ddply(dep, .(Project), cnt_params)
# 
# # Mean difference in number of parameters across projects
# mean(num_param$av_ngparam)-mean(num_param$av_gparam)
# 
# 
# # Use bootstrap to find out how often the difference in mean number of
# # parameters, between functions that access globals and those that don't,
# # is as large as the one seen
# 
# # Difference in means of two samples
# mean_param_diff=function(params, num_no_glob, num_glob)
# {
# t=mean(params[sample(num_no_glob, replace=TRUE)])-
# 		mean(params[sample(num_glob, replace=TRUE)])
# }
# 
# 
# # Assume the Ref_global is exchangeable, and bootstrap difference in
# # mean number of parameters
# boot_param_diff=function(df)
# {
# # Functions that access globals, and those that don't
# glob=subset(df, Ref_globals)
# no_glob=subset(df, !Ref_globals)
# 
# # Actual difference in means
# act_mean=mean(no_glob$Parameters)-mean(glob$Parameters)
# 
# # Now bootstrap
# param_diff=replicate(4999, mean_param_diff(df$Parameters, nrow(no_glob), nrow(glob)))
# 
# # What percentage of bootstrap samples had a mean this large?
# return(100*length(which(act_mean <= param_diff))/(1+length(param_diff)))
# }
# 
# # Iterate over all projects
# mean_boot_param=ddply(dep, .(Project), boot_param_diff)
# 
# length(which(mean_boot_param$V1 < 5))
# 

