#
# VGChartz-sales.R, 22 Apr 17
# Data from:
# VGChartz
# VGChartz Global Yearly Chart: 2005-2016
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)


plot_sales=function(df)
{
hard=subset(df, hardware == 1)
soft=subset(df, hardware != 1)

if (max(hard$sales, rm.na=TRUE) < 12)
   return()

lines(hard$year, hard$sales, type="b", lty=3, col=pal_col[col_num])
lines(soft$year, soft$sales/soft_scale, col=pal_col[col_num])

col_num <<- col_num+1
}


games=read.csv(paste0(ESEUR_dir, "economics/VGChartz-sales.csv.xz"), as.is=TRUE)

games$sales=games$sales/1e6

col_num=1
plot(0, type="n",
	xlim=c(2005, 2016), ylim=c(1, 36),
	xlab="Year", ylab="Hardware sales (millions)")

soft_scale=5
soft_pts=c(0, 10, 20, 30, 40)
axis(side=4, at=soft_pts, labels=soft_pts*soft_scale)
mtext("Software sales (millions)", side=4, las=0, padj=3, cex=0.75)

plot_sales(subset(games, product == "Wii"))
plot_sales(subset(games, product == "PS3"))
plot_sales(subset(games, product == "X360"))

legend(x="topright", legend=c("Wii", "PS3", "X360"), bty="n", fill=pal_col, cex=1.2)


# library("plyr")
# d_ply(games, .(product), plot_sales)

