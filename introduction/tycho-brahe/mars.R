#
# mars.R,  7 Nov 20
# Data from:
# Tychonis} {Brahe} {Dani} Scripta Astronomica
# Edited by I. L. E. Dreyer
# Tychonis Brahe
#
# via Wayne Pafko
# http://www.pafko.com/tycho/observe.html
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Mars_observation regression_sine-wave


source("ESEUR_config.r")


pal_col=rainbow(2)

# mars=read.csv(paste0(ESEUR_dir, "introduction/tycho-brahe/mars-numbers.csv.xz"), as.is=TRUE)
# mars=subset(mars, !is.na(Hour))
# mars=subset(mars, !is.na(Min))

mars=read.csv(paste0(ESEUR_dir, "introduction/tycho-brahe/mars.csv.xz"), as.is=TRUE)

# table(mars$Hour, mars$Month)

# 779.9 is the synodic period for Mars
#mars$day_rads=mars$Days.since.1.AD*(2*pi)/779.9
# 687 is the orbital period for Mars
mars$day_rads=mars$Days.since.1.AD*(2*pi)/687
# 678 gives a better overall fit; let's ignore the astronomical techno bable :-|
mars$day_rads=mars$Days.since.1.AD*(2*pi)/678

rad_interval=min(mars$day_rads):max(mars$day_rads)

# pred_mars=read.csv(paste0(ESEUR_dir, "introduction/tycho-brahe/pred-mars.csv.xz"), as.is=TRUE)
# plot(mars$Days.since.1.AD, mars$Declination, col=point_col,
# 	xlab="Days", ylab="Declination")
# lines(pred_mars$Days.since.1.AD, pred_mars$Declination, col="red")

# Simple (aka primitive) sometimes works...
# rp_mod=rpart(Declination ~ Days.since.1.AD+I(Days.since.1.AD^2), data=mars, method="anova")
# 
# pred=predict(rp_mod)
# lines(mars$Days.since.1.AD, pred, col="red")


plot(mars$day_rads, mars$Declination, col=pal_col[2],
	xlab="Nights", ylab="Declination")

# Fit a regression model built from sin/cos out to the fourth harmonic
reg_mod=glm(Declination ~ sin(day_rads)+cos(day_rads)
#				+sin(2*day_rads)+cos(2*day_rads)
				+sin(3*day_rads)+cos(3*day_rads)
				+sin(4*day_rads)+cos(4*day_rads), data=mars)

pred=predict(reg_mod, newdata=data.frame(day_rads=rad_interval))
lines(rad_interval, pred, col=pal_col[1])


#
# Plugging the same equation into a machine learned model produces
# very similar predictions.
#
# library("rpart")
# 
# plot(mars$day_rads, mars$Declination, col=point_col,
# 	xlab="Days", ylab="Declination")
# Fit a a machine learned model built from sin/cos out to the fourth harmonic
# rp_mod=rpart(Declination ~ sin(day_rads)+cos(day_rads)
#				+sin(2*day_rads)+cos(2*day_rads)
# 				+sin(3*day_rads)+cos(3*day_rads)
# 				+sin(4*day_rads)+cos(4*day_rads),
# 			data=mars, method="anova")
# 
# pred=predict(rp_mod, newdata=data.frame(day_rads=rad_interval))
# lines(rad_interval, pred, col=pal_col[1])

# Fit a regression model built from sin/cos out to the fourth harmonic
reg_mod=glm(Declination ~ sin(day_rads)+cos(day_rads)
#				+sin(2*day_rads)+cos(2*day_rads)
				+sin(3*day_rads)+cos(3*day_rads)
				+sin(4*day_rads)+cos(4*day_rads), data=mars)

