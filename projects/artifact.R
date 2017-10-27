
x=1:1e6
y=trunc(1e6/x^1.5)
# y=trunc(1e6*exp(-x*0.1))

log_y=log10(y)

hist(log_y, n=40, main="", xlim=c(0, 3))

plot(x, y, log="x", type="l")

