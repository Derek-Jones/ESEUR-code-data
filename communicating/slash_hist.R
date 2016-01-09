#
# slash_hist.R,  6 Oct 14
#
# Data from:
# Homogeneous temporal activity patterns in a large online communication space
# Andreas Kaltenbrunner and Vicen\c{c} G\'{o}mez and Ayman Moghnieh and Rodrigo Meza and Josep Blat and Vicente L\'{o}pez
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 2)

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
	col="blue",
	xlab="Minutes", ylab="Total accesses per bin\n")

plot(bin_offset[-length(t$count)], t$density, log="x", type="s",
	col="blue",
	xlab="Minutes", ylab="Density (accesses per unit time)\n")

# x_pts=seq(1, max(slash$users), length.out=1000)
# t=hist(slash$users, breaks=x_pts, plot=FALSE)
# 
# x_pts=seq(1, max(slash$users), length.out=1000)
# plot(x_pts[-1000], t$count, log="x", type="s",
# 	col="blue",
# 	xlab="Minutes", ylab="Total accesses per bin")

