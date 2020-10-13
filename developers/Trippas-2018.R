#
# Trippas-2018.R,  4 Aug 20
# Data from:
# Characterizing belief bias in syllogistic reasoning: {A} hierarchical {Bayesian} meta-analysis of {ROC} data
# Dries Trippas and David Kellen and Henrik Singmann and Gordon Pennycook and Derek J. Koehler and Jonathan A. Fugelsang and Chad Dub\'{e}
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human reasoning_syllogism bias_human reasoning _bias

source("ESEUR_config.r")


library("lme4")


trip=read.csv(paste0(ESEUR_dir, "developers/Trippas-2018.txt.xz"), as.is=TRUE,
		sep="\t")

s14=subset(trip, cond == 14)

# Model taken from Appendix B
syll_mod=glmer(rsp ~ val*belief+(val*belief | subj)+(belief | syllc),
			data=s14, family=binomial("probit"))
summary(syll_mod)


