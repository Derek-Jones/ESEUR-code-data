#
# alteneder1935.R, 11 Nov 16
# Data from:
# The Learning Curve in Solving a Jig-Saw Puzzle: {A} Teaching Device
# Louise E. Alteneder
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

jigsaw=read.csv(paste0(ESEUR_dir, "developers/alteneder1935.csv.xz"), as.is=TRUE)
jigsaw$trial=1:nrow(jigsaw)

plot(jigsaw$first, col=pal_col[1],
	ylim=range(jigsaw),
	xlab="Trial", ylab="Time taken (minutes)\n")
points(jigsaw$second, col=pal_col[2])

p1_mod=nls(first ~ a*trial^b+c, data=jigsaw,
		start=list(a=60, b=-0.5, c=4))
pred=predict(p1_mod)
lines(pred, col=pal_col[1])

p1_mod=nls(first ~ a*exp(b*trial)+c, data=jigsaw,
		start=list(a=60, b=-0.5, c=3))
# summary(p1_mod)

pred=predict(p1_mod)
lines(pred, col=pal_col[1])


p2_mod=nls(second ~ a*exp(b*trial), data=jigsaw,
		start=list(a=15, b=-0.5))
pred=predict(p2_mod)
lines(pred, col=pal_col[2])

# Cannot get convergence with a constant offset
p2_mod=nls(second ~ a*trial^b, data=jigsaw,
		start=list(a=10, b=-0.1), trace=TRUE)
# summary(p2_mod)

pred=predict(p2_mod)
lines(pred, col=pal_col[2])


