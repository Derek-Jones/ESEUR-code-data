#
# kleinschmagerA1.R, 26 Aug 14
#
# Date from:
# Do Static Type Systems Improve the Maintainability of Software Systems? An Empirical Study
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")
library("reshape2")


GJ=read.csv(paste0(ESEUR_dir, "experiment/kleinschmagerA1.csv.xz"), as.is=TRUE)
GJ$Subject=as.factor(GJ$Subject)

Java_ans=cbind(GJ$Subject, "Java", subset(GJ, select=grep("Java", colnames(GJ))))
names(Java_ans)=c("subject", "language", "T1", "T2", "T3", "S1", "S2", "T4", "E1", "T5", "E2")
# J is Java first
Java_ans$order=as.factor(1+(GJ$Start != "J"))

Groovy_ans=cbind(GJ$Subject, "Groovy", subset(GJ, select=grep("Groovy", colnames(GJ))))
names(Groovy_ans)=c("subject", "language", "T1", "T2", "T3", "S1", "S2", "T4", "E1", "T5", "E2")
# G is Groovy first
Groovy_ans$order=as.factor(1+(GJ$Start != "G"))

# Melt will assume factors are id variables if none are specified
all_ans=melt(rbind(Java_ans, Groovy_ans), variable.name="CIT", value.name="Time")


GJ_mod=lmer(Time ~ (order+language+CIT)^2-language+(order+language+CIT | subject),
		data=all_ans)

summary(GJ_mod)

