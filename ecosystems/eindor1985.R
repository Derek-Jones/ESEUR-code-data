#
# eindor1985.R,  1 Jun 18
# Data from:
# Grosch's Law Re-revisited: {CPU} Power and the Cost of Computation
# Phillip Ein-Dor
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG hardware performance MIPS cost memory


source("ESEUR_config.r")


library("plyr")


plot_pts=function(df)
{
points(df$Max_Memory, df$Average_cost, col=df$col_str)
# points(df$MIPS, df$Average_cost, col=df$col_str)
}


ein=read.csv(paste0(ESEUR_dir, "ecosystems/eindor1985.csv.xz"), as.is=TRUE)

cat_str=unique(ein$Category)
pal_col=rainbow(length(cat_str))
ein$col_str=mapvalues(ein$Category, cat_str, pal_col)

plot(0.1, type="n", log="xy",
	yaxs="i",
	xlim=range(ein$Max_Memory), ylim=c(1, 800),
	xlab="Maximum memory (Kbytes)", ylab="Average cost\n")

d_ply(ein, .(Category), plot_pts)

legend(x="bottomright", legend=cat_str, bty="n", fill=pal_col, cex=1.2)

