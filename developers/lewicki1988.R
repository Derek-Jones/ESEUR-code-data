#
# lewicki1988.R, 22 Jul 18
# Data from:
# Acquisition of Procedural Knowledge about a Pattern Stimuli That Cannot be Articulated
# Pawel Lewicki and Thomas Hill and Elizabeth Bizot
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG experiment implicit learning


source("ESEUR_config.r")


lew=read.csv(paste0(ESEUR_dir, "developers/lewicki1988.csv.xz"), as.is=TRUE)

plot(lew$Segment, lew$Response, col=point_col,
	xlab="Segment (240 trials)", ylab="Response (msec)\n")

# r_mod=glm(log(Response) ~ Segment, data=lew, subset=1:15)
r_mod=glm(log(Response) ~ Segment, data=lew, subset=2:15)
# summary(r_mod)

pred=predict(r_mod)
lines(2:15, exp(pred), col=point_col)

