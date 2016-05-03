#
# melton-statics.R,  3 Apr 16
#
# Data from:
#
# Static Members and Cycles in Java Software
# Hayden Melton and Ewan Tempero
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


statics=read.csv(paste0(ESEUR_dir, "regression/melton-statics.csv.xz"), as.is=TRUE)

statics$num_accesses=statics$access*statics$size

# pairs(~cycle+size+num_accesses, data=statics)

# Original study divided classes into small/large and ran a chi-squared test,
# which returns a yes/no answer and says nothing about the form of the
# effect and how strong it might be.
cyc_mod=glm(cycle ~ size+I(size^2), data=statics)
summary(cyc_mod)


