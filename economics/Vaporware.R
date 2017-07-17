#
# Vaporware.R, 28 Apr 17
# Data from:
# PC-Letter's Vapor list
# via
# Truth or Consequences: {An} Analysis of Vaporware and New Product Announcements
# Barry L. Bayus and Sanjay Jain and Ambar G. Rao
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# email information from Barry Bayus:
# ANNOUNC date of the first product preannouncement
# INTRO_DA date the product was actually launched
# T1_T0 months between preannouncement and promised date of availability
# T2_T1 months between promised available date and actual launch date
# C_VAPOR is just the sum of T0_T1 and T2_T1

vapor=read.csv(paste0(ESEUR_dir, "economics/Vaporware.csv.xz"), as.is=TRUE)

vapor$ANNOUN=as.Date(vapor$ANNOUN, format="%d-%b-%Y")
vapor$INTRO_DA=as.Date(vapor$INTRO_DA, format="%d-%b-%Y")

pos_vapor=subset(vapor, T2_T1 >= 0)

# plot(vapor$ANNOUN, vapor$INTRO_DA)

plot(pos_vapor$T1_T0, pos_vapor$T2_T1, log="xy", col=point_col,
	ylim=c(1, max(pos_vapor$T2_T1)),
	xlab="Promised-Preannouncement (months)",
	ylab="Actual-Promised (months)"
	)

lines(loess.smooth(pos_vapor$T1_T0, pos_vapor$T2_T1, span=0.3), col=loess_col)

