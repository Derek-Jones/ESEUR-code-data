#
# 1901-07024a.R, 10 Feb 19
# Data from:
# Temporal Discounting in Technical Debt: {How} do Software Practitioners Discount the Future?
# Christoph Becker and Fabian Fagerholm and Rahul Mohanani and Alexander Chatzigeorgiou
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human subjects time-discounting

source("ESEUR_config.r")


library("plyr")


fit_subj=function(df)
{
ft=t(subset(df, select=grepl("TF", colnames(df))))
ft=ft/ft[1] # Normalise

lines(years, ft, type="b", col=df$col_str)
}


company=read.csv(paste0(ESEUR_dir, "developers/1901-07024.csv.xz"), as.is=TRUE)

c1=subset(company, Company == "C1")
c2=subset(company, Company == "C2")

c1$col_str=rainbow(nrow(c1))

years=c(1, 2, 3, 4, 5, 10)

plot(0, type="n",
	xaxt="n",
	yaxs="i",
	# xlim=c(0, 10), ylim=range(c1$TF10),
	xlim=c(1, 10), ylim=c(0, 11),
	xlab="Years", ylab="Days (normalised)\n")

axis(1, at=years, label=years)

# 'clean' data by removing subjects who savings requirement decreases with time
c1_grow=subset(c1, TF1 < TF10)

d_ply(c1_grow, .(individual), fit_subj)

