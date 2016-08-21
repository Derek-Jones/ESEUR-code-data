#
# asymm-circ-dist.R, 18 Aug 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("circular")

pal_col=rainbow(5)

plot_layout(3, 1)
par(mar=c(0.2, 1.0, 0.2, 0.8))
# par(oma=c(0.5, 1, 0.5, 1))


# Code derived from that appearing in Circular statistics in R
aeJPNCon = function(kappa, psi, nu)
{
eps = 10*.Machine$double.eps
if (abs(psi) <= eps)
   {
   intgrnd0 = function(x){ exp(kappa*cos(x+nu*cos(x))) }

   ncon = 1/(integrate(intgrnd0, lower=-pi, upper=pi)$value)
   }
else
   {
   intgrnd = function(x)
		{
   		(cosh(kappa*psi)+sinh(kappa*psi)*cos(x+nu*cos(x)))**(1/psi)
   		}

   ncon = 1/(integrate(intgrnd, lower=-pi, upper=pi)$value)
   }
return(ncon)
}


# Code derived from that appearing in Circular statistics in R
aeJPPDF = function(theta, xi, kappa, psi, nu, ncon)
{
eps = 10*.Machine$double.eps
if (abs(psi) <= eps)
   {
   pdfval = ncon*exp(kappa*cos(theta-xi+nu*cos(theta-xi)))
   }
else
   { 
   pdfval = (cosh(kappa*psi)+sinh(kappa*psi)*cos(theta-xi+nu*cos(theta-xi)))**(1/psi)
   pdfval = ncon*pdfval
   }
return(pdfval)

}


plot_asymm=function(xi, kappa, psi)
{
curve.circular(aeJPPDF(x, xi, kappa, psi, 0, ncon), n=360, join=TRUE, cex=0.7, shrink=2.1, col=pal_col[1])
y = aeJPPDF(theta, xi, kappa, psi, 0.25, ncon)
lines(theta, y, col=pal_col[2])
y = aeJPPDF(theta, xi, kappa, psi, 0.5, ncon)
lines(theta, y, col=pal_col[3])
y = aeJPPDF(theta, xi, kappa, psi, 0.75, ncon)
lines(theta, y, col=pal_col[4])
y = aeJPPDF(theta, xi, kappa, psi, 0.9999, ncon)
lines(theta, y, col=pal_col[5])
}

xi = pi/2
kappa = 2
nu = 0.5

psi = 1
ncon = aeJPNCon(kappa, psi, nu) 
plot_asymm(xi, kappa, psi)

psi = 0
ncon = aeJPNCon(kappa, psi, nu) 
plot_asymm(xi, kappa, psi)

psi = -1
ncon = aeJPNCon(kappa, psi, nu) 
plot_asymm(xi, kappa, psi)


