#
# empirical_jorg.R, 23 May 20
# Data from:
# An Empirical Study of Software Project Bidding
# Magne Jorgensen and Gunnar J. Carelius
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human project_bidding


source("ESEUR_config.r")


pal_col=rainbow(3)


est=read.csv(paste0(ESEUR_dir, "projects/empirical_jorg.csv.xz"), as.is=TRUE)

Ag=subset(est, Group == "ExpA")
Bg=subset(est, Group == "ExpB")
Ag=Ag[order(Ag$Final_Estimate), ]
Bg=Bg[order(Bg$Final_Estimate), ]


plot(Ag$Early_Estimate, log="y", col=pal_col[1],
	xaxt="n",
	xlim=c(1, nrow(est)), ylim=range(c(est$Early_Estimate, est$Final_Estimate), na.rm=TRUE),
	xlab="Estimator", ylab="Estimate (hours)\n")
axis(1, at=c(5, 15), label=c("A group", "B group"))
lines(c(10.5, 10.5), c(10, 6000), col="grey")

points(Ag$Final_Estimate, col=pal_col[2])
points((nrow(Ag)+1):(nrow(Ag)+nrow(Bg)), Bg$Final_Estimate, col=pal_col[3])

legend(x="bottom", legend=c("A early estimate", "A final estimate", "B final estimate"), bty="n", fill=pal_col, cex=1.2)

