#
# review-apd.R, 27 Mar 15
#
# Data from:
# INVESTIGATING EFFECTIVE INSPECTION OF OBJECT-ORIENTED CODE
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


gym=read.csv(paste0(ESEUR_dir, "experiment/students/gym-apd.csv.xz"), as.is=TRUE)

t=gym$TP/(gym$TP+gym$FP)
plot(sort(t))
