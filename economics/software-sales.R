#
# software-sales.R,  2 May 19
# Data from:
# Recognition of Business and Government Expenditures for Software as Investment: {Methodology} and Quantitative Impacts, 1959-98, plus P2000-2-table11.xls update
# Robert Parker and Bruce Grimm
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG software_sales US_sales package_sales software_custom economics

source("ESEUR_config.r")


pal_col=rainbow(3)


ssale=read.csv(paste0(ESEUR_dir, "economics/software-sales.csv.xz"), as.is=TRUE)


plot(ssale$Year, ssale$Bp_Own_account, log="y", type="b", col=pal_col[1],
	xaxs="i",
	xlab="Year", ylab="Dollars (billion)\n")
points(ssale$Year, ssale$Bp_Custom, type="b", col=pal_col[2])
points(ssale$Year, ssale$Bp_Prepackaged, type="b", col=pal_col[3])

legend(x="topleft", legend=c("Own account", "Custom", "Prepackaged"), bty="n", fill=pal_col, cex=1.2)

lines(ssale$Year, ssale$FG_Own_account+ssale$Slg_Own_account, col=pal_col[1])
lines(ssale$Year, ssale$FG_Custom+ssale$Slg_Custom, col=pal_col[2])
lines(ssale$Year, ssale$FG_Prepackaged+ssale$Slg_Prepackaged, col=pal_col[3])

