#
# 10.1.1.157.6206.R,  1 May 15
#
# Data from:
#
# On the effectiveness of early life cycle defect prediction with bayesian nets
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("rpart")

# Project,Hours,KLoC,Language,Defects,S1,S2,S3,S4,S5,S6,S7,F1,F2,F3,D1,D2,D3,D4,T1,T2,T3,T4,P1,P2,P3,P4,P5,P6,P7,P8,P9,Defects.predicted
bench=read.csv(paste0(ESEUR_dir, "machine-learning/10.1.1.157.6206.csv.xz"), as.is=TRUE)

pal_col=rainbow_hcl(3)

dt_mod=rpart(Defects ~ ., data=bench)


