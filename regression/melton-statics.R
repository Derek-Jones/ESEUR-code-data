#
# melton-statics.R, 15 Nov 15
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

cyc_mod=glm(cycle ~ size+I(size^2), data=statics)
summary(cyc_mod)


