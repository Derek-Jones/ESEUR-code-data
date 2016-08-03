# ***************************************************************************************************

# Note that in the NEW functions introduced here the objects cdat, circdat and origdat are assumed to  
# be CIRCULAR data objects, whereas the objects lcdat and lcircdat are assumed to be LINEAR data 
# objects containing values in [0, 2pi). 

# ***************************************************************************************************


library(circular)

#====================================================================================================

# von Mises distribution 

#====================================================================================================

#====================================================================================================

# vM1. Testing for circular uniformity and reflective symmetry

#====================================================================================================

cdat <- circular(fisherB6$set1*2*pi/360) 
kuiper.test(cdat)
absz <- RSTestStat(cdat) 
pval = 2*pnorm(absz, mean=0, sd=1, lower=FALSE) ; pval

#====================================================================================================

# vM2. Maximum likelihood estimation: with bias-correction for kappa

#====================================================================================================

vMmle <- mle.vonmises(cdat, bias=TRUE)
muhat <- vMmle$mu ; semu <- vMmle$se.mu ; muhat ; semu
kaphat <- vMmle$kappa ; sekap <- vMmle$se.kappa ; kaphat ; sekap

plot(cdat, ylim=c(-1.2,1), pch=16, stack=TRUE, bins=720)
theta <- circular(seq(0, 2*pi, by=pi/3600))
y <- dvonmises(theta, muhat, kaphat) ; lines(theta, y, lwd=2)
lines(density.circular(cdat, bw=5), lwd=2, lty=2)

#====================================================================================================

# vM3. Confidence interval construction

#====================================================================================================

# Asymptotic normal theory

quant <- qnorm(0.975)
muint=c(muhat-quant*semu, muhat+quant*semu)
kapint=c(kaphat-quant*sekap, kaphat+quant*sekap)
muint ; kapint

# Bootstrap

mle.vonmises.bootstrap.ci(cdat, bias=TRUE, reps=10000)

#====================================================================================================

# vM4.1 Combined P-P and Q-Q plots for an assumed von Mises distribution

#====================================================================================================

vMPPQQ <- function(circdat, mu, kappa) {
edf <- ecdf(circdat)
tdf <- pvonmises(circdat, mu, kappa, from=circular(0), tol = 1e-06)
tqf <- qvonmises(edf(circdat), mu, kappa, from=circular(0), tol = 1e-06)
par(mfrow=c(1,2), mai=c(0.90, 1.1, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tdf, edf(circdat), pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "von Mises distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
plot.default(tqf, circdat, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "von Mises quantile function", ylab = "Empirical quantile function") 
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

x <- fisherB6$set1 ; cdat <- circular(x*2*pi/360)
vMmle <- mle.vonmises(cdat, bias=TRUE) ; muhat <-vMmle$mu ; kaphat <- vMmle$kappa
vMPPQQ(cdat, muhat, kaphat)

#====================================================================================================

# vM4.2 Just P-P for an assumed von Mises plot

#====================================================================================================

vMPP <- function(circdat, mu, kappa) {
edf <- ecdf(circdat)
tdf <- pvonmises(circdat, mu, kappa, from=circular(0), tol = 1e-06)
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tdf, edf(circdat), pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "von Mises distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
}

x <- fisherB6$set1 ; cdat <- circular(x*2*pi/360)
vMmle <- mle.vonmises(cdat, bias=TRUE) ; muhat <-vMmle$mu ; kaphat <- vMmle$kappa
vMPP(cdat, muhat, kaphat)

#====================================================================================================

# vM4.3 Just Q-Q for an assumed von Mises plot

#====================================================================================================

vMQQ <- function(circdat, mu, kappa) {
edf <- ecdf(circdat)
tqf <- qvonmises(edf(circdat), mu, kappa, from=circular(0), tol = 1e-06)
plot.default(tqf, circdat, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "von Mises quantile function", ylab = "Empirical quantile function") 
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

x <- fisherB6$set1 ; cdat <- circular(x*2*pi/360)
vMmle <- mle.vonmises(cdat, bias=TRUE) ; muhat <-vMmle$mu ; kaphat <- vMmle$kappa
vMQQ(cdat, muhat, kaphat)

#====================================================================================================

# vM5.1 G-o-f Watson test for von Mises distribution: not corrected for fact that parameters have been estimated. Parameters estimated using (uncorrected) MLE. 

#====================================================================================================

x <- fisherB6$set1 ; cdat <- circular(x*2*pi/360)

watson.test(cdat, dist="vonmises")

#====================================================================================================

# vM5.2 G-o-f based on four tests of circular uniformity: no bootstrapping

#====================================================================================================

vMGoF <- function(circdat, mu, kappa) {
tdf <- pvonmises(circdat, circular(mu), kappa, from=circular(0), tol = 1e-06)
cunif <- circular(2*pi*tdf)
kuires <- kuiper.test(cunif) ; rayres <- rayleigh.test(cunif) 
raores <- rao.spacing.test(cunif) ; watres <- watson.test(cunif)
return(list(kuires, rayres, raores, watres))
}

muhat <- 3.98 ; kaphat <- 0.8287 
vMGoFRes <- vMGoF(cdat, muhat, kaphat) ; vMGoFRes

#====================================================================================================

# vM5.3 G-o-f based on four tests of circular uniformity: with parametric bootstrapping

#====================================================================================================

vMGoFBoot <- function(origdat, B) {
n <- length(origdat)
vMmle <- mle.vonmises(origdat, bias=TRUE) ; muhat0 <- vMmle$mu ; kaphat0 <- vMmle$kappa
tdf <- pvonmises(origdat, muhat0, kaphat0, from=circular(0), tol = 1e-06)
cunif <- circular(2*pi*tdf)
unitest0 <- 0 ; nxtrm <- 0 ; pval <- 0
for (k in 1:4) {unitest0[k]=0 ; nxtrm[k]=1}
unitest0[1] <- kuiper.test(cunif)$statistic
unitest0[2] <- rayleigh.test(cunif)$statistic
unitest0[3] <- rao.spacing.test(cunif)$statistic
unitest0[4] <- watson.test(cunif)$statistic

for (b in 2:(B+1)) {
bootsamp <- rvonmises(n, muhat0, kaphat0)
vMmle <- mle.vonmises(bootsamp, bias=TRUE) ; muhat1 <- vMmle$mu ; kaphat1 <- vMmle$kappa
tdf <- pvonmises(bootsamp, muhat1, kaphat1, from=circular(0), tol = 1e-06)
cunif <- circular(2*pi*tdf)
kuiper1 <- kuiper.test(cunif)$statistic 
if (kuiper1 >= unitest0[1]) {nxtrm[1] <- nxtrm[1] + 1}
rayleigh1 <- rayleigh.test(cunif)$statistic 
if (rayleigh1 >= unitest0[2]) {nxtrm[2] <- nxtrm[2] + 1}
rao1 <- rao.spacing.test(cunif)$statistic 
if (rao1 >= unitest0[3]) {nxtrm[3] <- nxtrm[3] + 1}
watson1 <- watson.test(cunif)$statistic 
if (watson1 >= unitest0[4]) {nxtrm[4] <- nxtrm[4] + 1}
}
for (k in 1:4) {pval[k] <- nxtrm[k]/(B+1)}
return(pval)
}

x <- fisherB6$set1 ;cdat <- circular(x*2*pi/360)
B <- 9999 ; pval <- vMGoFBoot(cdat, B) ; pval

#====================================================================================================

### Fitting a Jones-Pewsey distribution 

#====================================================================================================

# *************************** Functions defined in Chapter 4 that are used subsequently 

JPNCon <- function(kappa, psi){
if (kappa < 0.001) {ncon <- 1/(2*pi) ; return(ncon)} 
else {
eps <- 10*.Machine$double.eps
if (abs(psi) <= eps) {ncon <- 1/(2*pi*I.0(kappa)) ; return(ncon)}

 
else {
intgrnd <- function(x){ (cosh(kappa*psi)+sinh(kappa*psi)*cos(x))**(1/psi) }

ncon <- 1/integrate(intgrnd, lower=-pi, upper=pi)$value
return(ncon) } }
}



JPPDF <- function(theta, mu, kappa, psi, ncon){
if (kappa < 0.001) {pdfval <- 1/(2*pi) ; return(pdfval)}
else {
eps <- 10*.Machine$double.eps
if (abs(psi) <= eps) {
pdfval <- ncon*exp(kappa*cos(theta-mu)) ; return(pdfval) }

 
else { 
pdfval <- (cosh(kappa*psi)+sinh(kappa*psi)*cos(theta-mu))**(1/psi)
pdfval <- ncon*pdfval ; return(pdfval) } }

}



JPDF <- function(theta, mu, kappa, psi, ncon) {
eps <- 10*.Machine$double.eps
if (theta <= eps) {dfval <- 0 ; return(dfval)}

 else 
if (theta >= 2*pi-eps) {dfval <- 1 ; return(dfval)} else
if (kappa < 0.001) {dfval <- theta/(2*pi) ; return(dfval)}
else {
if (abs(psi) <= eps) {
vMPDF <- function(x){ ncon*exp(kappa*cos(x-mu)) }
dfval <- integrate(vMPDF, lower=0, upper=theta)$value
return(dfval) }


else { 
dfval <- integrate(JPPDF, mu=mu, kappa=kappa, psi=psi, ncon=ncon, lower=0, upper=theta)$value
return(dfval) }
}
}


JPQF <- function(u, mu, kappa, psi, ncon) {

eps <- 10*.Machine$double.eps
if (u <= eps) {theta <- 0 ; return(theta)}

 else 
if (u >= 1-eps) {theta <- 2*pi-eps ; return(theta)} else
if (kappa < 0.001) {theta <- u*2*pi ; return(theta)}
else {
roottol <- .Machine$double.eps**(0.6)
qzero <- function(x) {
y <- JPDF(x, mu, kappa, psi, ncon) - u ; return(y) }
res <- uniroot(qzero, lower=0, upper=2*pi-eps, tol=roottol)
theta <- res$root ; return(theta) }
}

JPSim <- function(n, mu, kappa, psi, ncon) {

fmax <- JPPDF(mu, mu, kappa, psi, ncon) ; theta <- 0
for (j in 1:n) {
stopgo <- 0
while (stopgo == 0) {
u1 <- runif(1, 0, 2*pi)
pdfu1 <- JPPDF(u1, mu, kappa, psi, ncon)
u2 <- runif(1, 0, fmax)
if (u2 <= pdfu1) { theta[j] <- u1 ; stopgo <- 1 }
} }
return(theta)
}

# ***************************************************

#====================================================================================================

# JP1. Maximum likelihood estimation 

#====================================================================================================

JPmle <- function(lcircdat) {
n <- length(lcircdat)
s <- sum(sin(lcircdat)) ; c <- sum(cos(lcircdat)) ; muvM <- atan2(s,c)
if (muvM < 0) {muvM <- muvM + 2*pi}
kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPnll <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- p[3] ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(lcircdat, mu, kappa, psi, ncon))) ; return (y) }
}

out <- optim(par=c(muvM, kapvM, 0.001), fn=JPnll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0, -Inf), upper = c(muvM+pi, Inf, Inf), hessian = TRUE)
muhat <- out$par[1] ; kaphat <- out$par[2] ; psihat <- out$par[3]  
if (muhat < 0) {muhat <- muhat + 2*pi} else
if (muhat >= 2*pi) {muhat <- muhat - 2*pi}
maxll <- -out$value ; HessMat <- out$hessian
return(list(maxll, muhat, kaphat, psihat, HessMat))
}

lcdat <- fisherB6$set1*2*pi/360
JPmleRes <- JPmle(lcdat) ; JPmleRes

