#
# bransford71.R, 25 Jul 18
# Data from:
# The Abstraction of Linguistic Ideas
# John D. Bransford and Jeffery J. Franks
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG sentence experiment reading recall


source("ESEUR_config.r")


pal_col=rainbow(2)


sent=read.csv(paste0(ESEUR_dir, "sourcecode/bransford71.csv.xz"), as.is=TRUE)


E1=subset(sent, sentence == "E1")
E2=subset(sent, sentence == "E2")

plot(E1$idea_units, E1$confidence, col=pal_col[1], type="b",
	lab=c(4, 5, 7), # stop .5 labels appearing
	xlab="Idea units", ylab="Confidence level")
points(E2$idea_units, E2$confidence, col=pal_col[2], type="b")

legend(x="bottomright", legend=c("Experiment 1", "Experiment 2"), bty="n", fill=pal_col, cex=1.2)

