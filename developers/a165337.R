#
# a165337.R, 24 Feb 19
# Data from:
# A Quantitative Analysis of Software Developed in {Ada}
# Victor R. Basili and Nora Monina Panlilio-Yap amd Connie Loggia Ramsey and Chang Shih and Elizabeth E. Katz
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Ada effort


source("ESEUR_config.r")


pal_col=rainbow(2)

changes=read.csv(paste0(ESEUR_dir, "developers/a165337.csv.xz"), as.is=TRUE)

plot(changes$Effort, changes$Need_change, type="h", log="xy", col=pal_col[1],
	xaxt="n",
	xlim=c(0.1, 10),
	xlab="Time needed (hours)", ylab="Changes\n")

points(changes$Effort*1.05, changes$Impl_change, type="h", col=pal_col[2])

x_pts=c(0.1, 0.2, 0.5, 1.0, 2.0, 4.0, 24)

axis(1, at=x_pts, label=x_pts)

legend(x="topright", legend=c("Determine change needed", "Design+implement"), bty="n", fill=pal_col, cex=1.2)

