#
# overney20donations.R, 10 May 20
# Data from:
# How to Not Get Rich: {An} Empirical Study of Donations in {Op{\euro}n} {\$}our{\textcent}e
# Cassandra Overney and Jens Meinicke and Christian K{\"a}stner and Bogdan Vasilescu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


library("plyr")


mdon=read.csv(paste0(ESEUR_dir, "ecosystems/overney20donations.csv.xz"), as.is=TRUE)

mon_av=ddply(mdon, .(project_id), function(df) mean(df$earning_after_adoption))

plot(sort(mon_av$V1), log="y", col=point_col,
	xaxs="i",
	xlab="Project", ylab="Monthly donation (dollars)\n")

