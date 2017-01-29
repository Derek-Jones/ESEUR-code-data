#
# lichten77.R, 28 Jan 17
# Data from:
# Do Those Who Know More Also Know More about How Much They Know?
# Sarah Lichtenstein and Baruch Fishhoff
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

lichten=read.csv(paste0(ESEUR_dir, "developers/lichten77.csv.xz"), as.is=TRUE)


plot(lichten$subj_est, lichten$hard, type="b", col=pal_col[1],
	ylim=c(0.45, 1),
	xlab="Subject estimate", ylab="Proportion correct\n")
points(lichten$subj_est, lichten$easy, type="b", col=pal_col[3])
lines(lichten$subj_est, lichten$subj_est, col=pal_col[2])

legend(x="topleft", legend=c("Hard", "Perfect self-knowledg", "Easy"), bty="n", fill=pal_col, cex=1.2)

