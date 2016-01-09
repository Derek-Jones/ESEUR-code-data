#
# crosscut.R, 23 Jun 15
#
# Data from:
# Do Crosscutting Concerns Cause Defects?
# Marc Eaddy and Thomas Zimmermann and Kaitlin D.  Sherwood and Vibhav Garg and Gail C. Murphy and Nachiappan Nagappan and Alfred V. Aho
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


rhino=read.csv(paste0(ESEUR_dir, "src_measure/crosscut_concern/Rhino_metrics.csv.xz"), as.is=TRUE)

pairs(~ CDC+ CDO+ DOSC+ DOSM+ SLOCC+Count, data=rhino, col=point_col)

