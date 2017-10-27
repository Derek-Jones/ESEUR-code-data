#
# mohanty1981.R, 23 Oct 17
# Data from:
# Software Cost Estimation: Present and Future
# Siba N. Mohanty
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


est=read.csv(paste0(ESEUR_dir, "projects/mohanty1981.csv.xz"), as.is=TRUE)
est=est[order(est$Estimate), ]

plot(est$Estimate/1e6, col=point_col,
	xaxt="n",
	xlab="", ylab="Estimate ($ million)\n")

x_at=1:nrow(est)
axis(1, at=x_at, labels=FALSE)
text(x=x_at+0.5, y=par()$usr[3]-0.03*(par()$usr[4]-par()$usr[3]),
                labels=est$Method, pos=2, srt=25, cex=1.1, xpd=TRUE)


