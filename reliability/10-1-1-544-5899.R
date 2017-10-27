#
# 10.1.1.544.5899.R,  5 Oct 17
# Data from:
# A Mathematical Model of the Finding of Usability Problems
# Jakob Nielsen and Thomas K. Landauer
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


ui_prob=read.csv(paste0(ESEUR_dir, "reliability/10-1-1-544-5899.csv.xz"), as.is=TRUE)

pal_col=rainbow(max(ui_prob$system))

plot(ui_prob$subjects, ui_prob$prob_percent, type="n",
	xlab="Number of evaluations", ylab="Percent problems found\n")

d_ply(ui_prob, .(system), function(df) lines(df$subjects, df$prob_percent, col=pal_col[df$system]))


