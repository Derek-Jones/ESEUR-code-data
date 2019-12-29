#
# SSRN-id1028592.R,  7 Dec 19
# Data from:
# Returns to Angel Investors in Groups
# Rober Wiltbank and Warren Boeker
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG ROI investor_angel

source("ESEUR_config.r")


rt=read.csv(paste0(ESEUR_dir, "economics/SSRN-id1028592.csv.xz"), as.is=TRUE)

rt20=subset(rt, basemultiple < 15)
plot(density(rt20$basemultiple, na.rm=TRUE, from=0),
	xlab="ROI", ylab="Density\n")

