#
# journal-pone-0202288.R, 18 Apr 20
# Data from:
# Overconfidence is universal? {Elicitation} of Genuine Overconfidence ({EGO}) procedure reveals systematic differences across domain, task knowledge, and incentives in four populations
# Michael Muthukrishna and Joseph Henrich and Wataru Toyokawa and Takeshi Hamamura and Tatsuya Kameda and Steven J. Heine
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human overconfidence_culture

source("ESEUR_config.r")


library("lme4")


jp=read.csv(paste0(ESEUR_dir, "developers/journal-pone-0202288.csv.xz"), as.is=TRUE)

# Opinion on math test performance
mjp=subset(jp, math == 1)

# Paper builds various models, but none involving gender.
# Males appear to more accurately predict their performance,
# i.e., less overconfident.  Going against steriotype.
# More accurate predictions of performance after taking the test.
# True_Overplacement=predicted-actual
op_mod=lmer(True_Overplacement ~ after+(1 | pid)+money+male
				# +factor(ethniccategory)
				,
				data=mjp)

summary(op_mod)
# While predictors are significant, the overall model predicts almost nothing

