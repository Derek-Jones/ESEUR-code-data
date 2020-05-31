#
# putnam-MTTF-lin.R, 28 Apr 20
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


plot_layout(1, 4, max_width=16)
par(mar=MAR_default-c(0.0, 0.6, 0.0, 0.0))



MTTF=read.csv(paste0(ESEUR_dir, "regression//putnam-MTTF.csv.xz"), as.is=TRUE)

# A fake plot designed to shift the others two plots right
fake_plot=function()
{
plot(0, bty="n", type="n",
	xaxt="n", yaxt="n",
	xlim=c(1, 2), ylim=c(1, 2),
	xlab="", ylab="")
text(1, 1, ".", cex=0.1)
}

# Stuff to temporarily fix a book layout issue

fake_plot()
fake_plot()
mtext(text="Mean Time to Fail (days)\n", side=4, las=0, cex=0.8)

par(mar=MAR_default-c(0.0, 2.6, 0.0, 1.0))

plot(MTTF, log="x", col=point_col, cex.lab=1.5,
          xlab="Effective Source KLOC", ylab="Mean Time to Fail (days)\n")

plot(MTTF, log="xy", col=point_col, cex.lab=1.5,
          xlab="Effective Source KLOC", ylab="")

