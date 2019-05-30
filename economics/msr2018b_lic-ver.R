#
# msr2018b_lic-ver.R, 10 Apr 19
# Data from:
# Understanding the Usage, Impact, and Adoption of Non-{OSI} Approved Licenses
# R\^{o}mulo Meloca and Gustavo Pinto and Leonardo Baiser and Marco Mattos and Ivanilton Polato and Igor Scaliante Wiese and Daniel M. German
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG NPM CRAN RubyGems licensing packages


source("ESEUR_config.r")


pal_col=rainbow(3)


lv=read.csv(paste0(ESEUR_dir, "economics/msr2018b_lic-ver.csv.xz"), as.is=TRUE)

plot(lv$Licenses, lv$NPM, log="y", type="b", col=pal_col[1],
	xlim=c(0, 6), ylim=c(1, 3e6),
	xlab="Licenses", ylab="Packages\n")
points(lv$Licenses, lv$RubyGems, type="b", col=pal_col[2])
points(lv$Licenses, lv$CRAN, type="b", col=pal_col[3])

legend(x="topright", legend=c("NPM", "RubyGems", "CRAN"), bty="n", fill=pal_col, cex=1.2)

# npm_pc=rep(lv$Licenses, lv$NPM)
# 
# library("gamlss")
# 
# # The data is under-dispersed, generalised Poisson not good.
# # Try Zero adjusted Gamma
# # Zero-inflated exponential might be good, but not supported
# zp_mod=gamlss(npm_pc ~ 1, family=ZAGA)
# 
# Not a good fit, declines too fast
# fitted(zp_mod, "mu")[1]
# fitted(zp_mod, "sigma")[1]
# fitted(zp_mod, "nu")[1]
# 
# points(0:6, dZAGA(0:6, mu=fitted(zp_mod, "mu")[1],
#                        sigma=fitted(zp_mod, "sigma")[1],
#                        nu=fitted(zp_mod, "nu")[1])*sum(npm_pc),
# 			 col=pal_col[3])

