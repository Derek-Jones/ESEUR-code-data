#
# bitflips.R, 17 Dec 17
# Data from:
# Soft-Error Rate of Advanced {SRAM} Memories: {Modeling} and Monte Carlo Simulation
# Jean-Luc Autran and Sergey Semikh and Daniela Munteanu and S{\'e}bastien Serre and Gilles Gasiot and Philippe Roche
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

flips=read.csv(paste0(ESEUR_dir, "reliability/bitflips.tsv"), sep="\t", as.is=TRUE)

nm40=subset(flips, nm == 40)
nm65=subset(flips, nm == 65)
nm130=subset(flips, nm == 130)

plot(nm40$MbitHr/1e7, nm40$flip, col=pal_col[1], pch=18,
	xaxt="n", xaxs="i", yaxs="i",
	xlab=expression("Mbit hours x10" ^7), ylab="Cumulative bit-flips\n")

points(nm65$MbitHr/1e7, nm65$flip, col=pal_col[2], pch=18)
points(nm130$MbitHr/1e7, nm130$flip, col=pal_col[3], pch=18)

legend(x="topleft", legend=c("40nm SRAM, top mountain", "65nm SRAM, under mountain", "130nm SRAM, under mountain"), bty="n", fill=pal_col, cex=1.2)

# plot(1e9*nm40$flip/nm40$MbitHr, col=pal_col[1], pch=18,
# 	ylim=c(0, 6.0e3), xaxs="i", yaxs="i",
# 	xlab="Cumulative bit-flips", ylab="SER (FIT/Mbit)\n")
# 
# # Plot confidence interval using equation 8 from:
# # Real-time soft-error rate measurements: A review
# # J.L. Autran, D. Munteanu, P. Roche, G. Gasiot
# lines(1e9*qchisq(0.05, 2*(nm40$flip+1))/(2*nm40$MbitHr), col="pink")
# lines(1e9*qchisq(0.95, 2*(nm40$flip+1))/(2*nm40$MbitHr), col="pink")
# 
# points(1e9*nm65$flip/nm65$MbitHr, col=pal_col[2], pch=18)
# points(1e9*nm130$flip/nm130$MbitHr, col=pal_col[3], pch=18)
# 
# legend(x="bottomright", legend=c("40nm SRAM, top mountain", "65nm SRAM, under mountain", "130nm SRAM, under mountain"), bty="n", fill=pal_col, cex=1.2)
# 
# 
