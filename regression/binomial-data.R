#
# binomial-data.R,  9 Mar 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(2)

# Simulate some 0/1 data
answer=data.frame(x=c(rnorm(20, mean=1), rnorm(20, mean=3)),
                  y=c(rep(0, 20), rep(1, 20)))

plot(answer,
	xlab="Explanatory variable", ylab="Response variable\n")

sl=glm(y ~ x, data=answer)
lines(answer$x, predict(sl), col=pal_col[1])

b_sl=glm(y ~ x, data=answer, family=binomial)

x_vals=seq(-1, 5, by=0.1)
lines(x_vals, predict(b_sl, newdata=data.frame(x=x_vals), type="response"), col=pal_col[2])


