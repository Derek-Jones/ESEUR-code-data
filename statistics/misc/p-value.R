#
# p-value.R, 13 Mar 13
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# Generate 1000 data points
n = 1000
x = seq(1, 100, length=n)

# Add lots of noise to a linear relationship
y = 0.5*x + rnorm(n, 0, 75)

# Fit a linear model
yx_1000 = glm(y ~ x)
summary(yx_1000)


plot(x, y)
abline(yx_1000, col="red")

t=confint(yx_1000)
abline(t[,1], col="green")
abline(t[,2], col="green")