cdat <- circular(lcdat)
plot(cdat, xlim=c(-1.3,1.3), pch=16, stack=TRUE, bins=3600, cex=0.9)
theta <- circular(seq(0, 2*pi, by=pi/3600))
muhat <- JPmleRes[[2]] ; kaphat <- JPmleRes[[3]] ; psihat <- JPmleRes[[4]]
cmuhat <- circular(muhat) ; ncon <- JPNCon(kaphat, psihat)
y <- JPPDF(theta, cmuhat, kaphat, psihat, ncon) ; lines(theta, y, lty=1, lwd=2)
lines(density.circular(cdat, bw=5), lwd=2, lty=2)
arrows.circular(mean(cdat), y=rho.circular(cdat), lwd=2)

#====================================================================================================

# JP2. Confidence interval construction 

#====================================================================================================

# JP2.1. Asymptotic normal theory

#====================================================================================================

JPNTCI <- function(muest, kapest, psiest, HessMat, conflevel) {
alpha <- (100-conflevel)/100 ; quant <- qnorm(1-alpha/2)
infmat <- solve(HessMat) ; standerr <- sqrt(diag(infmat))
muint <- c(muest-quant*standerr[1], muest+quant*standerr[1]) 
kapint <- c(kapest-quant*standerr[2], kapest+quant*standerr[2])
psiint <- c(psiest-quant*standerr[3], psiest+quant*standerr[3])
return(list(muint, kapint, psiint))
}

muhat <- JPmleRes[[2]] ; kaphat <- JPmleRes[[3]] ; psihat <- JPmleRes[[4]] 
HessMat <- JPmleRes[[5]] ; conflevel <- 95
jpntci <- JPNTCI(muhat, kaphat, psihat, HessMat, conflevel) ; jpntci

#====================================================================================================

# JP2.2.1 Profile log-likelihood (and aymptotic chi-squared theory) for psi

#====================================================================================================

JPpllpsi <- function(lcircdat, muhat, kaphat, psival) {
npsival <- length(psival) ; pllpsi <- 0
for (j in 1:npsival) {
psi0 <- psival[j]

JPnllpsi0 <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(lcircdat, mu, kappa, psi, ncon))) ; return(y) }
}
out <- optim(par=c(muhat, kaphat), fn=JPnllpsi0, gr = NULL, method = "L-BFGS-B", lower = c(muhat-pi, 0), upper = c(muhat+pi, Inf))
pllpsi[j] <- -out$value
}
return(pllpsi) 
}

JPpllpsiPlotCI <- function(maxll, psival, pllpsi, conflevel) {
npsival <- length(psival) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(psival, pllpsi, type="l", lwd=2, xlab=expression(psi), ylab=expression(pll(psi)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(psival[1], psival[npsival]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
npsivalm1 <- npsival-1
for (j in 1:npsivalm1) {
if (pllpsi[j] < cutpoint) {
jp1 <- j+1
if (pllpsi[jp1] > cutpoint) {
grad <- (pllpsi[jp1]-pllpsi[j])/(psival[jp1]-psival[j])
con <- pllpsi[j]-grad*psival[j] ; psilo <- (cutpoint - con)/grad }
}
if (pllpsi[j] > cutpoint) {
jp1 <- j+1
if (pllpsi[jp1] < cutpoint) {
grad <- (pllpsi[j]-pllpsi[jp1])/(psival[j]-psival[jp1])
con <- pllpsi[j]-grad*psival[j] ; psiup <- (cutpoint - con)/grad }
}
}
return(list(psilo, psiup))
}

psival <- seq(-0.05, 3.3, by=0.05)
pllpsi <- JPpllpsi(lcdat, muhat, kaphat, psival)
maxll <- JPmleRes[[1]] ; conflevel <- 95
pllpsiCI <- JPpllpsiPlotCI(maxll, psival, pllpsi, conflevel) ; pllpsiCI
 
#====================================================================================================

# JP2.2.2 Profile log-likelihood (and aymptotic chi-squared theory) for mu

#====================================================================================================

JPpllmu <- function(lcircdat, kaphat, psihat, muval) {
nmuval <- length(muval) ; pllmu <- 0
for (j in 1:nmuval) {
mu0 <- muval[j]

JPnllmu0 <- function(p){
kappa <- p[1] ; psi <- p[2] ; mu <- mu0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(lcircdat, mu, kappa, psi, ncon))) ; return(y) }
}

out <- optim(par=c(kaphat, psihat), fn=JPnllmu0, gr = NULL, method = "L-BFGS-B", lower = c(0, -Inf), upper = c(Inf, Inf))
pllmu[j] <- -out$value
}
return(pllmu) 
}

JPpllmuPlotCI <- function(maxll, muval, pllmu, conflevel) {
nmuval <- length(muval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(muval, pllmu, type="l", lwd=2, xlab=expression(mu), ylab=expression(pll(mu)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(muval[1], muval[nmuval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
nmuvalm1 <- nmuval-1
for (j in 1:nmuvalm1) {
if (pllmu[j] < cutpoint) {
jp1 <- j+1
if (pllmu[jp1] > cutpoint) {
grad <- (pllmu[jp1]-pllmu[j])/(muval[jp1]-muval[j])
con <- pllmu[j]-grad*muval[j] ; mulo <- (cutpoint - con)/grad }
}
if (pllmu[j] > cutpoint) {
jp1 <- j+1
if (pllmu[jp1] < cutpoint) {
grad <- (pllmu[j]-pllmu[jp1])/(muval[j]-muval[jp1])
con <- pllmu[j]-grad*muval[j] ; muup <- (cutpoint - con)/grad }
}
}
if (mulo < 0) {mulo <- mulo+2*pi}
if (muup < 0) {muup <- muup+2*pi}

return(list(mulo, muup))
}

muval <- seq(-2.9, -1.775, by=0.025)
pllmu <- JPpllmu(lcdat, kaphat, psihat, muval)
maxll <- JPmleRes[[1]] ; conflevel <- 95
pllmuCI <- JPpllmuPlotCI(maxll, muval, pllmu, conflevel) ; pllmuCI

#====================================================================================================

# JP2.2.3 Profile log-likelihood (and aymptotic chi-squared theory) for kappa

#====================================================================================================

JPpllkap <- function(lcircdat, muhat, psihat, kapval) {
nkapval <- length(kapval) ; pllkap <- 0
for (j in 1:nkapval) {
kap0 <- kapval[j]

JPnllkap0 <- function(p){
mu <- p[1] ; psi <- p[2] ; kappa <- kap0 ; parlim <- abs(kappa*psi)
if (parlim > 20) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(lcircdat, mu, kappa, psi, ncon))) ; return(y) }
}
out <- optim(par=c(muhat, psihat), fn=JPnllkap0, gr = NULL, method = "L-BFGS-B", lower = c(muhat-pi, -Inf), upper = c(muhat+pi, Inf))
pllkap[j] <- -out$value
}
return(pllkap) 
}

JPpllkapPlotCI <- function(maxll, kapval, pllkap, conflevel) {
nkapval <- length(kapval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(kapval, pllkap, type="l", lwd=2, xlab=expression(kappa), ylab=expression(pll(kappa)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(kapval[1], kapval[nkapval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
kapup <- Inf
nkapvalm1 <- nkapval-1
for (j in 1:nkapvalm1) {
if (pllkap[j] < cutpoint) {
jp1 <- j+1
if (pllkap[jp1] > cutpoint) {
grad <- (pllkap[jp1]-pllkap[j])/(kapval[jp1]-kapval[j])
con <- pllkap[j]-grad*kapval[j] ; kaplo <- (cutpoint - con)/grad }
}
if (pllkap[j] > cutpoint) {
jp1 <- j+1
if (pllkap[jp1] < cutpoint) {
grad <- (pllkap[j]-pllkap[jp1])/(kapval[j]-kapval[jp1])
con <- pllkap[j]-grad*kapval[j] ; kapup <- (cutpoint - con)/grad }
}
}

return(list(kaplo, kapup))
}

kapval <- seq(0.2, 12, by=0.2)
pllkap <- JPpllkap(lcdat, muhat, psihat, kapval)
maxll <- JPmleRes[[1]] ; conflevel <- 95
pllkapCI <- JPpllkapPlotCI(maxll, kapval, pllkap, conflevel) ; pllkapCI

#====================================================================================================

# JP3. Bootstrap confidence intervals

#====================================================================================================

#====================================================================================================

# JP3.1 Parametric bootstrap: sampling from fitted JP distribution

#====================================================================================================

JPCIBoot <- function(lcircdat, conflevel, B) {
n <- length(lcircdat) ; alpha <- (100-conflevel)/100
JPmleRes <- JPmle(lcircdat) ; muest <- JPmleRes[[2]]
kapest <- JPmleRes[[3]] ; psiest <- JPmleRes[[4]]
ncon <- JPNCon(kapest[1], psiest[1])
for (b in 2:(B+1)) {
jpdat <- JPSim(n, muest[1], kapest[1], psiest[1], ncon)
JPmleRes <- JPmle(jpdat) ; muest[b] <- JPmleRes[[2]]
kapest[b] <- JPmleRes[[3]] ; psiest[b] <- JPmleRes[[4]]
}
dist <- pi-abs(pi-abs(muest-muest[1]))
sdist <- sort(dist)
mulo <- muest[1]-sdist[(B+1)*(1-alpha)] ; muup <- muest[1]+sdist[(B+1)*(1-alpha)]
skapest <- sort(kapest) 
kaplo <- skapest[(B+1)*alpha/2] ; kapup <- skapest[(B+1)*(1-alpha/2)]
spsiest <- sort(psiest)
psilo <- spsiest[(B+1)*alpha/2] ; psiup <- spsiest[(B+1)*(1-alpha/2)]
return(list(mulo, muup, kaplo, kapup, psilo, psiup))
}


conflevel <- 95 ; B <- 9999
JPCIBootRes <- JPCIBoot(lcdat, conflevel, B) ; JPCIBootRes


#====================================================================================================


# JP4 Model comparison 

#====================================================================================================

#====================================================================================================

# JP4.1.1 LRT for a submodel with a specified value, psi0, of psi  (asymptotic chi-squared version)

#====================================================================================================

JPpsi0LRT <- function(lcircdat, psi0) {
x <- lcircdat ; n <- length(x)
s <- sum(sin(x)) ; c <- sum(cos(x)) ; muvM <- atan2(s,c)
if (muvM < 0) {muvM <- muvM + 2*pi}
kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPnll <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- p[3] ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(x, mu, kappa, psi, ncon))) ; return (y) }
}

JPnllpsi0 <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(x, mu, kappa, psi, ncon))) ; return(y) }
}

out <- optim(par=c(muvM, kapvM, 0), fn=JPnll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0, -Inf), upper = c(muvM+pi, Inf, Inf))
maxll1 <- -out$value ; muhat1 <- out$par[1] ; kaphat1 <- out$par[2] ; psihat1 <- out$par[3]

out <- optim(par=c(muhat1, kaphat1), fn=JPnllpsi0, gr = NULL, method = "L-BFGS-B", lower = c(muhat1-pi, 0), upper = c(muhat1+pi, Inf))
maxll0 <- -out$value ; muhat0 <- out$par[1] ; kaphat0 <- out$par[2]

D <- -2*(maxll0-maxll1) ; pval <- pchisq(D, df= 1, lower.tail=F) 
return(list(maxll0, maxll1, D, pval, muhat1, muhat0, kaphat1, kaphat0, psihat1, psi0))
}

lcdat <- fisherB6$set1*2*pi/360 ; psi0 <- 1 
lrtres <- JPpsi0LRT(lcdat, psi0) ; lrtres

psi0 <- 0 ; lrtres <- JPpsi0LRT(lcdat, psi0) ; lrtres

#====================================================================================================

# JP4.1.2 LRT for a submodel with a specified value, psi0, of psi (parametric bootstrap version)

#====================================================================================================

JPpsi0LRTBoot <- function(lcircdat, psi0, B) {
x <- lcircdat ; n <- length(x)
s <- sum(sin(x)) ; c <- sum(cos(x)) ; muvM <- atan2(s,c)
if (muvM < 0) {muvM <- muvM + 2*pi}
kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPnll <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- p[3] ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(x, mu, kappa, psi, ncon))) ; return (y) }
}

