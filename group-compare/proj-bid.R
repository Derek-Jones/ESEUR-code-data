#
# proj-bid.R,  4 Oct 17
#
# Data from:
# An Empirical Study of Software Project Bidding
# Magne Jorgensen and Gunnar J. Carelius
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# CompId,Group,CompSize,ExpApp,ExpTech,DevMeth,Delay,Completeness,Bid,Pre_Bid
comp_bid=read.csv(paste0(ESEUR_dir, "economics/proj-bidding.csv.xz"), as.is=TRUE)

comp_A_pre=read.csv(paste0(ESEUR_dir, "economics/proj-bid-Apre.csv.xz"), as.is=TRUE)

brew_col=rainbow(3)

plot(density(log(comp_A_pre$Bid), kernel="epanechnikov"),
	col=brew_col[1],
	xlim=c(9, 14), ylim=c(0, 0.7),
#	xlim=c(0, 6e+5), ylim=c(0, 3.2e-6),
	main="",
	xaxt="n", yaxt="n", xlab="Amount bid", ylab="Density")

lines(density(log(comp_bid$Bid[1:17]), kernel="epanechnikov"),
	col=brew_col[2])

lines(density(log(comp_bid$Bid[17:35]), kernel="epanechnikov"),
	col=brew_col[3])

legend(x="topleft", legend=c("A Outline", "A Detailed", "B Detailed"),
	 fill=brew_col, bty="n", cex=1.2)


