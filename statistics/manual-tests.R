#
# manual-tests.R,  5 Mar 20
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Example regression


source("ESEUR_config.r")


set.seed(40)

# y=2*x
x_actual=1:100
y=2*x_actual

# Add some randomness to x
D=data.frame(x=x_actual+rnorm(100, sd=10), y=2*x_actual)

plot(D)

# The regression way of doing things:
fit=glm(y ~ x, data=D)

# Pearson correlation.
# To mimic a correlation test we need to scale the standard deviation
# of the values to be one.
# Using lm so we get more correlation-like output by default
p_fit=lm(scale(y) ~ 1+scale(x), data=D)
summary(p_fit)

cor.test(D$x, D$y, method="pearson")

# Spearman correlation.
# The rank  function returns the rank ordering of values.
s_fit=lm(rank(y) ~ 1+rank(x), data=D)
summary(s_fit)

cor.test(D$x, D$y, method="spearman")


# t-test
t_test=lm(y ~ 1, data=D)
summary(t_test)
confint(t_test)

t.test(D$y)

# Wilcoxon signed-rank test
signed_rank = function(x) sign(x)*rank(abs(x))

wilcoxon=lm(signed_rank(y) ~ 1, data=D)
summary(wilcoxon)

wilcox.test(D$y)

