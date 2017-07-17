#
# mars.R, 25 Nov 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("rpart")

# mars=read.csv(paste0(ESEUR_dir, "introduction/tycho-brahe/mars-numbers.csv.xz"), as.is=TRUE)
# mars=subset(mars, !is.na(Hour))
# mars=subset(mars, !is.na(Min))

mars=read.csv(paste0(ESEUR_dir, "introduction/tycho-brahe/mars.csv.xz"), as.is=TRUE)
pred_mars=read.csv(paste0(ESEUR_dir, "introduction/tycho-brahe/pred-mars.csv.xz"), as.is=TRUE)

# table(mars$Hour, mars$Month)

# 779.9 is the synodic period for Mars
#mars$day_rads=mars$Days.since.1.AD*(2*pi)/779.9
# 687 is the orbital period for Mars
mars$day_rads=mars$Days.since.1.AD*(2*pi)/687
# 678 gives a better overall fit; let's ignore the astronomical techno bable
mars$day_rads=mars$Days.since.1.AD*(2*pi)/678

rad_interval=min(mars$day_rads):max(mars$day_rads)

plot(mars$Days.since.1.AD, mars$Declination, col=point_col,
	xlab="Days", ylab="Declination")
lines(pred_mars$Days.since.1.AD, pred_mars$Declination, col="red")

# Simple (aka primitive) somtimes works...
# rp_mod=rpart(Declination ~ Days.since.1.AD+I(Days.since.1.AD^2), data=mars, method="anova")
# 
# pred=predict(rp_mod)
# lines(mars$Days.since.1.AD, pred, col="red")


plot(mars$day_rads, mars$Declination, col=point_col,
	xlab="Days", ylab="Declination")

rp_mod=rpart(Declination ~ sin(day_rads)+cos(day_rads)
#				+sin(2*day_rads)+cos(2*day_rads)
				+sin(3*day_rads)+cos(3*day_rads)
				+sin(4*day_rads)+cos(4*day_rads),
			data=mars, method="anova")

pred=predict(rp_mod, newdata=data.frame(day_rads=rad_interval))
lines(rad_interval, pred, col="green")

plot(mars$day_rads, mars$Declination, col=point_col,
	xlab="Days", ylab="Declination")

reg_mod=glm(Declination ~ sin(day_rads)+cos(day_rads)
#				+sin(2*day_rads)+cos(2*day_rads)
				+sin(3*day_rads)+cos(3*day_rads)
				+sin(4*day_rads)+cos(4*day_rads), data=mars)

pred=predict(reg_mod, newdata=data.frame(day_rads=rad_interval))
lines(rad_interval, pred, col="red")

