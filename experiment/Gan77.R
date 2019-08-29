#
# Gan77.R, 13 Jul 19
#
# Data from:
# An Experimental Evaluation of Data Type Conversions
# J. D. Gannon
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human type-checking performance_human


source("ESEUR_config.r")


library("lme4")
library("car")


# Subject,Lang,Order,Errors,Total_Errors,Occur,Total_Occur,Error_Runs
gan77=read.csv(paste0(ESEUR_dir, "experiment/Gan77.csv.xz"), as.is=TRUE)
gan77$is_N=as.integer(gan77$Lang == "N") # create an integer for lmer

gan_mod=lmer(Errors ~ Lang+Order+ (1 | Subject), data=gan77)
gan_mod=lmer(Errors ~ Lang+Order+ (is_N-1 | Subject), data=gan77)

summary(gan_mod)
# confint(gan_mod)
Anova(gan_mod)


gan_mod=lmer(Occur ~ Lang+Order+ (1 | Subject), data=gan77)
gan_mod=lmer(Occur ~ Lang+Order+ (is_N-1 | Subject), data=gan77)

summary(gan_mod)
# confint(gan_mod)
Anova(gan_mod)


gan_mod=lmer(Error_Runs ~ Lang+Order+ (1 | Subject), data=gan77)
gan_mod=lmer(Error_Runs ~ Lang+Order+ (is_N-1 | Subject), data=gan77)

summary(gan_mod)
# confint(gan_mod)
Anova(gan_mod)


# library("sjPlot")
#
# sjp.lmer(gan_mod)

