#
# asymm-circ-dist.R, 14 Oct 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example circular


source("ESEUR_config.r")


library("circular")

pal_col=rainbow(5)

plot_layout(2, 2, max_height=12.0)
par(mar=c(0.5, 0.0, 0.5, 0.0))
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
# Changing ylim from c(-1, 1) brings the plots closer together
curve.circular(aeJPPDF(x, xi, kappa, psi, 0, ncon), n=360, join=TRUE,
			cex=1.6, tcl.text=0.4, shrink=2.1, col=pal_col[1], ylim=c(-0.4, 1.0))
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


