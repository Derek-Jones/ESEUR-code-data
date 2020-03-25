#
# putnam-MTTF-lin.R,  4 Mar 20
#
# Data from:
# Measures for Excellence: Reliable software on time, within budget
# Lawrence H. Putnam and Ware Myers
# Figure 8.3
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG afilure_mean-time


source("ESEUR_config.r")


plot_layout(1, 2)
par(mar=MAR_default-c(0.0, 0.6, 0.0, 1.0))



MTTF=read.csv(paste0(ESEUR_dir, "regression//putnam-MTTF.csv.xz"), as.is=TRUE)

plot(MTTF, log="x", col=point_col,
          xlab="Effective Source KLOC", ylab="Mean Time to Fail (days)\n")

plot(MTTF, log="xy", col=point_col,
          xlab="Effective Source KLOC", ylab="")

