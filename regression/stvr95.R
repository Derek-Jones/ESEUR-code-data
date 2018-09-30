#
# stvr95.R, 26 Sep 18
# Data from:
# An Experimental Evaluation of Capture-Recapture in Software Inspections
# Claes Wohlin and Per Runeson and Johan Brantestam
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG review experiment inspection

source("ESEUR_config.r")


library("ltm")


stvr=read.csv(paste0(ESEUR_dir, "regression/stvr95.csv.xz"), as.is=TRUE)

g1=subset(stvr, Group == "G1")

g1$Fault=NULL
g1$Group=NULL

g1=t(g1)

t=ltm(g1 ~ z1+z2)
summary(t)

