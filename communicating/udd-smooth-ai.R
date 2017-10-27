#
# udd-smooth-ai.R,  6 Sep 16
#
# Data from:
# Impact of Installation Counts on Perceived Quality: A Case Study of Debian
# Israel Herraiz and Emad Shihab and Thanh H. D. Nguyen and Ahmed E. Hassan
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("MASS")

plot_layout(3, 1)

q1=read.csv(paste0(ESEUR_dir, "regression/Q1_udd.csv.xz"), as.is=TRUE)
q10=read.csv(paste0(ESEUR_dir, "regression/Q10_udd.csv.xz"), as.is=TRUE)

udd=merge(q1, q10)

plot(udd$age, udd$insts, log="y", col=point_col,
	xlab="Age (days)", ylab="Installations\n")
smoothScatter(udd$age, log(udd$insts),
	xlab="Age (days)", ylab="log(Installations)\n")

plot(udd$age, udd$insts, log="y", col=point_col,
	xlab="Age (days)", ylab="Installations\n")

# There is no log option, so we have to compress/expand ourselves
d2_den=kde2d(udd$age, log(udd$insts+1e-5), n=50)
contour(d2_den$x, exp(d2_den$y), d2_den$z, nlevels=5, add=TRUE)


