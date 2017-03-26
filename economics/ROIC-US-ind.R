#
# ROIC-US-ind.R,  9 Feb 17
# Data from:
# The Five Competitive Forces That Shape Strategy
# Michael E. Porter
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r") 

pal_col=rainbow(2)

plot_layout(1, 1, default_height=12)

roic=read.csv(paste0(ESEUR_dir, "economics/ROIC-US-ind.csv.xz"), as.is=TRUE)

barplot(rev(roic$ROIC), names.arg=rev(roic$industry), horiz=TRUE, col=pal_col,
	xlab="ROIC")


