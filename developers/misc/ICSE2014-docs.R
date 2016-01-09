#
# ICSE2014-docs.R, 17 Dec 15
#
# Data from:
# How Do API Documentation and Static Typing Affect API Usability?
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")



# CT,DRT,DS,FS,DT,Group,Subject
devtime=read.csv(paste0(ESEUR_dir, "developers/misc/ICSE2014-docs.csv.xz"), as.is=TRUE)

devtime$Subject=as.factor(devtime$Subject)
devtime$have_doc=(devtime$DS != 0)
devtime$static_type=(devtime$Group == 1) | (devtime$Group == 2)

d_mod=glm(CT ~ have_doc+static_type,
			data=devtime)

summary(d_mod)

d_mod=glm(CT ~ DT,
			data=devtime)

summary(d_mod)

plot(devtime$DT, devtime$CT)
t=predict(d_mod, se=TRUE)
lines(devtime$DT, t$fit)
lines(devtime$DT, t$fit-1.96*t$se.fit, col="red")
lines(devtime$DT, t$fit+1.96*t$se.fit, col="red")

