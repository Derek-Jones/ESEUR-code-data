#
# lewicki1988.R, 30 Sep 19
# Data from:
# Acquisition of Procedural Knowledge about a Pattern Stimuli That Cannot be Articulated
# Pawel Lewicki and Thomas Hill and Elizabeth Bizot
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human learning_implicit


source("ESEUR_config.r")


pal_col=rainbow(2)


lew=read.csv(paste0(ESEUR_dir, "developers/lewicki1988.csv.xz"), as.is=TRUE)

plot(lew$Segment, lew$Response, col=pal_col[2],
	xlab="Segment (240 trials)", ylab="Response (msec)\n")

# r_mod=glm(log(Response) ~ Segment, data=lew, subset=1:15)
r_mod=glm(log(Response) ~ Segment, data=lew, subset=2:15)
# summary(r_mod)

pred=predict(r_mod)
lines(2:15, exp(pred), col=pal_col[1])

