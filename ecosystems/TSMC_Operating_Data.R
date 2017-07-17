#
# TSMC_Operating_Data.R,  1 Jun 17
# Data from:
# TSMC...
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)


plot_prod=function(production, size_str, col_str)
{
lines(TSMC$Date, production, col=col_str)
start=TSMC$Date[min(which(!is.na(production)))]
text(start, 0, size_str)
}

TSMC=read.csv(paste0(ESEUR_dir, "ecosystems/TSMC_Operating_Data.csv.xz"), as.is=TRUE)
TSMC$Date=as.Date(TSMC$Date, format="%d-%b-%y")

pal_col=rainbow(9)

TSMC_2k=subset(TSMC, Date > "2000-01-01")

plot(TSMC_2k$Date, TSMC_2k$X0.25um, type="l", col=pal_col[1],
	ylim=c(0, 50),
	xlab="Date", ylab="Revenue %")
# plot_prod(TSMC_2k$X0.18um, "0.18um", pal_col[2])
lines(TSMC_2k$Date, TSMC_2k$X0.18um, col=pal_col[2])
lines(TSMC_2k$Date, TSMC_2k$X0.15um, col=pal_col[3])
lines(TSMC_2k$Date, TSMC_2k$X0.11.0.13um, col=pal_col[4])
lines(TSMC_2k$Date, TSMC_2k$X90nm, col=pal_col[5])
lines(TSMC_2k$Date, TSMC_2k$X65nm, col=pal_col[6])
lines(TSMC_2k$Date, TSMC_2k$X40.45nm, col=pal_col[7])
lines(TSMC_2k$Date, TSMC_2k$X28nm, col=pal_col[8])
lines(TSMC_2k$Date, TSMC_2k$X16.20nm, col=pal_col[9])

legend(x="topleft", legend=c("0.25um+", "0.18um", "0.15um", "0.11/0.13um", "90nm", "65nm", "40/45nm", "28nm", "16/20nm"),
 		bty="n", fill=pal_col, cex=1.2)

pal_col=rainbow(4)

TSMC_98=subset(TSMC, Date > "1998-01-01")

plot(TSMC_98$Date, TSMC_98$Computer, type="l", col=pal_col[1],
	ylim=c(0, 70),
	xlab="Date", ylab="Revenue %")
lines(TSMC_98$Date, TSMC_98$Communication, col=pal_col[2])
lines(TSMC_98$Date, TSMC_98$Consumer, col=pal_col[3])
lines(TSMC_98$Date, TSMC_98$Industrial.Standard, col=pal_col[4])

legend(x="topleft", legend=c("Computer", "Communication", "Consumer", "Industrial/Standard"),
 		bty="n", fill=pal_col, cex=1.2)



