#
# udd-age-insts.R, 22 Dec 15
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


pal_col=rainbow(3)

q1=read.csv(paste0(ESEUR_dir, "regression/Q1_udd.csv.xz"), as.is=TRUE)
q10=read.csv(paste0(ESEUR_dir, "regression/Q10_udd.csv.xz"), as.is=TRUE)

udd=merge(q1, q10)

plot(udd$age, udd$insts, log="y", col=point_col,
	xlab="Age (days)", ylab="Installations\n")

i_mod=glm(insts ~ age, data=udd, family=poisson)
i_pred=predict(i_mod, newdata=data.frame(age=1:6000), type="link", se.fit=TRUE)
lines(exp(i_pred$fit), col=pal_col[1])
lines(exp(i_pred$fit+1.96*i_pred$se.fit), col=pal_col[2])
lines(exp(i_pred$fit-1.96*i_pred$se.fit), col=pal_col[2])

lines(loess.smooth(udd$age, udd$insts, family="gaussian", span=0.2), col=pal_col[3])


