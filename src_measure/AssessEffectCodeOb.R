#
# AssessEffectCodeOb.R, 24 Jun 15
#
# Data from:
#
# A Family of Experiments to Assess the Effectiveness and Efficiency of Source Code Obfuscation Techniques
# Mariano Ceccato and Massimiliano {Di Penta} and Paolo Falcarin and Filippo Ricca and Marco Torchiano and Paolo Tonella
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("car")
library("lme4")


# Exp,ID,Level,Average,Ability,Lab,Treatment,Application,Time1,Accuracy1,Time2,Accuracy2,Time3,Accuracy3,Time4,Accuracy4,Eff_Comp,Eff_Change,Eff_All
codeob=read.csv(paste0(ESEUR_dir, "src_measure/AssessEffectCodeOb.csv.xz"), as.is=TRUE)

# table(codeob$Level, codeob$Treatment)

# Data cleaning
codeob$Average[13:14]=30

# codeob$Average=NULL

# bachelors did not do any 'clear' tests
codeob=subset(codeob, Level != "bachelor")

# T1_codeob=na.omit(codeob[ , 1:10])

T1_codeob=subset(codeob, !is.na(Time1))
T1_codeob$Average=as.numeric(T1_codeob$Average)

pairs(~ Time1 + Average, data=T1_codeob)

#gan_mod=lmer(Time1 ~ Level+(Ability+Lab+Treatment+Application)^2
gan_mod_1=lmer(Time1 ~ Level+Lab+Treatment
			+(Treatment | ID),
				data=T1_codeob)
Anova(gan_mod_1)
summary(gan_mod_1)

# glm_mod=glmer(Accuracy1 ~ Level+(Ability+Lab+Treatment+Application)^2
glm_mod_1=glmer(Accuracy1 ~ Level+Lab+Treatment
			+(Treatment | ID),
				data=T1_codeob, family=binomial)
Anova(glm_mod_1)


T2_codeob=subset(codeob, !is.na(Time2))
# T2_codeob=na.omit(codeob[ , 1:12])

# gan_mod=lmer(Time1 ~ Level+(Ability+Lab+Treatment+Application)^2
gan_mod_2=lmer(Time2 ~ Level+Treatment+Application
			+(Treatment | ID),
				data=T2_codeob)
Anova(gan_mod_2)
summary(gan_mod_2)

glm_mod_2=glmer(Accuracy2 ~ Level+Treatment+Application
			+(Treatment | ID),
				data=T2_codeob, family=binomial)
Anova(glm_mod_2)



T3_codeob=subset(codeob, !is.na(Time3))
# T3_codeob=na.omit(codeob[ , 1:14])

gan_mod_3=lmer(Time3 ~ Level+Treatment
			+(Treatment | ID),
				data=T3_codeob)
Anova(gan_mod_3)
summary(gan_mod_3)



T4_codeob=na.omit(codeob[ , 1:16])

gan_mod_4=lmer(Time4 ~ Level+Treatment+Application
			+(Treatment+Application-1 | ID),
				data=T4_codeob)
Anova(gan_mod_4)
summary(gan_mod_4)