JPnllpsi0 <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(x, mu, kappa, psi, ncon))) ; return(y) }
}

out <- optim(par=c(muvM, kapvM, 0), fn=JPnll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0, -Inf), upper = c(muvM+pi, Inf, Inf))
maxll1 <- -out$value ; muhat1 <- out$par[1] ; kaphat1 <- out$par[2]

out <- optim(par=c(muhat1, kaphat1), fn=JPnllpsi0, gr = NULL, method = "L-BFGS-B", lower = c(muhat1-pi, 0), upper = c(muhat1+pi, Inf))
maxll0 <- -out$value ; muhat0 <- out$par[1] ; kaphat0 <- out$par[2]

D <- -2*(maxll0-maxll1) ; nxtrm <- 1

ncon <- JPNCon(kaphat0, psi0)
for (j in 2:(B+1)) {
stopgo <- 0
while (stopgo == 0) {

x <- JPSim(n, muhat0, kaphat0, psi0, ncon)

out <- optim(par=c(muhat0, kaphat0, psi0), fn=JPnll, gr = NULL, method = "L-BFGS-B", lower = c(muhat0-pi, 0, -Inf), upper = c(muhat0+pi, Inf, Inf))
maxll1 <- -out$value 

out <- optim(par=c(muhat0, kaphat0), fn=JPnllpsi0, gr = NULL, method = "L-BFGS-B", lower = c(muhat0-pi, 0), upper = c(muhat0+pi, Inf))
maxll0 <- -out$value

D[j] <- -2*(maxll0-maxll1) 

if (D[j] >= 0) {
if (D[j] < 40) { 
if (D[j] >= D[1]) {nxtrm <- nxtrm+1}
stopgo <- 1 } }
} 
}
pval <- nxtrm/(B+1) 
return(list(pval, D))
} 

lcdat <- fisherB6$set1*2*pi/360 ; psi0 <- 1 ; B=9999
bootlrtres <- JPpsi0LRTBoot(lcdat, psi0, B) ; bootlrtres[[1]]
Dvals <- bootlrtres[[2]]
hist(Dvals, freq=FALSE, breaks=40, main=" ", xlab="D value", ylab="Density")

lcdat <- fisherB6$set1*2*pi/360 ; psi0 <- 0 ; B=9999
bootlrtres <- JPpsi0LRTBoot(lcdat, psi0, B) ; bootlrtres[[1]]
Dvals <- bootlrtres[[2]]
hist(Dvals, freq=FALSE, breaks=40, main=" ", xlab="D value", ylab="Density")


#====================================================================================================

# JP4.2 AIC and BIC for full Jones-Pewsey model and one of its submodels with a specified value, psi0, of psi

#====================================================================================================

JPpsi0AICBIC <- function(lcircdat, psi0) {
x <- lcircdat ; n <- length(x)
s <- sum(sin(x)) ; c <- sum(cos(x)) ; muvM <- atan2(s,c)
if (muvM < 0) {muvM <- muvM + 2*pi}
kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPnll <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- p[3] ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(x, mu, kappa, psi, ncon))) ; return (y) }
}

JPnllpsi0 <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(x, mu, kappa, psi, ncon))) ; return(y) }
}

out <- optim(par=c(muvM, kapvM, 0), fn=JPnll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0, -Inf), upper = c(muvM+pi, Inf, Inf))
maxll1 <- -out$value ; muhat1 <- out$par[1] ; kaphat1 <- out$par[2] 
nu <- 3
AIC1 <- (2*nu)-(2*maxll1) ; BIC1 <- (log(n)*nu)-(2*maxll1) 

out <- optim(par=c(muhat1, kaphat1), fn=JPnllpsi0, gr = NULL, method = "L-BFGS-B", lower = c(muhat1-pi, 0), upper = c(muhat1+pi, Inf))
maxll0 <- -out$value 
nu <- 2
AIC0 <- (2*nu)-(2*maxll0) ; BIC0 <- (log(n)*nu)-(2*maxll0) 

return(list(AIC0, AIC1, BIC0, BIC1))
}

lcdat <- fisherB6$set1*2*pi/360 ; psi0 <- -1 
lrtres <- JPpsi0AICBIC(lcdat, psi0) ; lrtres

lcdat <- fisherB6$set1*2*pi/360 ; psi0 <- 0 
lrtres <- JPpsi0AICBIC(lcdat, psi0) ; lrtres

lcdat <- fisherB6$set1*2*pi/360 ; psi0 <- 1 
lrtres <- JPpsi0AICBIC(lcdat, psi0) ; lrtres

#====================================================================================================

# JP5. Fitting a Jones-Pewsey submodel with a specified value, psi0, of the shape parameter psi

#====================================================================================================

#=======================================================================

# JP5.1 Maximum likelihood estimation (and plot of fitted density)

#=======================================================================

JPmlepsi0 <- function(lcircdat, psi0) {
x <- lcircdat ; n <- length(x)
s <- sum(sin(x)) ; c <- sum(cos(x)) ; muvM <- atan2(s,c)
if (muvM < 0) {muvM <- muvM + 2*pi}
kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPnllpsi0 <- function(p){
mu <- p[1] ; kappa <- p[2] ; psi <- psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(x, mu, kappa, psi, ncon))) ; return(y) }
}

out <- optim(par=c(muvM, kapvM), fn=JPnllpsi0, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0), upper = c(muvM+pi, Inf), hessian = TRUE)
muhat <- out$par[1] ; kaphat <- out$par[2]   
if (muhat < 0) {muhat <- muhat + 2*pi} else
if (muhat >= 2*pi) {muhat <- muhat - 2*pi}
maxll <- -out$value ; HessMat <- out$hessian
return(list(maxll, muhat, kaphat, HessMat))
}

lcdat <- fisherB6$set1*2*pi/360 ; psi0 <- 1
JPmlepsi0Res <- JPmlepsi0(lcdat, psi0) ; JPmlepsi0Res

cdat <- circular(lcdat)
plot(cdat, xlim=c(-1.3,1.3), pch=16, stack=TRUE, bins=3600, cex=0.9)
theta <- circular(seq(0, 2*pi, by=pi/3600))
muhat <- JPmlepsi0Res[[2]] ; kaphat <- JPmlepsi0Res[[3]] 
cmuhat <- circular(muhat) ; ncon <- JPNCon(kaphat, psihat)
y <- JPPDF(theta, cmuhat, kaphat, psihat, ncon) ; lines(theta, y, lty=1, lwd=2)
lines(density.circular(cdat, bw=5), lwd=2, lty=2)
arrows.circular(mean(cdat), y=rho.circular(cdat), lwd=2)

#=======================================================================

## JP5.2 Confidence interval construction 

#=======================================================================

#===========================================================

#  JP5.2.1 Asymptotic normal theory

#===========================================================

JPpsi0NTCI <- function(muest, kapest, HessMat, conflevel) {
alpha <- (100-conflevel)/100 ; quant <- qnorm(1-alpha/2)
infmat <- solve(HessMat) ; standerr <- sqrt(diag(infmat))
muint <- c(muhat-quant*standerr[1], muhat+quant*standerr[1]) 
kapint <- c(kaphat-quant*standerr[2], kaphat+quant*standerr[2])
return(list(muint, kapint))
}

muhat <- JPmlepsi0Res[[2]] ; kaphat <- JPmlepsi0Res[[3]] ; HessMat <- JPmlepsi0Res[[4]] ; conflevel <- 95
jppsi0ntci <- JPpsi0NTCI(muhat, kaphat, HessMat, conflevel) ; jppsi0ntci


#============================================================

# JP5.2.2.1 Profile log-likelihood (and aymptotic chi-squared theory) for mu

#============================================================

JPpllpsi0mu <- function(lcircdat, kaphat, psi0, muval) {
nmuval <- length(muval) ; pllpsi0mu <- 0
for (j in 1:nmuval) {
mu0 <- muval[j]

JPnllpsi0mu0 <- function(p){
mu <- mu0 ; kappa <- p[1] ; psi <- psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(lcircdat, mu, kappa, psi, ncon))) ; return(y) }
}

out <- optim(par=c(kaphat), fn=JPnllpsi0mu0, gr = NULL, method = "L-BFGS-B", lower = c(0), upper = c(Inf))
pllpsi0mu[j] <- -out$value
}
return(pllpsi0mu) 
}

