#
# noisy-quad.R, 31 Mar 16
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


noisy=data.frame(x_vals=rep(1:10, 30),
		 y_vals=x_vals + x_vals^2+100*rnorm(length(x_vals)))


plot(noisy$x_vals, noisy$y_vals)

y_mod=glm(y_vals ~ x_vals+I(x_vals^2), data=noisy)

summary(y_mod)


