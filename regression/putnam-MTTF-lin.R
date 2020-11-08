#
# putnam-MTTF-lin.R,  4 Nov 20
#
# Data from:
# Measures for Excellence: Reliable software on time, within budget
# Lawrence H. Putnam and Ware Myers
# extracted from figure 8.3
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG failure_mean-time


source("ESEUR_config.r")


plot_layout(1, 2, default_height=16)

par(mar=MAR_default-c(0.0, -1.1, 0.0, 1.0))


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

# fake_plot()
# fake_plot()
# mtext(text="Mean Time to Fail (days)\n", side=4, las=0, cex=0.8)
# 
# par(mar=MAR_default-c(0.0, 2.6, 0.0, 1.0))

plot(MTTF, log="x", col=point_col, cex=1.7, cex.axis=2.6, cex.lab=2.3,
          xlab="", ylab="Mean Time to Fail (days)\n")
# axis(1, at=c(2, 5, 20, 50, 500), cex.lab=2)
mtext(text="Effective Source KLOC", side=1, las=0, cex=1.4, padj=1.8)

plot(MTTF, log="xy", col=point_col, cex=1.7, cex.axis=2.6, cex.lab=2.3,
          xlab="", ylab="")
mtext(text="Effective Source KLOC", side=1, las=0, cex=1.4, padj=1.8)

