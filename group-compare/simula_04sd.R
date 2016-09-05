#
# simula_04sd.R, 29 Aug 16
#
# Data from:
# Eliminating Over-Confidence in Software Development Effort Estimates
# Magne J{\o}rgensen and Kjetil Mol{\o}kken
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("boot")

sd_diff=function(est, indices)
{
t=est[indices]
return(sd(t[1:num_A_est])-sd(t[(num_A_est+1):total_est]))
}


est=read.csv(paste0(ESEUR_dir, "group-compare/simula_04.csv.xz"), as.is=TRUE)

A_est=subset(est, Group =="A")$Estimate
B_est=subset(est, Group !="A")$Estimate

num_A_est=length(A_est)
num_B_est=length(B_est)
total_est=num_A_est+num_B_est
AB_sd_diff=abs(sd(A_est)-sd(B_est))

bid_boot=boot(c(A_est, B_est), sd_diff, R = 4999)

plot(density(bid_boot$t),
	main="", ylab="Density\n")

mean(bid_boot$t)
sd(bid_boot$t)

length(bid_boot$t[abs(bid_boot$t) >= AB_sd_diff])


