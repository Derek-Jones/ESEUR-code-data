#
# eickt1992.R, 18 Mar 18
# Data from:
# Stephen G. Eick and Clive R. Loader and M. David Long and Lawrence G. Votta and Scott Vander Wiel
# Estimating Software Fault Content Before Coding
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault_estimation


source("ESEUR_config.r")


library("Rcapture")


probs=read.csv(paste0(ESEUR_dir, "reliability/eickt1992.csv.xz"), as.is=TRUE)

# Not interested in whether a code fault actually occurred
probs$C_F=NULL

t=closedp(probs)

print(t)

