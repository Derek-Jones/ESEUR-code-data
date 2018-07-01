#
# CompWorld85.R,  3 Jun 18
# Data from:
# Hardware Roundup
# Tom Henkel
# ComputerWorld, 19 Aug 1985, pages 23--34
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG hardware performance price 1985


source("ESEUR_config.r")


library("plyr")


plot_pts=function(df)
{
points(df$Memory.Size, df$Purchase.Price, col=df$col_str)

# points(as.numeric(df$Relative.Performance), df$Purchase.Price, col=df$col_str)
}


cw85=read.csv(paste0(ESEUR_dir, "ecosystems/CompWorld85.csv.xz"), as.is=TRUE)

cat_str=unique(cw85$Category)
pal_col=rainbow(length(cat_str))
cw85$col_str=mapvalues(cw85$Category, cat_str, pal_col)

plot(1, type="n", log="xy",
	# xlim=c(5, 5000), ylim=range(cw85$Purchase.Price),
	xlim=range(cw85$Memory.Size), ylim=range(cw85$Purchase.Price),
	xlab="Memory (MB)", ylab="Purchase price ($)\n")

d_ply(cw85, .(Category), plot_pts)

legend(x="bottomright", legend=cat_str, bty="n", fill=pal_col, cex=1.2)

