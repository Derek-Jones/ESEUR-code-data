#
# malloy-esem.R, 19 May 20
# Data from:
# Quantifying the Transition from {Python} 2 to 3: {An} Empirical Study of {Python} Applications
# Brian A. Malloy and James F. Power
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Python_evolution Python_compatibility Python_application

source("ESEUR_config.r")


library("plyr")


plot_conform=function(df)
{
date_conf=ddply(df, .(Date), function(df) return(mean(df$Compliance)))

lines(date_conf$Date, date_conf$V1, col=df$col_str)
}


py=read.csv(paste0(ESEUR_dir, "sourcecode/malloy-esem.csv.xz"), as.is=TRUE)
py$Date=as.Date(py$Date, format="%Y-%m-%d")

ver_str=sort(unique(py$Version))


pal_col=rainbow(length(ver_str))
py$col_str=mapvalues(py$Version, ver_str, pal_col)

# These get sorted last.
# Don't remove them until here, to try and stop the colors wrapping
py=subset(py, (Version != "2.4.3") & (Version != "2.7.2"))

plot(py$Date[1], 1, type="n",
	yaxs="i",
	xlim=range(py$Date), ylim=c(45, 100),
	xlab="Date", ylab="Conformance (mean percentage)\n")

d_ply(py, .(Version), plot_conform)

legend(x="bottomleft", legend=ver_str, bty="n", inset=-c(0.04, 0.02), fill=pal_col, cex=1.2)


