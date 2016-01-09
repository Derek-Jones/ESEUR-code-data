#
# Gan77.R, 26 Aug 14
#
# Data from:
# An Experimental Evaluation of Data Type Conversions
# J. D. Gannon
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")
library("car")


# Subject,Lang,Order,Errors,Total_Errors,Occur,Total_Occur,Error_Runs
gan77=read.csv(paste0(ESEUR_dir, "experiment/Gan77.csv.xz"), as.is=TRUE)
gan77$subject=as.factor(gan77$subject)

gan_mod=lmer(Errors ~ Lang+Order+ (Lang+Order | Subject), data=gan77)

summary(gan_mod)
Anova(gan_mod)


gan_mod=lmer(Occur ~ Lang+Order+ (Lang+Order | Subject), data=gan77)

summary(gan_mod)
Anova(gan_mod)


gan_mod=lmer(Error_Runs ~ Lang+Order+ (Lang+Order | Subject), data=gan77)

summary(gan_mod)
Anova(gan_mod)


# library("sjPlot")
#
# sjp.lmer(gan_mod)

