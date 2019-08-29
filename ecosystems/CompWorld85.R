#
# CompWorld85.R,  9 Aug 19
# Data from:
# Hardware Roundup, ComputerWorld, XIX, 33, pages 23--34, 19 aug 1985
# Tom Henkel
# ComputerWorld, 19 Aug 1985, pages 23--34
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG hardware performance price 1985


source("ESEUR_config.r")


library("plyr")


plot_pts=function(df)
{
points(df$Memory.Size, df$Purchase.Price/1e3, col=df$col_str)

# points(as.numeric(df$Relative.Performance), df$Purchase.Price, col=df$col_str)
}


cw85=read.csv(paste0(ESEUR_dir, "ecosystems/CompWorld85.csv.xz"), as.is=TRUE)

cat_str=unique(c("Mainframe", cw85$Category))
pal_col=rainbow(length(cat_str))
cw85$col_str=mapvalues(cw85$Category, cat_str, pal_col)

plot(1, type="n", log="xy",
	# xlim=c(5, 5000), ylim=range(cw85$Purchase.Price/1e3),
	xlim=range(cw85$Memory.Size), ylim=range(cw85$Purchase.Price/1e3),
	xlab="Memory (MB)", ylab="Purchase price ($thousand)\n")

d_ply(cw85, .(Category), plot_pts)

legend(x="bottomright", legend=cat_str, bty="n", fill=pal_col, cex=1.2)

