#
# noisey-data.R, 12 Jul 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


plot_layout(2, 2)
pal_col=rainbow(3)



fit_and_plot=function(x, y)
{
# nls_mod = nls(y ~ a+b*x^power, start = list(a=1e5, b=1, power = 2),
# 			trace=TRUE)
# summary(nls_mod)

p_mod=glm(y ~ x, family=poisson)
l_mod=glm(y ~ log(x), family=poisson)
q_mod=glm(y ~ I(x^2))

print(summary(l_mod))
print(summary(p_mod))
print(summary(q_mod))

plot(x, y, log="y", col=point_col,
	ylab="y\n")
# pred=predict(l_mod, newdata=data.frame(x=1:100), type="response")
# lines(pred, col=pal_col[1])
pred=predict(p_mod, newdata=data.frame(x=1:100), type="response")
lines(pred, col=pal_col[2])
pred=predict(q_mod, newdata=data.frame(x=1:100))
lines(pred, col=pal_col[3])
}


fit_peaks=function(x, y)
{
peak_vals=ddply(data.frame(x, y), .(x),
		function(df)
			data.frame(x=df$x[1],
					y=tail(sort(df$y), n=3))
			)

p_mod=glm(y ~ x, data=peak_vals, family=poisson)
l_mod=glm(y ~ log(x), data=peak_vals, family=poisson)
q_mod=glm(y ~ I(x^2), data=peak_vals)

print(summary(l_mod))
print(summary(p_mod))
print(summary(q_mod))

# pred=predict(l_mod, newdata=data.frame(x=1:100), type="response")
# lines(pred, col=pal_col[1])
pred=predict(p_mod, newdata=data.frame(x=1:100), type="response")
lines(pred, col=pal_col[2])
pred=predict(q_mod, newdata=data.frame(x=1:100))
lines(pred, col=pal_col[3])
}


ratio_test=function(x, y)
{
plot(0, type="n", log="y",
	xlab="x", ylab="Ratio\n",
	xlim=range(x), ylim=c(1e-6, 100))
points(x, y/exp(x/5), col=pal_col[2])
points(x, y/x^2, col=pal_col[3])
points(x, y/x^3, col=pal_col[1])
}


# Generate data for a quadratic plus noise
x = rep(seq(10, 100, by=10), 25)

# Take abs just in case a large negative value is generated
y = abs(x^2 + 1e3*(5+rnorm(length(x))))

fit_and_plot(x, y)
fit_peaks(x, y)
ratio_test(x, y)


y = abs(x^2 + 1e2*(5+rnorm(length(x))))

fit_and_plot(x, y)
# fit_peaks(x, y)
ratio_test(x, y)


