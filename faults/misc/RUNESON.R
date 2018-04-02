#
# RUNESON.R, 16 Mar 18
# Data from:
# Per Runeson and Claes Wohlin
# An Experimental Evaluation of an Experience-Based Capture-Recapture Method in Software Code Inspections
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("Rcapture")


bench=read.csv(paste0(ESEUR_dir, "faults/RUNESON-all.csv.xz"), as.is=TRUE)

A3=subset(bench, Program == "3A")
A3=t(na.omit(t(A3[, 4:11])))

t=closedp(A3)

print(t)

