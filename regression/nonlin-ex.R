#
# nonlin-ex.R, 20 Sep 16
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 4)

par(mar=c(3, 2.5, 1, 0.7)+0.1)

pal_col=rainbow(3)

init_plot=function(expr_str)
{
plot(-1, -1,
	xaxt="n", yaxt="n",
	xlim=range(x), ylim=c(0, 1),
	xlab="", ylab="")
text(8, 0.2, expr_str, pos=2, cex=1.4)
}


x=seq(0, 8, by=0.25)
init_plot("Michaelis-Menten")

mm=function(a, b, l_col)
{
y=a*x/(1+b*x)
lines(x, y, col=l_col)
}

mm(1, 1, pal_col[1])
mm(1, 1.5, pal_col[2])
mm(2, 2, pal_col[3])



x=seq(0, 8, by=0.25)
init_plot("Exponential")

ep=function(a, b, l_col)
{
y=a*(1-b*exp(-b*x))
lines(x, y, col=l_col)
}

ep(1, 1, pal_col[1])
ep(1, 1.5, pal_col[2])
ep(1, 0.5, pal_col[3])


x=seq(0, 8, by=0.25)
init_plot("Logistic")

lo=function(a, b, c=0, d=1, l_col)
{
y=a+(b-a)/(1+exp(c-x)/d)
lines(x, y, col=l_col)
}

lo(0, 1, 2, 1, pal_col[1])
lo(0, 1, 4, 2, pal_col[2])
lo(0, 1, 6, 3, pal_col[3])


x=seq(0, 8, by=0.25)
init_plot("Weibull")

we=function(a, b, c, d, l_col)
{
y=a-b*exp(-c*x^d)
lines(x, y, col=l_col)
}

we(1, 1, 0.001, 5, pal_col[1])
we(1, 1, 2, 0.75, pal_col[2])
we(1, 1, 0.1, 2, pal_col[3])


x=seq(0, 8, by=0.25)
init_plot("Gompertz")

gm=function(a, b, c, l_col)
{
y=a*exp(b*exp(-c*x))
lines(x, y, col=l_col)
}

gm(1, -2, 0.3, pal_col[1])
gm(1, -2, 2, pal_col[2])
gm(1, -2, 0.7, pal_col[3])



x=seq(0, 8, by=0.25)
x_bell=x-4
init_plot("Bell-shaped")

hm=function(a, b, l_col)
{
y=a*exp(-(abs(b*x_bell)^2))
lines(x, y, col=l_col)
}

hm(1, 0.2, pal_col[1])
hm(1, 0.5, pal_col[2])
hm(1, 1, pal_col[3])


x=seq(0, 8, by=0.1)
init_plot("Biexponential")

be=function(a, b, c, d, l_col)
{
y=a*exp(-b*x)-c*exp(-d*x)
lines(x, y, col=l_col)
}

be(1.6, 0.1, 1, 0.5, pal_col[1])
be(1.5, 0.4, 1, 1, pal_col[2])
be(1, 1, 1, 4, pal_col[3])



x=seq(0, 8, by=0.1)
init_plot("Ricker curve")

ry=function(a, b, l_col)
{
y=a*x*exp(-b*x)
lines(x, y, col=l_col)
}

ry(1, 0.4, pal_col[1])
ry(1, 1, pal_col[2])
ry(4, 2, pal_col[3])


