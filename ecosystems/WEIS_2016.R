#
# WEIS_2016.R,  7 Jul 17
# Data from:
# Given Enough Eyeballs, All Bugs Are Shallow? {Revisiting} {Eric Raymond} with Bug Bounty Programs
# Thomas Maillart and Mingyi Zhao and Jens Grossklags and John Chuang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


bounty=read.csv(paste0(ESEUR_dir, "ecosystems/WEIS_2016.csv.xz"), as.is=TRUE)
bounty$Date=as.Date(bounty$Timestamp, format="%d/%m/%Y")

# plot(bounty$Date, bounty$Bounty)

r_total=ddply(bounty, .(Researcher), function(df) sum(df$Bounty))

plot(sort(r_total$V1, decreasing=TRUE), log="xy", col=point_col,
	xlab="Researcher", ylab="Dollars earned\n")


