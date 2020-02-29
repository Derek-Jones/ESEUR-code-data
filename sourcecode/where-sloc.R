#
# where-sloc.R, 29 Jan 20
# Data from:
# Empirical analysis of the relationship between {CC} and {SLOC} in a large corpus of {Java} methods and {C} functions
# Davy Landman and Alexander Serebrenik and Eric Bouwers and Jurgen J. Vinju
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java_SLOC C_SLOC function_SLOC method_SLOC

source("ESEUR_config.r")


library("plyr")


plot_layout(2, 1)

pal_col=rainbow(2)

cc_loc=read.csv(paste0(ESEUR_dir, "sourcecode/Landman_m_ccsloc.csv.xz"), as.is=TRUE)
cc_loc=subset(cc_loc, cc != 0)

C_loc=subset(cc_loc, lang == "C")
Java_loc=subset(cc_loc, lang == "Java")

wC_sloc=ddply(C_loc, .(sloc), function(df) nrow(df))
Csloc=sum(C_loc$sloc)
wJ_sloc=ddply(Java_loc, .(sloc), function(df) nrow(df))
Jsloc=sum(Java_loc$sloc)

# plot(wJ_sloc$sloc, wJ_sloc$V1, log="xy", col=pal_col[2],
# 	xlab="SLOC", ylab="Functions/methods\n\n")
# 
# points(wC_sloc$sloc, wC_sloc$V1, col=pal_col[1])
# 
# legend(x="topright", legend=c("C", "Java"), bty="n", fill=pal_col, cex=1.2)

plot(wJ_sloc$sloc, 100*wJ_sloc$V1*wJ_sloc$sloc/Jsloc, log="xy", col=pal_col[2],
	xlab="Function length (lines)", ylab="Total SLOC (percentage)\n")

points(wC_sloc$sloc, 100*wC_sloc$V1*wC_sloc$sloc/Csloc, col=pal_col[1])

legend(x="topright", legend=c("C", "Java"), bty="n", fill=pal_col, cex=1.2)

plot(wJ_sloc$sloc, cumsum(100*wJ_sloc$V1*wJ_sloc$sloc/Jsloc), log="x", col=pal_col[2],
	ylim=c(5, 100),
	xlab="Function length (lines)", ylab="Cummulativce SLOC (percentage)\n")

points(wC_sloc$sloc, cumsum(100*wC_sloc$V1*wC_sloc$sloc/Csloc), col=pal_col[1])

legend(x="bottomright", legend=c("C", "Java"), bty="n", fill=pal_col, cex=1.2)

