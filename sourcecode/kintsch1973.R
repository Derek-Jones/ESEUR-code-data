#
# kintsch1973.R, 11 Jul 18
# Data from:
# Reading Rate and Retention as a Function of the Number of Propositions in the Base Structure of Sentences
# Walter Kintsch and Janice Keenan
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG experiment reading performance


source("ESEUR_config.r")


pal_col=rainbow(2)


kint=read.csv(paste0(ESEUR_dir, "sourcecode/kintsch1973.csv.xz"), as.is=TRUE)

pres=subset(kint, Task == "Present")
recall=subset(kint, Task == "Recall")

plot(recall$Propositions, recall$Time, col=pal_col[1],
	ylim=range(kint$Time),
	xlab="Propositions", ylab="Time (secs)")
points(pres$Propositions, pres$Time, col=pal_col[2])

legend(x="bottomright", legend=c("Recalled", "Presented"), bty="n", fill=pal_col, cex=1.2)

r_mod=glm(Time ~ Propositions, data=recall)
summary(r_mod)

pred=predict(r_mod)
lines(recall$Propositions, pred, col=pal_col[1])


p_mod=glm(Time ~ Propositions, data=pres)
summary(p_mod)

pred=predict(p_mod)
lines(pres$Propositions, pred, col=pal_col[2])


