#
# opensignal-tree.R, 22 Aug 18
#
# Data from:
#
# ANDROID FRAGMENTATION VISUALIZED (AUGUST 2015)
# This data is provided by OpenSignal.com and is licensed according to Creative Commons Attribution and ShareAlike License (BY-SA).
# If you have any questions on OpenSignal data licensing or anything else please email sam@opensignal.com
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Android market-share hardware phone


source("ESEUR_config.r")


library("treemap")


pal_col=rainbow_hcl(20)


android=read.csv(paste0(ESEUR_dir, "communicating/2015_08_devices_seen.csv.xz"), as.is=TRUE)

android$brand=tolower(android$brand)

and_tree=treemap(android, c("brand", "model"), "august2015",
		title="", palette=pal_col,
		border.col="white", border.lwds=c(0.5, 0.25))


