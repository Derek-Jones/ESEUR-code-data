#
# eindor1985.R,  7 Jun 19
# Data from:
# Grosch's Law Re-revisited: {CPU} Power and the Cost of Computation
# Phillip Ein-Dor
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG hardware performance MIPS cost memory


source("ESEUR_config.r")


library("plyr")


plot_pts=function(df)
{
# points(df$Relative_Perf, df$Average_cost, col=df$col_str)
points(df$MIPS, df$Price, col=df$col_str)
}


ein=read.csv(paste0(ESEUR_dir, "ecosystems/eindor1985.csv.xz"), as.is=TRUE)

cat_str=unique(ein$Category)
pal_col=rainbow(length(cat_str))
ein$col_str=mapvalues(ein$Category, cat_str, pal_col)

plot(0.1, type="n", log="xy",
	xlim=range(ein$MIPS), ylim=range(ein$Price),
	xlab="Performance (MIPS)", ylab="Price ($thousand)\n")

d_ply(ein, .(Category), plot_pts)

legend(x="bottomright", legend=cat_str, bty="n", fill=pal_col, cex=1.2)

