#
# DeLamarter.R, 12 Aug 17
# Data from:
# Big Blue: {IBM's} Use and Abuse of Power
# Richard Thomas DeLamarter
# Table 12
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


plot_system=function(df)
{
lines(df$Memory, df$Profit., col=df$col)
}


# Table 10 figures for 1967
rental=c("2,500", "2,500", " 9,800", "18,700", "31,100", "53,300")

ibm=read.csv(paste0(ESEUR_dir, "economics/DeLamarter.csv.xz"), as.is=TRUE)

systems=unique(ibm$System)

pal_col=rainbow(length(systems))
ibm$col=mapvalues(ibm$System, systems, pal_col[factor(systems)])


plot(ibm$Memory, ibm$Profit., type="n", log="x",
	xaxt="n",
	xlab="Memory (kilobytes)", ylab="% Profit\n")
axis(1, 2^c(2:10))

d_ply(ibm, .(System), plot_system)

legend(x="bottomright", legend=paste0("360/", systems, " ($", rental, ")"), bty="n", fill=pal_col, cex=1.2)

