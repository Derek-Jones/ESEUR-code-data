#
# company-growth.R, 18 Apr 19
# Data from:
# From Airline Reservations to {Sonic} the {Hedgehog}: {A} History of the Software Industry
# Martin Campbell-Kelly
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG company employees evolution

source("ESEUR_config.r")


library("plyr")


plot_revenue=function(df)
{
# lines(df$Year, df$Revenues/1e9, col=df$col_str)
lines(df$Year, df$Employees, col=df$col_str)
}


cg=read.csv(paste0(ESEUR_dir, "economics/company-growth.csv.xz"), as.is=TRUE)

companies=unique(cg$Company)
pal_col=rainbow(length(companies))
cg$col_str=mapvalues(cg$Company, companies, pal_col)

# 0.92 is the average Euro -> dollar exchange rate during 2000
cg$Revenues[cg$Company == "SAP"]=cg$Revenues[cg$Company == "SAP"]*0.92

plot(1, type="n", log="y",
	# xlim=range(cg$Year), ylim=c(1e-5, 2e1),
	xlim=range(cg$Year), ylim=c(3, 5e4),
	xlab="Year", ylab="Employees\n")

d_ply(cg, .(Company), plot_revenue)

legend(x="bottomright", legend=companies, bty="n", fill=pal_col, cex=1.2)

