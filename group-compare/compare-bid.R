#
# compare-bid.R, 24 Aug 16
#
# Data from:
# An Empirical Study of Software Project Bidding
# Magne Jorgensen and Gunnar J. Carelius
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("boot")

mean_diff=function(bids, indices)
{
t=bids[indices]
return(mean(t[1:num_A_bids])-mean(t[(num_A_bids+1):total_bids]))
}


# CompId,Group,CompSize,ExpApp,ExpTech,DevMeth,Delay,Completeness,Bid,Pre_Bid
comp_bid=read.csv(paste0(ESEUR_dir, "economics/proj-bidding.csv.xz"), as.is=TRUE)

comp_A_pre=read.csv(paste0(ESEUR_dir, "economics/proj-bid-Apre.csv.xz"), as.is=TRUE)

A_final=subset(comp_bid, Group == "A")
B_final=subset(comp_bid, Group == "B")

num_A_bids=nrow(A_final)
num_B_bids=nrow(B_final)
total_bids=num_A_bids+num_B_bids
AB_mean_diff=mean(A_final$Bid)-mean(B_final$Bid)

bid_boot=boot(comp_bid$Bid, mean_diff, R = 4999)

plot(density(bid_boot$t),
	main="", ylab="Density\n")

mean(bid_boot$t)
sd(bid_boot$t)

length(bid_boot$t[abs(bid_boot$t) >= AB_mean_diff])


