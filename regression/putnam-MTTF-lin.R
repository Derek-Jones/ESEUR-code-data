#
# putnam-MTTF-lin.R, 15 Jul 16
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


plot_layout(2, 1)
pal_col=rainbow(3)


MTTF=read.csv(paste0(ESEUR_dir, "regression//putnam-MTTF.csv.xz"), as.is=TRUE)

plot(MTTF, log="x", col=point_col,
          xlab="Effective Source KLOC", ylab="Mean Time to Fail (days)\n")

plot(MTTF, log="xy", col=point_col,
          xlab="Effective Source KLOC", ylab="Mean Time to Fail (days)\n")

