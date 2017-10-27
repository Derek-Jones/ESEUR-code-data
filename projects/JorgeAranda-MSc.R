#
# JorgeAranda-MSc.R, 18 Oct 17
# Data from:
# Anchoring and Adjustment in Software Estimation
# Jorge Aranda
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

plot_est=function(est, col_str)
{
points(1:length(est), sort(est), col=col_str)
}


est=read.csv(paste0(ESEUR_dir, "projects/JorgeAranda-MSc.csv.xz"), as.is=TRUE)

low=subset(est, Condition == 2)
high=subset(est, Condition == 20)
control=subset(est, is.na(Condition))


plot(0, type="n",
	xaxt="n",
	xlim=c(1, nrow(low)), ylim=c(1, max(est$Estimate)),
	xlab="Subjects", ylab="Estimate")
axis(1, at=1:9, label=rep("", 9))
plot_est(high$Estimate, pal_col[1])
plot_est(control$Estimate, pal_col[2])
plot_est(low$Estimate, pal_col[3])

legend(x="topleft", legend=c("20 months", "Control", "2 months"), bty="n", fill=pal_col, cex=1.2)

