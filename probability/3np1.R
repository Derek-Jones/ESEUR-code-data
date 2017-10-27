#
# 3np1.R,  6 Jan 16
#
# Data from:
# The Effectiveness of Software Diversity
# Meine Jochum Peter {van der Meulen}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(fitdistrplus)


pal_col=rainbow(4)

n3=read.csv(paste0(ESEUR_dir, "probability/3np1.csv.xz"), as.is=TRUE)

# Remove outliers
li=n3$lines
li=li[li <= 120]

# plot(n3$lines)
# plot(n3$lines, log="y")
# plot(table(n3$lines))

# t=table(n3$lines)
# q=t[t > 1]
# plot(q)
# length(q)
# length(t)

# plot(q, ylim=c(0, 200))
# plot(rollmean(q, 2), ylim=c(0, 30))
# plot(rollmean(q, 3), ylim=c(0, 25))
# plot(rollmean(q, 4), ylim=c(0, 25))
# plot(rollmean(q, 5), ylim=c(0, 25))
# plot(rollmean(q, 10), ylim=c(0, 25))


# The first two suggested by the question and the last two from
# the Cullen and Frey plot
tp=fitdist(li, distr="pois")
tn=fitdist(li, distr="norm")
tln=fitdist(li, distr="lnorm")
tnb=fitdist(li, distr="nbinom")

# summary(tp)
# summary(tn)
# summary(tln)
# summary(tnb)

# gofstat is a simple 'universal' way of getting the values used for plotting
# Distribution order chosen to get the desired colors.
theo_vals=gofstat(list(tn, tp, tln, tnb),
	chisqbreaks=1:120,
	fitnames=c("Normal", "Poisson", "Lognormal", "Negative binomial"))

plot_distrib=function(dist_num)
{
lines(theo_vals$chisqbreaks, head(theo_vals$chisqtable[, 1+dist_num], -1), col=pal_col[dist_num])
}

plot(theo_vals$chisqbreaks, head(theo_vals$chisqtable[, 1], -1), type="h",
	ylim=c(0, 300),
	xlab="Program length", ylab="Number of programs\n")
plot_distrib(1)
plot_distrib(2)
plot_distrib(3)
plot_distrib(4)

legend(x="topright", legend=c("Normal", "Poisson", "Lognormal", "Negative binomial"),
			bty="n", fill=pal_col, cex=1.2)