JPpllmuPlotCI <- function(maxll, muval, pllmu, conflevel) {
nmuval <- length(muval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(muval, pllmu, type="l", lwd=2, xlab=expression(mu), ylab=expression(pll(mu)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(muval[1], muval[nmuval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
nmuvalm1 <- nmuval-1
for (j in 1:nmuvalm1) {
if (pllmu[j] < cutpoint) {
jp1 <- j+1
if (pllmu[jp1] > cutpoint) {
grad <- (pllmu[jp1]-pllmu[j])/(muval[jp1]-muval[j])
con <- pllmu[j]-grad*muval[j] ; mulo <- (cutpoint - con)/grad }
}
if (pllmu[j] > cutpoint) {
jp1 <- j+1
if (pllmu[jp1] < cutpoint) {
grad <- (pllmu[j]-pllmu[jp1])/(muval[j]-muval[jp1])
con <- pllmu[j]-grad*muval[j] ; muup <- (cutpoint - con)/grad }
}
}
if (mulo < 0) {mulo <- mulo+2*pi}
if (muup < 0) {muup <- muup+2*pi}

return(list(mulo, muup))
}

psi0 = 1 ; kaphat <- 1.43 ; muval <- seq(-2.9, -1.775, by=0.025)
pllpsi0mu <- JPpllpsi0mu(lcdat, kaphat, psi0, muval)
maxll <- JPmlepsi0Res[[1]] ; conflevel <- 95
pllpsi0muCI <- JPpllmuPlotCI(maxll, muval, pllpsi0mu, conflevel) ; pllpsi0muCI


#====================================================================================================

# JP5.2.2.2 Profile log-likelihood (and aymptotic chi-squared theory) for kappa

#====================================================================================================

JPpllpsi0kap <- function(lcircdat, muhat, psi0, kapval) {
nkapval <- length(kapval) ; pllpsi0kap <- 0
for (j in 1:nkapval) {
kap0 <- kapval[j]

JPnllpsi0kap0 <- function(p){
mu <- p[1] ; psi <- psi0 ; kappa <- kap0 ; parlim <- abs(kappa*psi)
if (parlim > 20) {y <- 9999.0 ; return(y)} 
else {
ncon <- JPNCon(kappa, psi)
y <- -sum(log(JPPDF(lcircdat, mu, kappa, psi, ncon))) ; return(y) }
}
out <- optim(par=c(muhat), fn=JPnllpsi0kap0, gr = NULL, method = "L-BFGS-B", lower = c(muhat-pi), upper = c(muhat+pi))
pllpsi0kap[j] <- -out$value
}
return(pllpsi0kap) 
}

JPpllkapPlotCI <- function(maxll, kapval, pllkap, conflevel) {
nkapval <- length(kapval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(kapval, pllkap, type="l", lwd=2, xlab=expression(kappa), ylab=expression(pll(kappa)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(kapval[1], kapval[nkapval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
kapup <- Inf
nkapvalm1 <- nkapval-1
for (j in 1:nkapvalm1) {
if (pllkap[j] < cutpoint) {
jp1 <- j+1
if (pllkap[jp1] > cutpoint) {
grad <- (pllkap[jp1]-pllkap[j])/(kapval[jp1]-kapval[j])
con <- pllkap[j]-grad*kapval[j] ; kaplo <- (cutpoint - con)/grad }
}
if (pllkap[j] > cutpoint) {
jp1 <- j+1
if (pllkap[jp1] < cutpoint) {
grad <- (pllkap[j]-pllkap[jp1])/(kapval[j]-kapval[jp1])
con <- pllkap[j]-grad*kapval[j] ; kapup <- (cutpoint - con)/grad }
}
}

return(list(kaplo, kapup))
}

psi0 = 1 ; muhat <- 3.96 ; kapval <- seq(0.2, 12, by=0.2)
pllpsi0kap <- JPpllpsi0kap(lcdat, muhat, psi0, kapval)
maxll <- JPmleRes[[1]] ; conflevel <- 95
pllpsi0kapCI <- JPpllkapPlotCI(maxll, kapval, pllpsi0kap, conflevel) ; pllpsi0kapCI


#=======================================================================

# JP5.3. Parametric bootstrap: with sampling from a fitted JP distribution with a specified value, psi0, of psi.

#=======================================================================

JPpsi0CIBoot <- function(lcircdat, muest, kapest, psi0, conflevel, B) {
n <- length(lcircdat) ; alpha <- (100-conflevel)/100
ncon <- JPNCon(kapest[1], psi0)
for (j in 2:(B+1)) {
jpdat <- JPSim(n, muest[1], kapest[1], psi0, ncon)
JPmlepsi0Res <- JPmlepsi0(jpdat, psi0) 
muest[j] <- JPmlepsi0Res[[2]] ; kapest[j] <- JPmlepsi0Res[[3]]
}
dist <- pi-abs(pi-abs(muest-muest[1]))
sdist <- sort(dist)
mulo <- muest[1]-sdist[(B+1)*(1-alpha)] ; muup <- muest[1]+sdist[(B+1)*(1-alpha)]
skapest <- sort(kapest) 
kaplo <- skapest[(B+1)*alpha/2] ; kapup <- skapest[(B+1)*(1-alpha/2)]
return(list(mulo, muup, kaplo, kapup))
}

conflevel <- 95 ; B <- 9999
psi0 <- 1 ; muhat <- JPmlepsi0Res[[2]] ; kaphat <- JPmlepsi0Res[[3]]
JPpsi0CIBootRes <- JPpsi0CIBoot(lcdat, muhat, kaphat, psi0, conflevel, B) ; JPpsi0CIBootRes

#====================================================================================================

# JP6. Goodness-of-fit for a Jones-Pewsey distrbution

#====================================================================================================

#===================================================

# JP6.1 P-P and Q-Q plots together

#===================================================

JPPPQQ <- function(lcircdat, mu, kappa, psi) {
n <- length(lcircdat) ; ncon <- JPNCon(kappa,psi) 
edf <- ecdf(lcircdat) ; tdf <- 0 ; tqf <- 0
for (j in 1:n) { tdf[j] <- JPDF(lcircdat[j], mu, kappa, psi, ncon) 
tqf[j] <- JPQF(edf(lcircdat)[j], mu, kappa, psi, ncon) }
par(mfrow=c(1,2), mai=c(0.90, 1.1, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tdf, edf(lcircdat), pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "Jones-Pewsey distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
plot.default(tqf, lcircdat, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "Jones-Pewsey quantile function", ylab = "Empirical quantile function") 
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

lcdat <- fisherB6$set1*2*pi/360 ; muhat <- 3.96 ; kaphat <- 1.43 ; psi <- 1 
JPPPQQ(lcdat, muhat, kaphat, psi)

#=======================================

# JP6.2 Just P-P plot for Jones-Pewsey distribution

#=======================================

JPPP <- function(lcircdat, mu, kappa, psi) {
n <- length(lcircdat)
ncon <- JPNCon(kappa,psi) ; edf <- ecdf(lcircdat) ; tdf <- 0
for (j in 1:n) { tdf[j] <- JPDF(lcircdat[j], mu, kappa, psi, ncon) }
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tdf, edf(lcircdat), pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "Jones-Pewsey distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
}

muhat <- 3.96 ; kaphat <- 1.43 ; psi <- 1
JPPP(lcdat, muhat, kaphat, psi)

#=======================================

# JP6.3 Just Q-Q plot for Jones-Pewsey distribution

#=======================================

JPQQ <- function(lcircdat, mu, kappa, psi) {
n <- length(lcircdat)
ncon <- JPNCon(kappa,psi) ; edf <- ecdf(lcircdat) ; tqf <- 0
for (j in 1:n) { tqf[j] <- JPQF(edf(lcircdat)[j], mu, kappa, psi, ncon) }
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tqf, lcircdat, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "Jones-Pewsey quantile function", ylab = "Empirical distribution function")
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

muhat <- 3.96 ; kaphat <- 1.43 ; psi <- 1
JPQQ(lcdat, muhat, kaphat, psi)

#====================================================================================================

# JP6.3 G-o-f of a Jones-Pewsey distribution based on four tests of circular uniformity: no bootstrapping

#====================================================================================================

JPGoF <- function(lcircdat, mu, kappa, psi) {
n <- length(lcircdat) ; ncon <- JPNCon(kappa, psi) ; tdf <- 0
for (j in 1:n) {
tdf[j] <- JPDF(lcircdat[j], mu, kappa, psi, ncon)
}
cunif <- circular(2*pi*tdf)
kuires <- kuiper.test(cunif) ; rayres <- rayleigh.test(cunif) 
raores <- rao.spacing.test(cunif) ; watres <- watson.test(cunif)
return(list(kuires, rayres, raores, watres))
}

muhat <- 3.96 ; kaphat <- 1.43 ; psi <- 1
JPGoFRes <- JPGoF(lcdat, muhat, kaphat, psi) ; JPGoFRes


#====================================================================================================

# JP6.4 G-o-f of an mle fitted Jones-Pewsey distribution based on four tests of circular uniformity: with bootstrapping

#====================================================================================================

JPGoFBoot <- function(lcircdat, B) {
n <- length(lcircdat)
JPmleRes <- JPmle(lcircdat) 
muhat0 <- JPmleRes[[2]] ; kaphat0 <- JPmleRes[[3]] ; psihat0 <- JPmleRes[[4]]
ncon0 <- JPNCon(kaphat0, psihat0) ; tdf <- 0 
for (j in 1:n) {
tdf[j] <- JPDF(lcircdat[j], muhat0, kaphat0, psihat0, ncon0)
}
cunif <- circular(2*pi*tdf)
unitest0 <- 0 ; nxtrm <- 0 ; pval <- 0
for (k in 1:4) {unitest0[i]=0 ; nxtrm[i]=1}
unitest0[1] <- kuiper.test(cunif)$statistic
unitest0[2] <- rayleigh.test(cunif)$statistic
unitest0[3] <- rao.spacing.test(cunif)$statistic
unitest0[4] <- watson.test(cunif)$statistic

for (b in 2:(B+1)) {
bootsamp <- JPSim(n, muhat0, kaphat0, psihat0, ncon0)
JPmleRes <- JPmle(bootsamp) 
muhat1 <- JPmleRes[[2]] ; kaphat1 <- JPmleRes[[3]] ; psihat1 <- JPmleRes[[4]]
ncon1 <- JPNCon(kaphat1, psihat1) ; tdf <- 0
for (j in 1:n) {
tdf[j] <- JPDF(bootsamp[j], muhat1, kaphat1, psihat1, ncon1)
}
cunif <- circular(2*pi*tdf)
kuiper1 <- kuiper.test(cunif)$statistic 
if (kuiper1 >= unitest0[1]) {nxtrm[1] <- nxtrm[1] + 1}
rayleigh1 <- rayleigh.test(cunif)$statistic 
if (rayleigh1 >= unitest0[2]) {nxtrm[2] <- nxtrm[2] + 1}
rao1 <- rao.spacing.test(cunif)$statistic 
if (rao1 >= unitest0[3]) {nxtrm[3] <- nxtrm[3] + 1}
watson1 <- watson.test(cunif)$statistic 
if (watson1 >= unitest0[4]) {nxtrm[4] <- nxtrm[4] + 1}
}
for (k in 1:4) {pval[k] <- nxtrm[k]/(B+1)}
return(pval)
}

x <- fisherB6$set1 ; cdat <- circular(x*2*pi/360)
B <- 999 ; pval <- JPGoFBoot(cdat, B) ; pval

#====================================================================================================

# JP6.5 G-o-f of an mle fitted Jones-Pewsey distribution with specified value, psi0, of psi, 
based on four tests of circular uniformity: with bootstrapping

#====================================================================================================

JPpsi0GoFBoot <- function(lcircdat, psi0, B) {
n <- length(lcircdat)
JPmlepsi0Res <- JPmlepsi0(lcircdat, psi0) 
muhat0 <- JPmlepsi0Res[[2]] ; kaphat0 <- JPmlepsi0Res[[3]] 
ncon0 <- JPNCon(kaphat0, psi0) ; tdf <- 0
for (i in 1:n) {
tdf[i] <- JPDF(lcircdat[i], muhat0, kaphat0, psi0, ncon0)
}
cunif <- circular(2*pi*tdf)
unitest0 <- 0 ; nxtrm <- 0 ; pval <- 0
for (i in 1:4) {unitest0[i]=0 ; nxtrm[i]=1}
unitest0[1] <- kuiper.test(cunif)$statistic
unitest0[2] <- rayleigh.test(cunif)$statistic
unitest0[3] <- rao.spacing.test(cunif)$statistic
unitest0[4] <- watson.test(cunif)$statistic

for (j in 2:(B+1)) {
bootsamp <- JPSim(n, muhat0, kaphat0, psi0, ncon0)
JPmlepsi0Res <- JPmlepsi0(bootsamp, psi0) 
muhat1 <- JPmlepsi0Res[[2]] ; kaphat1 <- JPmlepsi0Res[[3]] 
ncon1 <- JPNCon(kaphat1, psi0) ; tdf <- 0
for (i in 1:n) {
tdf[i] <- JPDF(bootsamp[i], muhat1, kaphat1, psi0, ncon1)
}
cunif <- circular(2*pi*tdf)
kuiper1 <- kuiper.test(cunif)$statistic 
if (kuiper1 >= unitest0[1]) {nxtrm[1] <- nxtrm[1] + 1}
rayleigh1 <- rayleigh.test(cunif)$statistic 
if (rayleigh1 >= unitest0[2]) {nxtrm[2] <- nxtrm[2] + 1}
rao1 <- rao.spacing.test(cunif)$statistic 
if (rao1 >= unitest0[3]) {nxtrm[3] <- nxtrm[3] + 1}
watson1 <- watson.test(cunif)$statistic 
if (watson1 >= unitest0[4]) {nxtrm[4] <- nxtrm[4] + 1}
}
for (i in 1:4) {pval[i] <- nxtrm[i]/(B+1)}
return(pval)
}

x <- fisherB6$set1 ; cdat <- circular(x*2*pi/360)
psi0 <- 1 ; B <- 9999 ; pval <- JPpsi0GoFBoot(cdat, psi0, B) ; pval

#====================================================================================================

# Fitting a Jones-Pewsey distribution to grouped data using maximum likelihood estimation      

#====================================================================================================

#===================================================

# JPG1.1 Just maximum likelihood point estimation.

#===================================================

JPGmle <- function(ofreqs, breaks) {
nfreq <- length(ofreqs) ; n <- sum(ofreqs)
s <- 0 ; c <- 0
for (j in 1:nfreq) {
s <- s+ofreqs[j]*sin((breaks[j]+breaks[j+1])/2)
c <- c+ofreqs[j]*cos((breaks[j]+breaks[j+1])/2)
}
muvM <- atan2(s,c) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPGnll <- function(p){
mu  <-  p[1] ; kappa  <-  p[2] ; psi  <-  p[3] ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa,psi) 
nll <- 0
for (j in 1:nfreq) {
pj <- JPDF(breaks[j+1], mu, kappa, psi, ncon) - JPDF(breaks[j], mu, kappa, psi, ncon) 
nll  <-  nll - ofreqs[j]*log(pj) } 

return(nll) }
}

out <- optim(par=c(muvM, kapvM, 0), fn=JPGnll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0, -Inf), upper = c(muvM+pi, Inf, Inf), hessian = F)

muhat <- out$par[1] ; kaphat <- out$par[2] ; psihat <- out$par[3]

return(list(muhat, kaphat, psihat))
}

# Mallard data (Table 1.1 in Mardia (1972) and Mardia & Jupp (1999) 

breaks <- 20*seq(from=0, to=18, by=1) ; breaks <- breaks*2*pi/360
ofreqs <- c(40, 22, 20, 9, 6, 3, 3, 1, 6, 3, 11, 22, 24, 58, 136, 138, 143, 69)
JPGmleRes <- JPGmle(ofreqs, breaks) ; JPGmleRes

#===================================================

# JPG1.2 Maximum likelihood point estimation, normal theory 100(1-alpha)% confidence intervals, maximum of log-likelihood, AIC and BIC.

#===================================================

JPGmlePlus <- function(ofreqs, breaks, conflevel) {
alpha <- (100-conflevel)/100 ; quant <- qnorm(1-alpha/2)
nfreq <- length(ofreqs) ; n <- sum(ofreqs)
s <- 0 ; c <- 0
for (j in 1:nfreq) {
s <- s+ofreqs[j]*sin((breaks[j]+breaks[j+1])/2)
c <- c+ofreqs[j]*cos((breaks[j]+breaks[j+1])/2)
}
muvM <- atan2(s,c) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPGnll <- function(p){
mu  <-  p[1] ; kappa  <-  p[2] ; psi  <-  p[3] ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa,psi) 
nll <- 0
for (j in 1:nfreq) {
pj <- JPDF(breaks[j+1], mu, kappa, psi, ncon) - JPDF(breaks[j], mu, kappa, psi, ncon) 
nll  <-  nll - ofreqs[j]*log(pj) } 

return(nll) }
}

out <- optim(par=c(muvM, kapvM, 0), fn=JPGnll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0, -Inf), upper = c(muvM+pi, Inf, Inf), hessian = T)

lmax <- -out$value ; npar <- 3 
AIC <- 2*(npar-lmax) ; BIC <- (npar*log(n))-(2*lmax)

HessMat <- out$hessian ; infmat  <-  solve(out$hessian) 
standerr <- sqrt(diag(infmat))

muhat <- out$par[1] ; kaphat <- out$par[2] ; psihat <- out$par[3]
muint <- c(muhat-quant*standerr[1], muhat+quant*standerr[1])
kapint <- c(kaphat-quant*standerr[2], kaphat+quant*standerr[2])
psiint <- c(psihat-quant*standerr[3], psihat+quant*standerr[3])

return(list(muhat, muint, kaphat, kapint, psihat, psiint, lmax, AIC, BIC))
}

# Mallard data (Table 1.1 in Mardia (1972) and Mardia & Jupp (1999) 

breaks <- 20*seq(from=0, to=18, by=1) ; breaks <- breaks*2*pi/360
ofreqs <- c(40, 22, 20, 9, 6, 3, 3, 1, 6, 3, 11, 22, 24, 58, 136, 138, 143, 69)
conflevel <- 95 ; JPGmleRes <- JPGmlePlus(ofreqs, breaks, conflevel) ; JPGmleRes

#===================================================

# Mallard data: Histogram with superimposed density

#===================================================

centres <- 20*seq(from=0.5, to=17.5, by=1) ; centres <- centres*2*pi/360
gdat <- rep(centres, ofreqs) ; ciwidth <- 2*pi*20/360 ; n <- length(gdat)
for (j in 1:n) { if (gdat[j] > 7*ciwidth) {gdat[j] <- gdat[j]-2*pi} }
hbrk <- seq(from=-11*ciwidth, to=7*ciwidth, by=ciwidth)
tval <- seq(from=-11*ciwidth, to=7*ciwidth, by=0.02) 
muhat <- JPGmleRes[[1]] ; kaphat <- JPGmleRes[[3]] 
psihat <- JPGmleRes[[5]] ; ncon <- JPNCon(kaphat, psihat)
JPden <- JPPDF(tval, muhat, kaphat, psihat, ncon)
par(lwd=2)
hist(gdat, freq=F, breaks=hbrk, main=" ", ylim=c(0,0.65), xlab="Vanishing angle (radians)", ylab="Density")
lines(tval, JPden)

#===================================================

# JPG1.3 Just maximum likelihood point estimation for submodel with a specified value, psi0, of psi.

#===================================================

JPGpsi0mle <- function(ofreqs, breaks, psi0) {
nfreq <- length(ofreqs) ; n <- sum(ofreqs)
s <- 0 ; c <- 0
for (j in 1:nfreq) {
s <- s+ofreqs[j]*sin((breaks[j]+breaks[j+1])/2)
c <- c+ofreqs[j]*cos((breaks[j]+breaks[j+1])/2)
}
muvM <- atan2(s,c) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPGpsi0nll <- function(p){
mu  <-  p[1] ; kappa  <-  p[2] ; psi  <-  psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa,psi) 
nll <- 0
for (j in 1:nfreq) {
pj <- JPDF(breaks[j+1], mu, kappa, psi, ncon) - JPDF(breaks[j], mu, kappa, psi, ncon) 
nll  <-  nll - ofreqs[j]*log(pj) } 

return(nll) }
}

out <- optim(par=c(muvM, kapvM), fn=JPGpsi0nll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0), upper = c(muvM+pi, Inf), hessian = F)
muhat <- out$par[1] ; kaphat <- out$par[2] 
return(list(muhat, kaphat))
}

breaks <- 20*seq(from=0, to=18, by=1) ; breaks <- breaks*2*pi/360
ofreqs <- c(40, 22, 20, 9, 6, 3, 3, 1, 6, 3, 11, 22, 24, 58, 136, 138, 143, 69)
psi0 <- 0 ; JPGpsi0mleRes <- JPGpsi0mle(ofreqs, breaks, psi0) ; JPGpsi0mleRes

#====================================================================================================

# JPG1.4 Maximum likelihood point estimation, normal theory 100(1-alpha)% confidence intervals, maximum of log-likelihood, AIC and BIC
# for submodel with a specified value, psi0, of psi.

#====================================================================================================

JPGpsi0mlePlus <- function(ofreqs, breaks, psi0, conflevel) {
alpha <- (100-conflevel)/100 ; quant <- qnorm(1-alpha/2)
nfreq <- length(ofreqs) ; n <- sum(ofreqs)
s <- 0 ; c <- 0
for (j in 1:nfreq) {
s <- s+ofreqs[j]*sin((breaks[j]+breaks[j+1])/2)
c <- c+ofreqs[j]*cos((breaks[j]+breaks[j+1])/2)
}
muvM <- atan2(s,c) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

JPGpsi0nll <- function(p){
mu  <-  p[1] ; kappa  <-  p[2] ; psi  <-  psi0 ; parlim <- abs(kappa*psi)
if (parlim > 10) {y <- 9999.0 ; return(y)}
else {
ncon <- JPNCon(kappa,psi) 
nll <- 0
for (j in 1:nfreq) {
pj <- JPDF(breaks[j+1], mu, kappa, psi, ncon) - JPDF(breaks[j], mu, kappa, psi, ncon) 
nll  <-  nll - ofreqs[j]*log(pj) } 

return(nll) }
}

out <- optim(par=c(muvM, kapvM), fn=JPGpsi0nll, gr = NULL, method = "L-BFGS-B", lower = c(muvM-pi, 0), upper = c(muvM+pi, Inf), hessian = T)

lmax <- -out$value ; npar <- 2 
AIC<- 2*(npar-lmax) ; BIC <- (npar*log(n))-(2*lmax)

HessMat <- out$hessian ; infmat  <-  solve(out$hessian) 
standerr <- sqrt(diag(infmat))

muhat <- out$par[1] ; kaphat <- out$par[2] 
muint <- c(muhat-quant*standerr[1], muhat+quant*standerr[1])
kapint <- c(kaphat-quant*standerr[2], kaphat+quant*standerr[2])

return(list(muhat, muint, kaphat, kapint, lmax, AIC, BIC))
}

breaks <- 20*seq(from=0, to=18, by=1) ; breaks <- breaks*2*pi/360
ofreqs <- c(40, 22, 20, 9, 6, 3, 3, 1, 6, 3, 11, 22, 24, 58, 136, 138, 143, 69)
psi0 <- 0 ; conflevel <- 95 ; JPGpsi0mleRes <- JPGpsi0mlePlus(ofreqs, breaks, psi0, conflevel) ; JPGpsi0mleRes


#====================================================================================================

# JPG2. P-P and Q-Q plots for grouped data from an assumed Jones-Pewsey distribution

#====================================================================================================

#===================================================

# JPG2.1 P-P and Q-Q plots together

#===================================================

JPGPPQQ <- function(ofreqs, breaks, mu, kappa, psi) {
n <- sum(ofreqs) ; ncon <- JPNCon(kappa, psi) ; uplims <- breaks[-1]
nlims <- length(uplims) ; edf <- cumsum(ofreqs/n) ; tdf <- 0 ; tqf <- 0
for (j in 1:nlims) { tdf[j] <- JPDF(uplims[j], mu, kappa, psi, ncon) 
tqf[j] <- JPQF(edf[j], mu, kappa, psi, ncon) }
par(mfrow=c(1,2), mai=c(0.90, 1.1, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tdf, edf, pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "Jones-Pewsey distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
plot.default(tqf, uplims, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "Jones-Pewsey quantile function", ylab = "Empirical quantile function") 
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

mu <- 5.47 ; kappa <- 1.85 ; psi <- -0.37
breaks <- 20*seq(from=0, to=18, by=1) ; breaks <- breaks*2*pi/360
ofreqs <- c(40, 22, 20, 9, 6, 3, 3, 1, 6, 3, 11, 22, 24, 58, 136, 138, 143, 69)
JPGPPQQ(ofreqs, breaks, mu, kappa, psi)

#===================================================

# JPG2.2 Just P-P plot

#===================================================

JPGPP <- function(ofreqs, breaks, mu, kappa, psi) {
n <- sum(ofreqs) ; edf <- cumsum(ofreqs/n) ; ncon <- JPNCon(kappa, psi)
uplims <- breaks[-1] ; nlims <- length(uplims)
tdf <- 0
for (j in 1:nlims) { tdf[j] <- JPDF(uplims[j], mu, kappa, psi, ncon) }
plot.default(tdf, edf, pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "Jones-Pewsey distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
}

mu <- 5.47 ; kappa <- 1.85 ; psi <- -0.35
breaks <- 20*seq(from=0, to=18, by=1) ; breaks <- breaks*2*pi/360
ofreqs <- c(40, 22, 20, 9, 6, 3, 3, 1, 6, 3, 11, 22, 24, 58, 136, 138, 143, 69)
JPGPP(ofreqs, breaks, mu, kappa, psi)

#===================================================

# JPG2.3 Just Q-Q plot

#===================================================

JPGQQ <- function(ofreqs, breaks, mu, kappa, psi) {
n <- sum(ofreqs) ; edf <- cumsum(ofreqs/n) ; ncon <- JPNCon(kappa, psi)
uplims <- breaks[-1] ; nlims <- length(uplims)
tqf <- 0
for (j in 1:nlims) { tqf[j] <- JPQF(edf[j], mu, kappa, psi, ncon) }
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tqf, uplims, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "Jones-Pewsey quantile function", ylab = "Empirical quantile function") 
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

mu <- 5.47 ; kappa <- 1.85 ; psi <- -0.35
breaks <- 20*seq(from=0, to=18, by=1) ; breaks <- breaks*2*pi/360
ofreqs <- c(40, 22, 20, 9, 6, 3, 3, 1, 6, 3, 11, 22, 24, 58, 136, 138, 143, 69)
JPGQQ(ofreqs, breaks, mu, kappa, psi)

#====================================================================================================

# JPG3.1 Goodness-of-fit testing: Bootstrap version of Watson U^2 test for grouped data of Choulakian, Lockhart & Stephens (1994)
# For maximum likelihood fitted member of the full Jones-Pewsey family

#====================================================================================================

JPGUGsq <- function(ofreqs, breaks, mu, kappa, psi, ncon){
Fval <- 0 ; Pval <- 0 ; Eval <- 0 ; Dval <-0 
nbreak <- length(breaks) ; n <- sum(ofreqs)
for (j in 2:nbreak) {
jm1 <- j-1
Fval[j] <- JPDF(breaks[j], mu, kappa, psi, ncon)
Pval[jm1] <- (Fval[j]-Fval[jm1]) ; Eval[jm1] <- Pval[jm1]*n
Dval[jm1] <- ofreqs[jm1] - Eval[jm1] }
Sval <- cumsum(Dval) ; Sbar <- sum(Pval*Sval)
UGsq <- sum((Sval-Sbar)*(Sval-Sbar)*Pval)/n 
return(UGsq)
}

JPGUGsqBoot <- function(ofreqs, breaks, B){
nfreq <- length(ofreqs) ; n <- sum(ofreqs)
JPGmleRes <- JPGmle(ofreqs, breaks)
muhat0 <- JPGmleRes[[1]] ; kaphat0 <- JPGmleRes[[2]] ; psihat0 <- JPGmleRes[[3]]
ncon0 <- JPNCon(kaphat0, psihat0)
stat0 <- JPGUGsq(ofreqs, breaks, muhat0, kaphat0, psihat0, ncon0) ; nxtrm <- 1
for (b in 2:(B+1)) {
freqs <- seq(1:nfreq)*0
x <- JPSim(n, muhat0, kaphat0, psihat0, ncon0) 
for (j in 1:n) { 
for (k in 1:nfreq) { 
if (x[j] >= breaks[k]) { if (x[j] < breaks[k+1]) {freqs[k] <- freqs[k]+1} } } }
JPGmleRes <- JPGmle(freqs, breaks)
muhat1 <- JPGmleRes[[1]] ; kaphat1 <- JPGmleRes[[2]] ; psihat1 <- JPGmleRes[[3]]
ncon1 <- JPNCon(kaphat1, psihat1)
stat1 <- JPGUGsq(freqs, breaks, muhat1, kaphat1, psihat1, ncon1)
if (stat1 >= stat0) {nxtrm <- nxtrm + 1}
}
pval <- nxtrm/(B+1) ; return(pval)
}

B <- 9999 ; pval <- JPGUGsqBoot(ofreqs, breaks, B) ; pval

#====================================================================================================

# JPG3.2 Goodness-of-fit testing: Bootstrap version of Watson U^2 test for grouped data of Choulakian, Lockhart & Stephens (1994)
# For maximum likelihood fitted member of a Jones-Pewsey submodel with specified value, psi0, of psi.

#====================================================================================================

JPGpsi0UGsqBoot <- function(ofreqs, breaks, psi0, B){
nfreq <- length(ofreqs) ; n <- sum(ofreqs)
JPGmleRes <- JPGpsi0mle(ofreqs, breaks, psi0)
muhat0 <- JPGmleRes[[1]] ; kaphat0 <- JPGmleRes[[2]]
ncon0 <- JPNCon(kaphat0, psi0)
stat0 <- JPGUGsq(ofreqs, breaks, muhat0, kaphat0, psi0, ncon0) ; nxtrm <- 1
for (j in 2:(B+1)) {
freqs <- seq(1:nfreq)*0
x <- JPSim(n, muhat0, kaphat0, psi0, ncon0) 
for (i in 1:n) { 
for (k in 1:nfreq) { 
if (x[i] >= breaks[k]) { if (x[i] < breaks[k+1]) {freqs[k] <- freqs[k]+1} }
}
}
JPGmleRes <- JPGpsi0mle(freqs, breaks, psi0)
muhat1 <- JPGmleRes[[1]] ; kaphat1 <- JPGmleRes[[2]]
ncon1 <- JPNCon(kaphat1, psi0)
stat1 <- JPGUGsq(freqs, breaks, muhat1, kaphat1, psi0, ncon1)
if (stat1 >= stat0) {nxtrm <- nxtrm + 1}
}
pval <- nxtrm/(B+1) ; return(pval)
}

psi0 <- 0 ; B <- 9999 ; pval <- JPGpsi0UGsqBoot(ofreqs, breaks, psi0, B) ; pval

psi0 <- -1 ; B <- 9999 ; pval <- JPGpsi0UGsqBoot(ofreqs, breaks, psi0, B) ; pval


#====================================================================================================

# Fitting an inverse Batschelet von Mises distribution

#====================================================================================================

# ****************************** Functions from Chapter 4 used subsequently 

tnu <- function(theta, xi, nu) {
phi <- theta-xi 
if (phi <= -pi) {phi <- phi+2*pi}
else if (phi > pi) {phi <- phi-2*pi}
eps <- 10*.Machine$double.eps
if (phi <= -pi+eps) {return(-pi)}
else if (phi >= pi-eps) {return(pi)}
else {
roottol <- .Machine$double.eps**(0.6)
t1nuzero <- function(x){
y <- x-nu*(1+cos(x))-phi ; return(y) }
res <- uniroot(t1nuzero, lower=-pi+eps, upper=pi, tol=roottol)
return(res$root) }
}

invslambda <- function(theta, lambda) {
eps <- 10*.Machine$double.eps
if (lambda <= -1+eps) {return(theta)} 
else {
roottol=.Machine$double.eps**(0.6)
islzero <- function(x) {
y <- x-(1+lambda)*sin(x)/2-theta ; return(y) }
res <- uniroot(islzero, lower=-pi+eps, upper=pi, tol=roottol)
return(res$root) }
}

invBNCon <- function(kappa, lambda) { 
eps <- 10*.Machine$double.eps
mult <- 2*pi*I.0(kappa)
if (lambda >= 1-eps) { ncon <- 1/(mult*(1-A1(kappa))) ; return(ncon) }
else {
con1 <- (1+lambda)/(1-lambda) ; con2 <- (2*lambda)/((1-lambda)*mult)
intgrnd <- function(x){ exp(kappa*cos(x-(1-lambda)*sin(x)/2)) }

intval <- integrate(intgrnd, lower=-pi, upper=pi)$value
ncon <- 1/(mult*(con1-con2*intval)) ; return(ncon) }
}

invBPDF <- function(theta, xi, kappa, nu, lambda, ncon){
arg1 <- tnu(theta,xi,nu)
eps <- 10*.Machine$double.eps
if (lambda <= -1+eps) { 
pdfval <- ncon*exp(kappa*cos(arg1-sin(arg1))) ; return(pdfval) }
else {
con1 <- (1-lambda)/(1+lambda) ; con2 <- (2*lambda)/(1+lambda)
arg2 <- invslambda(arg1,lambda)
pdfval <- ncon*exp(kappa*cos(con1*arg1+con2*arg2))
return(pdfval) }
}

invBDF <- function(theta, xi, kappa, nu, lambda, ncon){
eps <- 10 * .Machine$double.eps
if (theta <= eps) {dfval <- 0 ; return(dfval)} else
if (theta >= 2*pi-eps) {dfval <- 1 ; return(dfval)} else 
if (theta <= pi/2) {nint <- 90} else
if (theta <= pi) {nint <- 180} else
if (theta <= 3*pi/2) {nint <- 270} else
if (theta < 2*pi-eps) {nint <- 360}
width <- theta/nint
dfval <- 0
for (j in 1:nint) {
arg <- (2*j-1)*width/2
dfval <- dfval+invBPDF(arg, xi, kappa, nu, lambda, ncon)
} 
dfval <- dfval*width
return(dfval)
}

invBQF <- function(u, xi, kappa, nu, lambda, ncon) {

eps <- 10 * .Machine$double.eps
if (u <= eps) {theta <- 0 ; return(theta)}

 else
if (u >= 1-eps) {theta <- 2*pi-eps ; return(theta)}
else {
roottol <- 1000*.Machine$double.eps**(0.6)
qzero <- function(x) {

y <- invBDF(x, xi, kappa, nu, lambda, ncon) - u
return(y) }

  
res <- uniroot(qzero, lower=0, upper=2*pi-eps, tol=roottol)
theta <- res$root ; return(theta) }
}

invBSim <- function(n, xi, kappa, nu, lambda, ncon) {
mode <- xi-2*nu ; fmax <- invBPDF(mode, xi, kappa, nu, lambda, ncon)
theta <- 0
for (j in 1:n) {
stopgo <- 0
while (stopgo == 0) {
u1 <- runif(1, 0, 2*pi)
pdfu1 <- invBPDF(u1, xi, kappa, nu, lambda, ncon)
u2 <- runif(1, 0, fmax)
if (u2 <= pdfu1) { theta[j] <- u1 ; stopgo <- 1 }
} }
return(theta)
}

# ******************************* 

#====================================================================================================

# IB1. Data entry and tests for isotropy and reflective symmetry

#====================================================================================================

# Read fruit fly larva changes in direction
angdat <-read.table(file="larva.dat", header=TRUE) ; attach(angdat)
lcdat <- changeang ; cdat <- circular(lcdat) ; n <- length(lcdat)
for (j in 1:n) {if (lcdat[j] <= 0) {lcdat[j] <- lcdat[j]+2*pi} }


# Kuiper isotropy test
kuiper.test(cdat) 

# Large sample test for reflective symmetry of Pewsey (2002).
absz <- RSTestStat(cdat) 
pval = 2*pnorm(absz, mean=0, sd=1, lower=FALSE) ; pval

#====================================================================================================

# IB2. Circular data plot

#====================================================================================================

plot(cdat, pch=16, col="black", stack=TRUE, bins=720, cex=1.2)

#====================================================================================================

# IB3. Maximum likelihood estimation 

#====================================================================================================

#====================================================================================================

# IB3.1 Maximum likelihood estimation (with calculation of maximum value of the log-likelihood, AIC, BIC and the Hessian matrix) 

#====================================================================================================

invBmle <- function(lcircdat) {
s <- sum(sin(lcircdat)) ; c <- sum(cos(lcircdat)) 
xivM <- atan2(s,c) ; n <- length(lcircdat) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

invBnll <- function(p){
xi <- p[1] ; kappa <- p[2]; nu <- p[3] ; lambda <- p[4]
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (j in 1:n) {sum <- sum-log(invBPDF(lcircdat[j], xi, kappa, nu, lambda, ncon))}
return(sum)
}

out <- optim(par=c(xivM, kapvM, 0.01, 0.01), fn=invBnll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, 0, -1, -1), upper = c(pi, Inf, 1, 1), hessian = T)
xihat <- out$par[1] ; kaphat <- out$par[2] ; nuhat <- out$par[3]
lamhat <- out$par[4] ; maxll <- -out$value ; HessMat <- out$hessian
npar <- 4 ; AIC <- 2*(npar-maxll) ; BIC <- (npar*log(n))-(2*maxll)
return(list(maxll, AIC, BIC, xihat, kaphat, nuhat, lamhat, HessMat))
}

invBmleRes <- invBmle(lcdat) ; invBmleRes

#====================================================================================================

# IB3.2 Maximum likelihood estimation (only) with specification of initial estimates. Used in invBCIBoot. 

#====================================================================================================

invBmleReduced <- function(lcircdat, xiest, kapest, nuest, lamest) {
n <- length(lcircdat) 

invBnll <- function(p){
xi <- p[1] ; kappa <- p[2]; nu <- p[3] ; lambda <- p[4]
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum <- sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum)
}

out <- optim(par=c(xiest, kapest, nuest, lamest), fn=invBnll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, 0, -1, -1), upper = c(pi, Inf, 1, 1), hessian = F)
xihat <- out$par[1] ; kaphat <- out$par[2] ; nuhat <- out$par[3] ; lamhat <- out$par[4] 
return(list(xihat, kaphat, nuhat, lamhat))
}

#====================================================================================================

# IB3.3 Maximum likelihood estimation for a specified value, nu0, of nu. 

#====================================================================================================

invBnu0mle <- function(lcircdat, nu0) {
s <- sum(sin(lcircdat)) ; c <- sum(cos(lcircdat)) 
xivM <- atan2(s,c) ; n <- length(lcircdat) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

invBnll <- function(p){
xi <- p[1] ; kappa <- p[2]; nu <- nu0 ; lambda <- p[3]
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum <- sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum)
}

out <- optim(par=c(xivM, kapvM, 0.01), fn=invBnll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, 0, -1), upper = c(pi, Inf, 1), hessian = T)
xihat <- out$par[1] ; kaphat <- out$par[2] ; lamhat <- out$par[3] ; maxll <- -out$value ; HessMat <- out$hessian
npar <- 3 ; AIC <- 2*(npar-maxll) ; BIC <- (npar*log(n))-(2*maxll)
return(list(maxll, AIC, BIC, xihat, kaphat, lamhat, HessMat))
}

nu0 <- 0 ; invBnu0mleRes <- invBnu0mle(lcdat, nu0) ; invBnu0mleRes

#====================================================================================================

# IB3.4 Maximum likelihood estimation for a specified value, lambda0, of lambda 

#====================================================================================================

invBlam0mle <- function(lcircdat, lambda0) {
s <- sum(sin(lcircdat)) ; c <- sum(cos(lcircdat)) 
xivM <- atan2(s,c) ; n <- length(lcircdat) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

invBlam0nll <- function(p){
xi <- p[1] ; kappa <- p[2] ; nu <- p[3] ; lambda <- lambda0
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum <- sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum)
}

out <- optim(par=c(xivM, kapvM, 0.01), fn=invBlam0nll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, 0, -1), upper = c(pi, Inf, 1), hessian = T)
xihat <- out$par[1] ; kaphat <- out$par[2] ; nuhat <- out$par[3] ; maxll <- -out$value 
npar <- 3 ; AIC <- 2*(npar-maxll) ; BIC <- (npar*log(n))-(2*maxll)
return(list(maxll, AIC, BIC, xihat, kaphat, nuhat, HessMat))
}

lam0 <- 0 ; invBlam0mleRes <- invBlam0mle(lcdat, lam0) ; invBlam0mleRes

#====================================================================================================

# IB3.5 Maximum likelihood estimation for a specified values of nu and lambda (nu0 and lambda0)  

#====================================================================================================

invBn0l0mle <- function(lcircdat, nu0, lambda0) {
s <- sum(sin(lcircdat)) ; c <- sum(cos(lcircdat)) 
xivM <- atan2(s,c) ; n <- length(lcircdat) ; kapvM <- A1inv(sqrt(s*s+c*c)/n)

invBn0l0nll <- function(p){
xi <- p[1] ; kappa <- p[2] ; nu <- nu0 ; lambda <- lambda0
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum <- sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum)
}

out <- optim(par=c(xivM, kapvM), fn=invBn0l0nll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, 0), upper = c(pi, Inf), hessian = T)
xihat <- out$par[1] ; kaphat <- out$par[2] ; maxll <- -out$value 
npar <- 2 ; AIC <- 2*(npar-maxll) ; BIC <- (npar*log(n))-(2*maxll)
return(list(maxll, AIC, BIC, xihat, kaphat, HessMat))
}

