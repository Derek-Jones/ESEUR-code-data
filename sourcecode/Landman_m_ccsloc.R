#
# Landman_m_ccsloc.R, 24 Feb 20
#
# Data from:
# Empirical analysis of the relationship between {CC} and {SLOC} in a large corpus of {Java} methods and {C} functions
# Davy Landman and Alexander Serebrenik and Eric Bouwers and Jurgen J. Vinju
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG source methods sloc C Java


source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(2)


# lang,cc,sloc
cc_loc=read.csv(paste0(ESEUR_dir, "sourcecode/Landman_m_ccsloc.csv.xz"), as.is=TRUE)
cc_loc=subset(cc_loc, cc != 0)

C_loc=subset(cc_loc, lang == "C")
Java_loc=subset(cc_loc, lang == "Java")


# cc_loc$logloc=log(cc_loc$sloc)
# x_bounds=seq(log(1), log(1e5), 0.1)
# # The simpler form is not quite as good a fit.
# # Cloc_mod=glm(log(cc) ~ logloc, data=C_loc)
# Cloc_mod=glm(log(cc) ~ logloc+I(logloc^0.5), data=C_loc)
# summary(Cloc_mod)
# 
# plot(C_loc$sloc, C_loc$cc, log="xy")
# 
# pred=predict(Cloc_mod, newdata=data.frame(logloc=x_bounds))
# lines(exp(x_bounds), exp(pred), col="green")
#
# # The 'best' fit found
# Cloc_nls=nls(log(cc) ~ a+b*logloc^c, data=C_loc,
#                 start=c(a=1, b=0.7, c=1.1))
# summary(Cloc_nls)
# 
# pred=predict(Cloc_nls, newdata=data.frame(logloc=x_bounds))
# lines(exp(x_bounds), exp(pred), col="red")
# 
# # The simpler form is almost as good a fit.
# # Jloc_mod=glm(log(cc) ~ logloc, data=Java_loc)
# Jloc_mod=glm(log(cc) ~ logloc+I(logloc^0.5), data=Java_loc)

# summary(Jloc_mod)

t_C=count(C_loc$sloc)
plot(t_C, log="xy", col=pal_col[1],
	xaxs="i",
	xlim=c(0.9, 1e4), ylim=c(1, 1e7),
	xlab="SLOC", ylab="Methods/Functions\n")

t_J=count(Java_loc$sloc)
points(t_J, col=pal_col[2])

legend(x="topright", legend=c("C", "Java"), bty="n", fill=pal_col, cex=1.2)


# Is some range of the data fitted by a power-law?
# library("poweRlaw")
# 
# pow_mod=displ$new(t_C$freq)
# exp_mod=disexp$new(t_C$freq)
# 
# pow_mod$setXmin(estimate_xmin(pow_mod))
# exp_mod$setXmin(estimate_xmin(exp_mod))
# 
# # Plot sample values
# plot(pow_mod, col=point_col, xlab="Scattering degree", ylab="")
# lines(pow_mod, col=pal_col[1]) # Plot fitted line
# lines(exp_mod, col=pal_col[2])
# 
# bs_p=bootstrap_p(pow_mod, threads=4, no_of_sims=500)
# text(1e5, 0.5, bs_p$p, pos=2, col=pal_col[1]) # Display value
# 

