#
# data_all_Blob_merge.R, 25 May 15
#
# Data from:
#
# Impacts and detection of design smells
# Abdou Maiga
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library(lme4)
library(car)


# No information on the order in which questions were answered.
# Is the large difference seen a result on ordering or anti-patterns???
# Subject,AP,System,QTYPE,Time,Answer,Effort,SE,Java,Eclipse
blob=read.csv(paste0(ESEUR_dir, "experiment/data_all_Blob_merge.csv.xz"), as.is=TRUE)


# blob_mod=glm(Time ~ ., data=blob)
# t=stepAIC(blob_mod)

# blob_mod=lmer(Time ~ (AP+System+QTYPE+Answer+Effort+SE+Java+Eclipse)^2+ (AP+System+QTYPE+Answer | Subject), data=blob)

#library("lmerTest")
# t=step(blob_mod)

# blob_mod=lmer(Time ~ System+AP+ SE+Java+Eclipse+ (AP+Java | Subject), data=blob)
blob_mod=lmer(Time ~ AP+ QTYPE+Java+ (AP+QTYPE | Subject), data=blob)
summary(blob_mod)

Anova(blob_mod)

# Only AP is significant TODO probit because answer is bounded???
# blob_mod=lmer(Answer ~ AP+ (AP | Subject), data=blob)


SC=read.csv(paste0(ESEUR_dir, "experiment/data_all_SC_merge.csv.xz"), as.is=TRUE)


SC_mod=lmer(Time ~ AP+ (AP | Subject), data=SC)
summary(SC_mod)

Anova(blob_mod)

