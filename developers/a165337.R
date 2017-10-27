#
# a165337.R, 12 Oct 17
# Data from:
# A Quantitative Analysis of Software Developed in {Ada}
# Victor R. Basili and Nora Monina Panlilio-Yap amd Connie Loggia Ramsey and Chang Shih and Elizabeth E. Katz
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow_hcl(2)

changes=read.csv(paste0(ESEUR_dir, "developers/a165337.csv.xz"), as.is=TRUE)

plot(changes$Effort, changes$Need_change, type="h", log="xy", col=pal_col[1],
	xaxt="n",
	xlim=c(0.1, 10),
	xlab="Hours", ylab="Changes\n")

points(changes$Effort*1.05, changes$Impl_change, type="h", col=pal_col[2])

x_pts=c(0.1, 0.2, 0.5, 1.0, 2.0, 4.0, 24)

axis(1, at=x_pts, label=x_pts)

legend(x="topright", legend=c("Needed decision", "Design+implement"), bty="n", fill=pal_col, cex=1.2)

