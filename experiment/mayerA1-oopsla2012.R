#
# mayerA1-oopsla2012.R, 26 Aug 14
#
# Date from:
# An Empirical Study of the Influence of Static Type Systems on the Usability of Undocumented Software
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lme4")
library("reshape2")


GJ=read.csv(paste0(ESEUR_dir, "experiment/mayerA1-oopsla2012.csv.xz"), as.is=TRUE)
GJ$Subject=as.factor(GJ$Subject)

Java_ans=cbind(GJ$Subject, "Java", subset(GJ, select=grep("Java", colnames(GJ))))
names(Java_ans)=c("subject", "language", "T1", "T2", "T3", "T4", "T5")
# B is Java first
Java_ans$order=as.factor(1+(GJ$Group != "B"))

Groovy_ans=cbind(GJ$Subject, "Groovy", subset(GJ, select=grep("Groovy", colnames(GJ))))
names(Groovy_ans)=c("subject", "language", "T1", "T2", "T3", "T4", "T5")
# A is Groovy first
Groovy_ans$order=as.factor(1+(GJ$Group != "A"))

# Melt will assume factors are id varaibles if none are specified
all_ans=melt(rbind(Java_ans, Groovy_ans), variable.name="CIT", value.name="Time")


GJ_mod=lmer(Time ~ order+language:CIT+CIT+(order+language:CIT+CIT | subject),
		data=all_ans)

summary(GJ_mod)

