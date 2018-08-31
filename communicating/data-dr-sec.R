#
# data.dr-sec.R, 29 Aug 18
# Data from:
# Data-Driven Security: Analysis, Visualization and Dashboards
# Jay Jacobs and Bob Rudis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG virus UFO


source("ESEUR_config.r")


ip_ufo=read.csv(paste0(ESEUR_dir, "communicating/county-data.csv.xz"), as.is=TRUE)

plot(ip_ufo$ufo2010, ip_ufo$ipaddr, log="xy", col=point_col,
	xlab="UFO reports", ylab="Virus infections reported\n")


