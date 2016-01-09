#
# putnam-MTTF-lin.R,  5 Jan 16
#
# Data from:
# Measures for Excellence: Reliable software on time, within budget
# Lawrence H. Putnam and Ware Myers
# Figure 8.3
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

plot_layout(1, 2)

MTTF=read.csv(paste0(ESEUR_dir, "regression//putnam-MTTF.csv.xz"), as.is=TRUE)

plot(MTTF, log="x", col=point_col,
          xlab="Effective Source KLOC", ylab="Mean Time to Fail (days)\n")

plot(MTTF, log="xy", col=point_col,
          xlab="Effective Source KLOC", ylab="Mean Time to Fail (days)\n")

