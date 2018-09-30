#
# break-continue.R, 12 Jan 17
# Data from:
# The New C Standard: An Economic and Cultural Commentary
# Derek M. Jones
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C break


source("ESEUR_config.r")


library("gamlss")


pal_col=rainbow(2)


jumps=read.csv(paste0(ESEUR_dir, "regression/break-continue.csv.xz"), as.is=TRUE)

# plot(jumps$occur, jumps$breaks, log="y", col=pal_col[1],
#	xlim=c(0, 30),
#	xlab="Occurrences", ylab="Functions\n")
# points(jumps$occur, jumps$continues, col=pal_col[2])
# points(jumps$occur, jumps$returns, col=pal_col[3])

# legend(x="topright", legend=c("break", "continue", "return"), bty="n", fill=pal_col, cex=1.2)

j_brk=subset(jumps, !is.na(breaks))

# Need individual counts, given cumulative totals
breaks=rep(j_brk$occur, j_brk$breaks)

nbi_bmod=gamlss(breaks ~ 1, family=NBI)

# glm_mod=glm(breaks ~ 1, family=poisson)

# Scale the probability distribution by the maximum number of functions
plot(function(y) max(jumps$breaks, na.rm=TRUE)*
			dNBI(y, mu=exp(coef(nbi_bmod, what="mu")),
				sigma=exp(coef(nbi_bmod, what="sigma"))),
	from=0, to=30, n=30+1,
	log="y", col=pal_col[1],
	xlab="breaks", ylab="Function definitions\n")
points(jumps$occur, jumps$breaks, col=pal_col[2])

# j_con=subset(jumps, !is.na(continues))
# continues=rep(j_con$occur, j_con$continues)

# nbi_cmod=gamlss(continues ~ 1, family=NBI)
# summary(nbi_cmod)

# plot(function(y) max(jumps$continues, na.rm=TRUE)*
# 			dNBI(y, mu=exp(coef(nbi_cmod, what="mu")),
# 				sigma=exp(coef(nbi_cmod, what="sigma"))),
# 	from=0, to=30, n=30+1,
# 	log="y", col=pal_col[1],
# 	xlab="continues", ylab="Function definitions\n")
# points(jumps$occur, jumps$continues, col=pal_col[2])