nu0 <- 0 ; lam0 <- 0 ; invBn0l0mleRes <- invBn0l0mle(lcdat, nu0, lam0) ; invBn0l0mleRes

#====================================================================================================

# IB4. Circular data plot with fitted density superimposed 

#====================================================================================================

xihat <- invBmleRes[[4]] ; kaphat <- invBmleRes[[5]]
nuhat <- invBmleRes[[6]] ; lamhat <- invBmleRes[[7]]
ncon <- invBNCon(kaphat, lamhat)
theta <- circular(seq(0, 2*pi, by=pi/3600))
y <- 0 ; nt <- length(theta)
for (j in 1:nt) {y[j] <- invBPDF(theta[j], xihat, kaphat, nuhat, lamhat, ncon)}
par(mai=c(0, 0, 0, 0))
plot(cdat, xlim=c(-0.8,3.3), pch=16, col="black", stack=TRUE, bins=360, cex=0.7)
lines(theta, y, lty=1, lwd=1)

#====================================================================================================

# IB6. Confidence intervals for the individual parameters

#====================================================================================================

#=============================================================

# IB6.1 Asymptotic normal theory construction

#=============================================================

invBNTCI <- function(xiest, kapest, nuest, lamest, HessMat, conflevel) {
alpha <- (100-conflevel)/100 ; quant <- qnorm(1-alpha/2)
infmat <- solve(HessMat) ; standerr <- sqrt(diag(infmat))
xiint <- c(xiest-quant*standerr[1], xiest+quant*standerr[1]) 
kapint <- c(kapest-quant*standerr[2], kapest+quant*standerr[2]) 
nuint <- c(nuest-quant*standerr[3], nuest+quant*standerr[3]) 
lamint <- c(lamest-quant*standerr[4], lamest+quant*standerr[4]) 
return(list(xiint, kapint, nuint, lamint))
}

