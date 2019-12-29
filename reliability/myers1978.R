#
# myers1978.R, 18 Mar 18
# Data from:
# A Controlled Experiment in Program Testing and Code Walkthroughs/Inspections
# Glenford J. Myers
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human code-review_experiment testing_experiment


source("ESEUR_config.r")


# "X" indicates the detected mistakes
myers=read.csv(paste0(ESEUR_dir, "reliability/myers1978.csv.xz"), as.is=TRUE)

A=subset(myers, Material == "Spec")
B=subset(myers, Material == "Spec_list")
C=subset(myers, Material == "Walk_Insp")

# more todo

