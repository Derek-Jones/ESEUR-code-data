#
# Groovy_change-prop2.R,  8 Jan 16
#
# Data from:
#
# Growth and change dynamics in open source software systems
# Rajesh Vasa
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


groovy=read.csv(paste0(ESEUR_dir, "regression/Groovy_change-prop2.csv.xz"), as.is=TRUE)

pal_col=rainbow(2)

# There are multiple metrics per program, pick one
groovy=subset(groovy, Name == "Groovy")

plot(groovy$Age, groovy$Classes, col=point_col,
	xlab="Days since version 1.0.0", ylab="Number of classes\n")

all_mod=glm(Classes ~ Age+I(Age^2), data=groovy)

pred=predict(all_mod, se.fit=TRUE)

lines(groovy$Age, pred$fit, col=pal_col[1])
# lines(groovy$Age, pred$fit+1.96*pred$se.fit)
# lines(groovy$Age, pred$fit-1.96*pred$se.fit)

phase_1=subset(groovy, grepl("1.0", ID))
phase_2=subset(groovy, !grepl("1.0", ID))
 
p1_mod=glm(Classes ~ Age+I(Age^2), data=phase_1)

pred=predict(p1_mod, se.fit=TRUE)

lines(phase_1$Age, pred$fit, col=pal_col[2])
# lines(groovy$Age, pred$fit+1.96*pred$se.fit)
# lines(groovy$Age, pred$fit-1.96*pred$se.fit)

text(400, 400, "version 1.0.x", cex=1.3)

 
p2_mod=glm(Classes ~ Age+I(Age^2), data=phase_2)

pred=predict(p2_mod, se.fit=TRUE)

lines(phase_2$Age, pred$fit, col=pal_col[2])
# lines(groovy$Age, pred$fit+1.96*pred$se.fit)
# lines(groovy$Age, pred$fit-1.96*pred$se.fit)

text(1200, 780, "version 1.1.x to 1.6.x", cex=1.3)
 
