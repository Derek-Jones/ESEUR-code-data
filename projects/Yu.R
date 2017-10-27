#
# Yu.R,  5 Sep 17
# Data from:
# Managing Application Software Suppliers in Information System Development Projects
# Angus Gonghua Yu
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(4)

Yu=read.csv(paste0(ESEUR_dir, "projects/Yu.csv.xz"), as.is=TRUE)
Yu$Date=as.Date(Yu$Date, format="%d/%m/%Y")

plot(Yu$Date, Yu$Total_est/1000, type="l", col=pal_col[1], log="y",
	ylim=c(0.220, max(Yu$Total_est)/1000),
	xlab="Date (2000-2001)", ylab="Estimated cost (£million)\n")

lines(Yu$Date, Yu$SLC_thou/1000, col=pal_col[2])
lines(Yu$Date, Yu$MSS_IFG_thou/1000, col=pal_col[3])
lines(Yu$Date, Yu$NQ_thou/1000, col=pal_col[4])

legend(x="bottomright", legend=c("Estimated total", "Prime contractor", "Subcontractor 1", "Subcontractor 2"), bty="n", fill=pal_col, cex=1.2)

