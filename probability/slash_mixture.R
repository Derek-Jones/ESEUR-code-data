#
# slash_mixture.R, 17 Dec 19
#
# Data from:
# Homogeneous temporal activity patterns in a large online communication space
# Andreas Kaltenbrunner and Vicen\c{c} G\'{o}mez and Ayman Moghnieh and Rodrigo Meza and Josep Blat and Vicente L\'{o}pez
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG


source("ESEUR_config.r")

library("rebmix")


plot_layout(2, 1)

slash = read.csv(paste0(ESEUR_dir, "probability/0708.1579v1.fig6.csv.xz"), as.is=TRUE)

slash_mod=REBMIX(Dataset=list(data.frame(users=log(slash$users))),
 		Preprocessing="histogram",
 		cmax=7,
 		Variables="continuous",
 		pdf="normal",
 		K=7:45)

# slash_mod=REBMIX(Dataset=list(data.frame(users=log(slash$users))),
#  		Preprocessing="histogram",
#  		cmax=5,
#  		Variables="discrete",
#  		pdf="Poisson",
#  		K=7:40)


# coef(slash_mod)
# plot(slash_mod)


library("mixtools")


slash_dist=normalmixEM(log(slash$users), k=5)

# summary(slash_dist)
# t=boot.se(slash_dist)


# The most likely behavior is not the default!
# plot(slash_dist, whichplots=2, main2="",
# 	xlab2="Time (mins)")


pal_col=rainbow(5)
x_vals=seq(0, 10, by=0.1)
work_den=density(log(slash$users), adjust=0.5)


# Plot REBMIX fit
plot_REBMIX_dist=function(dist_num)
{
# @, rather than $, is used because slash_mod is an S4 class,
# and no coef is supplied!
y_vals=dnorm(x_vals, mean=as.numeric(slash_mod@Theta[[1]][2+(dist_num-1)*3]),
		 sd=as.numeric(slash_mod@Theta[[1]][3+(dist_num-1)*3]))

lines(x_vals, slash_mod@w[[1]][dist_num]*y_vals, col=pal_col[dist_num])
}


plot(work_den, main="",
	xlim=c(0, 10), ylim=c(0, 0.36),
	xlab="", ylab="Access density\n")
plot_REBMIX_dist(1)
plot_REBMIX_dist(2)
plot_REBMIX_dist(3)
plot_REBMIX_dist(4)

# Plot mixtools fit
plot_mix_dist=function(dist_num)
{
y_vals=dnorm(x_vals, mean=slash_dist$mu[dist_num], sd=slash_dist$sigma[dist_num])

lines(x_vals, slash_dist$lambda[dist_num]*y_vals, col=pal_col[dist_num])
}


plot(work_den, main="",
	xlim=c(0, 10), ylim=c(0, 0.36),
	xlab="log(Minutes)", ylab="Access density\n")
plot_mix_dist(1)
plot_mix_dist(2)
plot_mix_dist(3)
plot_mix_dist(4)
plot_mix_dist(5)

