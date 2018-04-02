#
# WEIS_2016.R, 16 Mar 18
# Data from:
# Given Enough Eyeballs, All Bugs Are Shallow? {Revisiting} {Eric Raymond} with Bug Bounty Programs
# Thomas Maillart and Mingyi Zhao and Jens Grossklags and John Chuang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)

bounty=read.csv(paste0(ESEUR_dir, "ecosystems/WEIS_2016.csv.xz"), as.is=TRUE)
bounty$Date=as.Date(bounty$Timestamp, format="%d/%m/%Y")

V_bounty=read.csv(paste0(ESEUR_dir, "ecosystems/Vuln-Discovery.csv.xz"), as.is=TRUE)
V_bounty$Date=as.Date(V_bounty$TimeStamp, format="%Y/%m/%d")

# plot(bounty$Date, bounty$Bounty)

r_total=ddply(bounty, .(Researcher), function(df) sum(df$Bounty))

plot(sort(r_total$V1, decreasing=TRUE), log="xy", col=pal_col[1],
	xlab="Researcher", ylab="Dollars awarded\n")


# plot(sort(table(bounty$Researcher)), log="y")

V_bounty=subset(V_bounty, Bounty >= 10)

v_total=ddply(V_bounty, .(s_Name), function(df) sum(df$Bounty, na.rm=TRUE))

points(sort(v_total$V1, decreasing=TRUE), col=pal_col[2])

legend(x="bottomleft", legend=c("Mar 2014-Feb 2016", "Nov 2013-Aug 2015"), bty="n", fill=pal_col, cex=1.2)


