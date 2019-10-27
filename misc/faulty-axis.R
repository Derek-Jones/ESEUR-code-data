#
# faulty-axis.R, 23 Sep 19
# Data from:
# CENTRAL FLOW CONTROL SOFTWARE DEVELOPMENT: A CASE STUDY OF THE EFFECTIVENESS OF SOFTWARE ENGINEERING TECHNIQUES
# Peter C. Belford and Richard A. Berg and Thomas L. Hannan
#
# Quantifying the effects of IT-governance rules
# C. Verhoef
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG function-points LOC effort module


source("ESEUR_config.r")


pal_col=rainbow(3)


fa=read.csv(paste0(ESEUR_dir, "misc/faulty-axis.csv.xz"), as.is=TRUE)
fa$Mhour=fa$LOC/fa$LOC_Mhour
gv=read.csv(paste0(ESEUR_dir, "misc/gov-fp.csv.xz"), as.is=TRUE)
gv$Month=gv$FP/gv$FP_month

plot(fa$LOC, fa$LOC_Mhour, col=pal_col[1],
	xlab="LOC", ylab="LOC/Man-hour")

mh_mod=glm(LOC_Mhour ~ LOC, data=fa)

x_bounds=1:250
pred=predict(mh_mod, se.fit=TRUE, newdata=data.frame(LOC=x_bounds))

lines(x_bounds, pred$fit, col=pal_col[2])
lines(x_bounds, pred$fit-1.96*pred$se.fit, col=pal_col[3])
lines(x_bounds, pred$fit+1.96*pred$se.fit, col=pal_col[3])

# The ylim values cut off one outlier
plot(fa$LOC, fa$Mhour, col=pal_col[1],
	ylim=c(0, 180),
	xlab="LOC", ylab="Man-hour\n")

# Ignore outlier
mh_mod=glm(Mhour ~ LOC, data=fa, subset=(Mhour < 200))

pred=predict(mh_mod, se.fit=TRUE, newdata=data.frame(LOC=x_bounds))

lines(x_bounds, pred$fit, col=pal_col[2])
# lines(x_bounds, pred$fit-1.96*pred$se.fit, col=pal_col[3])
# lines(x_bounds, pred$fit+1.96*pred$se.fit, col=pal_col[3])


# FP data

plot(gv$FP, gv$FP_month, col=pal_col[1],
	xlab="Function-points", ylab="Function-points/Month")

mh_mod=glm(FP_month ~ FP, data=gv)

x_bounds=1:900
pred=predict(mh_mod, se.fit=TRUE, newdata=data.frame(FP=x_bounds))

lines(x_bounds, pred$fit, col=pal_col[2])
lines(x_bounds, pred$fit-1.96*pred$se.fit, col=pal_col[3])
lines(x_bounds, pred$fit+1.96*pred$se.fit, col=pal_col[3])


plot(gv$FP_month, gv$FP, col=pal_col[1],
	xlab="Function-points/Month", ylab="Function-points\n")

mh_mod=glm(FP ~ FP_month, data=gv)

x_bounds=1:900
pred=predict(mh_mod, se.fit=TRUE, newdata=data.frame(FP_month=x_bounds))

lines(x_bounds, pred$fit, col=pal_col[2])
lines(x_bounds, pred$fit-1.96*pred$se.fit, col=pal_col[3])
lines(x_bounds, pred$fit+1.96*pred$se.fit, col=pal_col[3])

plot(gv$FP, gv$Month, col=pal_col[1],
	xlab="Function-points", ylab="Months\n")

mh_mod=glm(Month~ FP, data=gv)

x_bounds=1:900
pred=predict(mh_mod, se.fit=TRUE, newdata=data.frame(FP=x_bounds))

lines(x_bounds, pred$fit, col=pal_col[2])
# lines(x_bounds, pred$fit-1.96*pred$se.fit, col=pal_col[3])
# lines(x_bounds, pred$fit+1.96*pred$se.fit, col=pal_col[3])


library("MASS")

# cov(fa$LOC, fa$Mhour) # 1090
# cov(gv$Month, gv$FP)  # 4070

n_proj=200
r_LOC=runif(n_proj, 10, 300)
r_time=2+mvrnorm(n_proj, 80, cov(fa$LOC, fa$Mhour))

plot(r_LOC, r_LOC/r_time, col=pal_col[1],
	ylim=c(0, 20))

r_time=2+2*mvrnorm(n_proj, 80, cov(gv$Month, gv$FP))
points(r_LOC, r_LOC/r_time, col=pal_col[2])


