#
# Landman-proj.R, 11 Jun 18
#
# Data from:
# Empirical analysis of the relationship between {CC} and {SLOC} in a large corpus of Java methods
# Davy Landman and Alexander Serebrenik and Jurgen Vinju
#
# Davy Landman 
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG source methods sloc files projects Java


source("ESEUR_config.r")

library("plyr")


pal_col=rainbow(3)


proj_totals=function(df)
{
sloc=sum(df$sloc)
methods=nrow(df)
files=length(unique(df$file))

return(data.frame(sloc, methods, files))
}


meth_per_file=function(df)
{
meth=ddply(df, .(file), function(df) return(nrow(df)))

return(meth)
}


# project,file,cc,sloc
cc_loc=read.csv(paste0(ESEUR_dir, "sourcecode/Landman.csv.xz"), as.is=TRUE)
cc_loc$logloc=log(cc_loc$sloc)

# smoothScatter(log(cc_loc$sloc), log(cc_loc$cc),
#         xlab="log(SLOC)", ylab="log(CC)")


proj_info=ddply(cc_loc, .(project), proj_totals)

t=density(log(proj_info$sloc))
plot(exp(t$x), t$y, type="l", log="x", col=pal_col[1],
	xaxs="i", yaxs="i",
	ylim=c(0, 0.28),
	xlab="Total per project", ylab="Density\n")

t=density(log(proj_info$methods))
lines(exp(t$x), t$y, col=pal_col[2])

t=density(log(proj_info$files))
lines(exp(t$x), t$y, col=pal_col[3])

legend(x="topright", legend=c("SLOC", "Methods", "Files"), bty="n", fill=pal_col, cex=1.2)

# 
# plot(proj_info$sloc, proj_info$methods, log="xy", col=pal_col[1],
# 	xaxs="i", yaxs="i",
# 	xlab="SLOC", ylab="Methods\n")
# points(proj_info$sloc, proj_info$files, col=pal_col[2])
# 
# # A fractionally better (probably over) fit
# # sloc_mod=glm(log(sloc) ~ log(methods)+I(log(methods)^0.1)
# #				+log(files)+I(log(files)^3), data=proj_info)
# sloc_mod=glm(log(sloc) ~ log(methods)+log(files), data=proj_info)
# summary(sloc_mod)
# 
# 
# t=count(cc_loc$sloc)
# plot(t, log="xy", col=point_col,
# 	xlab="SLOC", ylab="Methods\n")
# 
# 
# meth_cnt=ddply(cc_loc, .(project), meth_per_file)
# 
# t=count(meth_cnt$V1)
# plot(t, log="xy", col=point_col,
# 	xlab="Methods", ylab="Files\n")
# 
# plot(proj_info$files, proj_info$methods, log="xy", col=pal_col[1],
# 	xaxs="i", yaxs="i",
# 	xlab="Files", ylab="Methods\n")
# 
#
# library("fitdistrplus")
# 
# descdist(log(proj_size$V1))
# 
# t=hist(log(proj_info$sloc), breaks=100)
# pm=fitdist(t$counts, distr="norm")
# d_vals=gofstat(pm, fitnames="Normal")
# plot(d_vals$chisqbreaks, head(d_vals$chisqtable[, 2], -1), col="red")
# points(d_vals$chisqbreaks, head(d_vals$chisqtable[, 1], -1), col="green")


# gloc_mod=glm(cc ~ sloc, data=cc_loc)
# loc_mod=glm(log(cc) ~ logloc, data=cc_loc)

# Fitting the following model takes around 25 minutes on a decent machine
# with plenty of memory.
#
# library("lme4")
# 
#loc_mix=glmer(log(cc) ~ logloc+ (logloc | project), data=cc_loc)
# summary(loc_mix)
# 
# Linear mixed model fit by REML ['lmerMod']
# Formula: log(cc) ~ logloc + (logloc | project)
#    Data: cc_loc
# 
# REML criterion at convergence: 15666045
# 
# Scaled residuals: 
#      Min       1Q   Median       3Q      Max 
# -17.6803  -0.2821  -0.0428   0.3662  12.7488 
# 
# Random effects:
#  Groups   Name        Variance Std.Dev. Corr 
#  project  (Intercept) 0.04159  0.2039        
#           logloc      0.02206  0.1485   -0.93
#  Residual             0.14170  0.3764        
# Number of obs: 17633256, groups:  project, 13103
# 
# Fixed effects:
#              Estimate Std. Error t value
# (Intercept) -0.656681   0.001907  -344.3
# logloc       0.631164   0.001360   464.0
# 
# Correlation of Fixed Effects:
#        (Intr)
# logloc -0.929
# convergence code: 0
# Model failed to converge with max|grad| = 0.00801535 (tol = 0.002, component 1)
# Model is nearly unidentifiable: very large eigenvalue
#  - Rescale variables?
# 
# plot(cc_loc$sloc, cc_loc$cc, log="xy")


