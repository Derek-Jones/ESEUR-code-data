#
# Landman_m_ccsloc.R, 11 Jun 18
#
# Data from:
# Empirical analysis of the relationship between {CC} and {SLOC} in a large corpus of {Java} methods and {C} functions
# Davy Landman and Alexander Serebrenik and Eric Bouwers and Jurgen J. Vinju
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG source methods sloc C Java


source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(2)


# lang,cc,sloc
cc_loc=read.csv(paste0(ESEUR_dir, "sourcecode/Landman_m_ccsloc.csv.xz"), as.is=TRUE)
cc_loc=subset(cc_loc, cc != 0)
cc_loc$logloc=log(cc_loc$sloc)

C_loc=subset(cc_loc, lang == "C")
Java_loc=subset(cc_loc, lang == "Java")


# # The simpler form is not quite as good a fit.
# # Cloc_mod=glm(log(cc) ~ logloc, data=C_loc)
# # 0.6 is an ever so slightly better fit.
# # Cloc_mod=glm(log(cc) ~ logloc+I(logloc^0.6), data=C_loc)
# Cloc_mod=glm(log(cc) ~ logloc+I(logloc^0.5), data=C_loc)
# summary(Cloc_mod)
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

