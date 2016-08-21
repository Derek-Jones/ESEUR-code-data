#
# slash_hist.R,  5 Aug 16
#
# Data from:
# Homogeneous temporal activity patterns in a large online communication space
# Andreas Kaltenbrunner and Vicen\c{c} G\'{o}mez and Ayman Moghnieh and Rodrigo Meza and Josep Blat and Vicente L\'{o}pez
# Data kindly supplied by Kaltenbrunner.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# The plots are both based on variable width bins
# with the upper plot showing total count in each bin and the lower
# plot showing the count density (i.e., total accesses per unit time).  
# 
# The data is a count of visitor accesses to a particular article
# appearing on the Slashdot news site, and peak access appears much
# later after publication in the left plot because access counts have
# been aggregated over a much wider range of times in later bins than
# earlier bins; the right plot shows access counts per unit time, which
# peaks soon after publication of the article.footnote:[While data
# created using fixed width bins can be plotted on a logarithmic
# x-axis, a lot of care is needed to ensure that interaction between
# bin width and use of a logarithmic axis does not introduce spurious
# visual artefacts.  Why invest effort in taking this risk?]


source("ESEUR_config.r")


plot_layout(2, 1)

slash = read.csv(paste0(ESEUR_dir, "probability/0708.1579v1.fig6.csv.xz"), head=TRUE)


work_tab=table(slash$users)

# plot(work_tab, type="l", log="x",
# 	main="",
# 	xlab="Minutes", ylab="Frequency")

# hist(log(slash$users),
# 	main="",
# 	xlab="log(minutes)")

# Calculate bin width as a geometric progression
bin_offset=exp(seq(0, log(max(slash$users)), length.out=11))

t=hist(slash$users, breaks=bin_offset, plot=FALSE)

plot(bin_offset[-length(t$count)], t$count, log="x", type="s",
	col=point_col,
	xlab="Minutes", ylab="Total accesses per bin\n")

plot(bin_offset[-length(t$count)], t$density, log="x", type="s",
	col=point_col,
	xlab="Minutes", ylab="Density (accesses per unit time)\n")

# x_pts=seq(1, max(slash$users), length.out=1000)
# t=hist(slash$users, breaks=x_pts, plot=FALSE)
# 
# x_pts=seq(1, max(slash$users), length.out=1000)
# plot(x_pts[-1000], t$count, log="x", type="s",
# 	col="blue",
# 	xlab="Minutes", ylab="Total accesses per bin")

