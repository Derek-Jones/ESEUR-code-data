#
# compare-fit.R, 15 Mar 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# Example taken from???

compare_fit = function()
{
# Calculate the residual sum-of-squares (lack of fit) and
# the total sum-of-squares (coefficient of determination), then
# compare to the lack-of-fit of the known quadratic.

resid_ss = sum(residuals(fitted_curve)^2)
total_ss = sum((y - mean(y))^2)

print("???")
print(paste("Fitted curve ", 1 - resid_ss/total_ss))
print(paste("Known curve ", 1 - sum((x^2 - y)^2)/total_ss))
}

# Generate data for a quadratic relationship containing random noise
num_items = 25
x = runif(num_items)
y = x^2 + rnorm(num_items, 0, 0.05)

# First a polynomial having a single term
fitted_curve = nls(y ~ I(x^power), start = list(power = 1))
summary(fitted_curve)

s = seq(0, 1, length = 100)

power = round(summary(fitted_curve)$coefficients[1], 3)
pow.std_err = round(summary(fitted_curve)$coefficients[2], 3)
plot(y ~ x, main = "Fitted quadratic model", sub = "Red: fitted. Green: known")
lines(s, s^2, lty = 2, col = "green")
lines(s, predict(fitted_curve, list(x = s)), lty = 1, col = "red")
text(0, 0.5, paste("y =x^ (", power, " +/- ", pow.std_err, ")", sep = ""), pos = 4)

compare_fit()

# Next a two term polynomial
fitted_curve = nls(y ~ I(a*x+x^power), start = list(a = 0.0, power = 1.5))
summary(fitted_curve)

a_coeff = round(summary(fitted_curve)$coefficients[1], 3)
power = round(summary(fitted_curve)$coefficients[2], 3)
plot(y ~ x, main = "Fitted quadratic model", sub = "Red: fitted. Green: known")
lines(s, s^2, lty = 2, col = "green")
lines(s, predict(fitted_curve, list(x = s)), lty = 1, col = "red")
text(0, 0.5, paste("y =", a_coeff, "x+x^", power, sep = ""), pos = 4)

compare_fit()

# and now an exponential model
fitted_curve = nls(y ~ I(exp(1)^(a + b * x)), start = list(a = 0, b = 1))

a = round(summary(fitted_curve)$coefficients[1, 1], 3)
b = round(summary(fitted_curve)$coefficients[2, 1], 3)
plot(y ~ x, main = "Fitted exponential model", sub = "Red: fitted. Green: known")
lines(s, s^2, lty = 2, col = "green")
lines(s, predict(fitted_curve, list(x = s)), lty = 1, col = "red")
text(0, 0.5, paste("y =e^ (", a, " + ", b, " * x)", sep = ""), pos = 4)

compare_fit()