HessMat <- invBmleRes[[8]] ; conflevel <- 95
invbntci <- invBNTCI(xihat, kaphat, nuhat, lamhat, HessMat, conflevel) ; invbntci

#=============================================================

# IB6.2 Profile log-likelihood constructions

#=============================================================

#================================

# IB6.2.1 Profile log-likelihood for xi

#================================

invBpllxi <- function(lcircdat, xival, kaphat, nuhat, lamhat) {
n <- length(lcircdat) ; nxival <- length(xival) ; pllxi <- 0 
for (j in 1:nxival) {
xi0 <- xival[j]

invBxi0nll <- function(p) {
xi <- xi0 ; kappa <- p[1] ; nu <- p[2] ; lambda <- p[3]
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum = sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum) 
}

out <- optim(par=c(kaphat, nuhat, lamhat), fn=invBxi0nll, gr = NULL, method = "L-BFGS-B", lower = c(0, -1, -1), upper = c(Inf, 1, 1))
pllxi[j] <- -out$value
}
return(pllxi) 
}

invBpllxiPlotCI <- function(maxll, xival, pllxi, conflevel) {
nxival <- length(xival) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(xival, pllxi, type="l", lwd=2, xlab=expression(xi), ylab=expression(pll(xi)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(xival[1], xival[nxival]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
nxivalm1 <- nxival-1
for (j in 1:nxivalm1) {
if (pllxi[j] < cutpoint) {
jp1 <- j+1
if (pllxi[jp1] > cutpoint) {
grad <- (pllxi[jp1]-pllxi[j])/(xival[jp1]-xival[j])
con <- pllxi[j]-grad*xival[j] ; xilo <- (cutpoint - con)/grad }
}
if (pllxi[j] > cutpoint) {
jp1 <- j+1
if (pllxi[jp1] < cutpoint) {
grad <- (pllxi[j]-pllxi[jp1])/(xival[j]-xival[jp1])
con <- pllxi[j]-grad*xival[j] ; xiup <- (cutpoint - con)/grad }
}
}
return(list(xilo, xiup))
}

xival <- seq(-1.7, -0.3, by=0.05)
pllxi <- invBpllxi(lcdat, xival, kaphat, nuhat, lamhat)
maxll <- invBmleRes[[1]] ; conflevel <- 95
pllxiCI <- invBpllxiPlotCI(maxll, xival, pllxi, conflevel) ; pllxiCI
 
#====================================================================================================

# IB6.2.2 Profile log-likelihood for the mode (zeta = xi-2nu)

#====================================================================================================

invBpllmd <- function(lcircdat, mdval, kaphat, nuhat, lamhat) {
n <- length(lcircdat) ; nmdval <- length(mdval) ; pllmd <- 0 
for (j in 1:nmdval) {
md0 <- mdval[j]

invBmd0nll <- function(p) {
md <- md0 ; kappa <- p[1] ; nu <- p[2] ; lambda <- p[3] ; xi <- md+2*nu
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum = sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum) 
}

out <- optim(par=c(kaphat, nuhat, lamhat), fn=invBmd0nll, gr = NULL, method = "L-BFGS-B", lower = c(0, -1, -1), upper = c(Inf, 1, 1))
pllmd[j] <- -out$value
}
return(pllmd) 
}

invBpllmdPlotCI <- function(maxll, mdval, pllmd, conflevel) {
nmdval <- length(mdval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(mdval, pllmd, type="l", lwd=2, xlab=expression(mode), ylab=expression(pll(mode)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(mdval[1], mdval[nmdval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
nmdvalm1 <- nmdval-1
for (j in 1:nmdvalm1) {
if (pllmd[j] < cutpoint) {
jp1 <- j+1
if (pllmd[jp1] > cutpoint) {
grad <- (pllmd[jp1]-pllmd[j])/(mdval[jp1]-mdval[j])
con <- pllmd[j]-grad*mdval[j] ; mdlo <- (cutpoint - con)/grad }
}
if (pllmd[j] > cutpoint) {
jp1 <- j+1
if (pllmd[jp1] < cutpoint) {
grad <- (pllmd[j]-pllmd[jp1])/(mdval[j]-mdval[jp1])
con <- pllmd[j]-grad*mdval[j] ; mdup <- (cutpoint - con)/grad }
}
}
return(list(mdlo, mdup))
}

mdval <- seq(-0.035, 0.035, by=0.0025)
pllmd <- invBpllmd(lcdat, mdval, kaphat, nuhat, lamhat)
maxll <- invBmleRes[[1]] ; conflevel <- 95
pllmdCI <- invBpllmdPlotCI(maxll, mdval, pllmd, conflevel) ; pllmdCI
 

#====================================================================================================

# IB6.2.3 Profile log-likelihood for kappa

#====================================================================================================

invBpllkap <- function(lcircdat, xihat, kapval, nuhat, lamhat) {
n <- length(lcircdat) ; nkapval <- length(kapval) ; pllkap <- 0 
for (j in 1:nkapval) {
kap0 <- kapval[j]

invBkap0nll <- function(p) {
xi <- p[1] ; kappa <- kap0 ; nu <- p[2] ; lambda <- p[3] 
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum = sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum) 
}

out <- optim(par=c(xihat, nuhat, lamhat), fn=invBkap0nll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, -1, -1), upper = c(pi, 1, 1))
pllkap[j] <- -out$value
}
return(pllkap) 
}

invBpllkapPlotCI <- function(maxll, kapval, pllkap, conflevel) {
nkapval <- length(kapval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(kapval, pllkap, type="l", lwd=2, xlab=expression(kappa), ylab=expression(pll(kappa)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(kapval[1], kapval[nkapval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
nkapvalm1 <- nkapval-1
for (j in 1:nkapvalm1) {
if (pllkap[j] < cutpoint) {
jp1 <- j+1
if (pllkap[jp1] > cutpoint) {
grad <- (pllkap[jp1]-pllkap[j])/(kapval[jp1]-kapval[j])
con <- pllkap[j]-grad*kapval[j] ; kaplo <- (cutpoint - con)/grad }
}
if (pllkap[j] > cutpoint) {
jp1 <- j+1
if (pllkap[jp1] < cutpoint) {
grad <- (pllkap[j]-pllkap[jp1])/(kapval[j]-kapval[jp1])
con <- pllkap[j]-grad*kapval[j] ; kapup <- (cutpoint - con)/grad }
}
}
return(list(kaplo, kapup))
}

kapval <- seq(2.45, 3.15, by=0.025)
pllkap <- invBpllkap(lcdat, xihat, kapval, nuhat, lamhat)
maxll <- invBmleRes[[1]] ; conflevel <- 95
pllkapCI <- invBpllkapPlotCI(maxll, kapval, pllkap, conflevel) ; pllkapCI
 

#====================================================================================================

# IB6.2.4 Profile log-likelihood for nu

#====================================================================================================

invBpllnu <- function(lcircdat, xihat, kaphat, nuval, lamhat) {
n <- length(lcircdat) ; nnuval <- length(nuval) ; pllnu <- 0 
for (j in 1:nnuval) {
nu0 <- nuval[j]

invBnu0nll <- function(p) {
xi <- p[1] ; kappa <- p[2] ; nu <- nu0 ; lambda <- p[3] 
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum = sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum) 
}

out <- optim(par=c(xihat, kaphat, lamhat), fn=invBnu0nll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, 0, -1), upper = c(pi, Inf, 1))
pllnu[j] <- -out$value
}
return(pllnu) 
}

invBpllnuPlotCI <- function(maxll, nuval, pllnu, conflevel) {
nnuval <- length(nuval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(nuval, pllnu, type="l", lwd=2, xlab=expression(nu), ylab=expression(pll(nu)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(nuval[1], nuval[nnuval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
nnuvalm1 <- nnuval-1
for (j in 1:nnuvalm1) {
if (pllnu[j] < cutpoint) {
jp1 <- j+1
if (pllnu[jp1] > cutpoint) {
grad <- (pllnu[jp1]-pllnu[j])/(nuval[jp1]-nuval[j])
con <- pllnu[j]-grad*nuval[j] ; nulo <- (cutpoint - con)/grad }
}
if (pllnu[j] > cutpoint) {
jp1 <- j+1
if (pllnu[jp1] < cutpoint) {
grad <- (pllnu[j]-pllnu[jp1])/(nuval[j]-nuval[jp1])
con <- pllnu[j]-grad*nuval[j] ; nuup <- (cutpoint - con)/grad }
}
}
return(list(nulo, nuup))
}

nuval <- seq(-0.85, -0.15, by=0.025)
pllnu <- invBpllnu(lcdat, xihat, kaphat, nuval, lamhat)
maxll <- invBmleRes[[1]] ; conflevel <- 95
pllnuCI <- invBpllnuPlotCI(maxll, nuval, pllnu, conflevel) ; pllnuCI
 
#====================================================================================================

# IB6.2.5 Profile log-likelihood for lambda

#====================================================================================================

invBplllam <- function(lcircdat, xihat, kaphat, nuhat, lamval) {
n <- length(lcircdat) ; nlamval <- length(lamval) ; plllam <- 0 
for (j in 1:nlamval) {
lam0 <- lamval[j]

invBlam0nll <- function(p) {
xi <- p[1] ; kappa <- p[2] ; nu <- p[3] ; lambda <- lam0 
ncon <- invBNCon(kappa, lambda) ; sum <- 0
for (i in 1:n) {sum = sum-log(invBPDF(lcircdat[i], xi, kappa, nu, lambda, ncon))}
return(sum) 
}

out <- optim(par=c(xihat, kaphat, nuhat), fn=invBlam0nll, gr = NULL, method = "L-BFGS-B", lower = c(-pi, 0, -1), upper = c(pi, Inf, 1))
plllam[j] <- -out$value
}
return(plllam) 
}

invBplllamPlotCI <- function(maxll, lamval, plllam, conflevel) {
nlamval <- length(lamval) ; alpha <- (100-conflevel)/100
par(mai=c(0.90, 0.95, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot(lamval, plllam, type="l", lwd=2, xlab=expression(lambda), ylab=expression(pll(lambda)))
cutpoint <- maxll-qchisq(1-alpha, df=1)/2 ; cutpoint
xlim <- c(lamval[1], lamval[nlamval]) ; ylim <- c(cutpoint, cutpoint)
lines(xlim, ylim, lwd=2, lty=2)

# Linear interpolation
lamup <- 1
nlamvalm1 <- nlamval-1
for (j in 1:nlamvalm1) {
if (plllam[j] < cutpoint) {
jp1 <- j+1
if (plllam[jp1] > cutpoint) {
grad <- (plllam[jp1]-plllam[j])/(lamval[jp1]-lamval[j])
con <- plllam[j]-grad*lamval[j] ; lamlo <- (cutpoint - con)/grad }
}
if (plllam[j] > cutpoint) {
jp1 <- j+1
if (plllam[jp1] < cutpoint) {
grad <- (plllam[j]-plllam[jp1])/(lamval[j]-lamval[jp1])
con <- plllam[j]-grad*lamval[j] ; lamup <- (cutpoint - con)/grad }
}
}
return(list(lamlo, lamup))
}

lamval <- seq(0.65, 0.975, by=0.025)
plllam <- invBplllam(lcdat, xihat, kaphat, nuhat, lamval)
maxll <- invBmleRes[[1]] ; conflevel <- 95
plllamCI <- invBplllamPlotCI(maxll, lamval, plllam, conflevel) ; plllamCI
 
#====================================================================================================

# IB6.3 Parametric bootstrap: sampling from fitted inverse Batschelet von Mises distribution

#====================================================================================================

invBCIBoot <- function(lcircdat, xiest, kapest, nuest, lamest, conflevel, B) {
n <- length(lcircdat) ; alpha <- (100-conflevel)/100
mdest <- xiest-2*nuest ; ncon0 <- invBNCon(kapest, lamest)
for (j in 2:(B+1)) {
invbdat <- invBSim(n, xiest[1], kapest[1], nuest[1], lamest[1], ncon0)
invBmleRes <- invBmleReduced(invbdat, xiest[1], kapest[1], nuest[1], lamest[1]) 
xiest[j] <- invBmleRes[[1]] ; kapest[j] <- invBmleRes[[2]] ; nuest[j] <- invBmleRes[[3]] 
lamest[j] <- invBmleRes[[4]] ; mdest[j] <- xiest[j]-2*nuest[j]
}
for (j in 1:(B+1)) { 
if (xiest[j] < 0) {xiest[j] <- xiest[j]+2*pi} 
if (mdest[j] < 0) {mdest[j] <- mdest[j]+2*pi}
}

dist <- 0
if (xiest[1] < pi) {
ref <- xiest[1] + pi
for (j in 1:(B+1)) { 
dist[j] <- -(pi-abs(pi-abs(xiest[j]-xiest[1])))
if (xiest[j] > xiest[1]) {
if (xiest[j] < ref) {dist[j] <- -dist[j]}
}
}
} else
if (xiest[1] >= pi) {
ref <- xiest[1] - pi
for (j in 1:(B+1)) { 
dist[j] <- pi-abs(pi-abs(xiest[j]-xiest[1]))
if (xiest[j] > ref) {
if (xiest[j] < xiest[1]) {dist[j] <- -dist[j]}
}
}
}
sdist <- sort(dist)
xilo <- xiest[1]+sdist[(B+1)*(alpha/2)] ; xiup <- xiest[1]+sdist[(B+1)*(1-alpha/2)]
xires <- c(xiest[1], xilo, xiup)

dist <- 0
if (mdest[1] < pi) {
ref <- mdest[1] + pi
for (j in 1:(B+1)) { 
dist[j] <- -(pi-abs(pi-abs(mdest[j]-mdest[1])))
if (mdest[j] > mdest[1]) {
if (mdest[j] < ref) {dist[j] <- -dist[j]}
}
}
} else
if (mdest[1] >= pi) {
ref <- mdest[1] - pi
for (j in 1:(B+1)) { 
dist[j] <- pi-abs(pi-abs(mdest[j]-mdest[1]))
if (mdest[j] > ref) {
if (mdest[j] < mdest[1]) {dist[j] <- -dist[j]}
}
}
}
sdist <- sort(dist)
mdlo <- mdest[1]+sdist[(B+1)*(alpha/2)] ; mdup <- mdest[1]+sdist[(B+1)*(1-alpha/2)]
mdres <- c(mdest[1], mdlo, mdup)

skapest <- sort(kapest) 
kaplo <- skapest[(B+1)*alpha/2] ; kapup <- skapest[(B+1)*(1-alpha/2)]
kapres <- c(kapest[1], kaplo, kapup)
snuest <- sort(nuest)
nulo <- snuest[(B+1)*alpha/2] ; nuup <- snuest[(B+1)*(1-alpha/2)]
nures <- c(nuest[1], nulo, nuup)
slamest <- sort(lamest)
lamlo <- slamest[(B+1)*alpha/2] ; lamup <- slamest[(B+1)*(1-alpha/2)]
lamres <- c(lamest[1], lamlo, lamup)
return(list(xires, mdres, kapres, nures, lamres))
}

conflevel <- 95 ; B <- 999 
invBCIBootRes <- invBCIBoot(lcdat, xihat, kaphat, nuhat, lamhat, conflevel, B) ; invBCIBootRes

#====================================================================================================

# IB7.1 P-P and Q-Q plot for specified Inverse Batschelet von Mises distribution

#====================================================================================================

invBPPQQ <- function(lcircdat, xi, kappa, nu, lambda) {
n <- length(lcircdat) ; ncon <- invBNCon(kappa,lambda) 
edf <- ecdf(lcircdat) ; tdf <- 0 ; tqf <- 0
for (j in 1:n) { tdf[j] <- invBDF(lcircdat[j], xi, kappa, nu, lambda, ncon) 
tqf[j] <- invBQF(edf(lcircdat)[j], xi, kappa, nu, lambda, ncon) }
par(mfrow=c(1,2), mai=c(0.90, 1.1, 0.05, 0.1), cex.axis=1.2, cex.lab=1.5)
plot.default(tdf, edf(lcircdat), pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "Inverse Batschelet von Mises distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
plot.default(tqf, lcircdat, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "Inverse Batschelet von Mises quantile function", ylab = "Empirical quantile function") 
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

invBPPQQ(lcdat, xihat, kaphat, nuhat, lamhat)

#====================================================================================================

# IB7.2 Just P-P plot for specified Inverse Batschelet von Mises distribution

#====================================================================================================

invBPP <- function(lcircdat, xi, kappa, nu, lambda) {
n <- length(lcircdat) ; ncon <- invBNCon(kappa,lambda) 
edf <- ecdf(lcircdat) ; tdf <- 0 
for (j in 1:n) { tdf[j] <- invBDF(lcircdat[j], xi, kappa, nu, lambda, ncon) }
par(mai=c(0.90, 1.1, 0.05, 0.1), cex.axis=1.1, cex.lab=1.3)
plot.default(tdf, edf(lcircdat), pch=16, xlim=c(0,1), ylim=c(0,1), xlab = "Inverse Batschelet von Mises distribution function", ylab = "Empirical distribution function")
xlim <- c(0,1) ; ylim <- c(0,1) ; lines(xlim, ylim, lwd=2, lty=2)
}

invBPP(lcdat, xihat, kaphat, nuhat, lamhat)

#====================================================================================================

# IB7.3 Just Q-Q plot for specified Inverse Batschelet von Mises distribution

#====================================================================================================

invBQQ <- function(lcircdat, xi, kappa, nu, lambda) {
n <- length(lcircdat) ; ncon <- invBNCon(kappa,lambda) 
edf <- ecdf(lcircdat) ; tqf <- 0
for (j in 1:n) { tqf[j] <- invBQF(edf(lcircdat)[j], xi, kappa, nu, lambda, ncon) }
par(mai=c(0.90, 1.1, 0.05, 0.1), cex.axis=1.1, cex.lab=1.3)
plot.default(tqf, lcircdat, pch=16, xlim=c(0,2*pi), ylim=c(0,2*pi), xlab = "Inverse Batschelet von Mises quantile function", ylab = "Empirical quantile function") 
xlim <- c(0,2*pi) ; ylim <- c(0,2*pi) ; lines(xlim, ylim, lwd=2, lty=2)
}

invBQQ(lcdat, xihat, kaphat, nuhat, lamhat)

#====================================================================================================

# IB8 G-o-f testing based on four tests of uniformity (with no allowance for parameter estimation)

#====================================================================================================

invBGoF <- function(lcircdat,xi, kappa, nu, lambda) {
n <- length(lcircdat) ; ncon <- invBNCon(kappa, lambda) ; tdf <- 0
for (j in 1:n) {
tdf[j] <- invBDF(lcircdat[j], xi, kappa, nu, lambda, ncon)
}
cunif <- circular(2*pi*tdf)
kuires <- kuiper.test(cunif) ; rayres <- rayleigh.test(cunif) 
raores <- rao.spacing.test(cunif) ; watres <- watson.test(cunif)
return(list(kuires, rayres, raores, watres))
}

invBGoFRes <- invBGoF(lcdat, xihat, kaphat, nuhat, lamhat) ; invBGoFRes

#====================================================================================================

