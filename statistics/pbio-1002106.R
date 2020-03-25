#
# pbio-1002106.R, 11 Mar 20
# Data from:
# The Extent and Consequences of P-Hacking in Science
# Megan L. Head and Luke Holman and Rob Lanfear and Andrew T. Kahn and Michael D. Jennions
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG p-value_published p-hacking

source("ESEUR_config.r")


library("plyr")
library("segmented")


pal_col=rainbow(2)


# A subset of the data made available on website
pb=read.csv(paste0(ESEUR_dir, "statistics/pbio-1002106.csv.xz"), as.is=TRUE)


# Include only exact p values
pb=subset(pb, (operator == "="))

pb=subset(pb, decimal.places > 2)

# Need to expand the p-value and freq, round, and then count
p_cnt=count(round(rep(pb$p.value, times=pb$freq), digits=3))
p_cnt=subset(p_cnt, x > 0)

p_lcnt=log(p_cnt)

# plot(p_cnt, log="xy")
plot(p_lcnt, col=pal_col[2],
	xaxt="n", yaxt="n",
	xlab="p-value", ylab="Papers\n")

x_range=log(c(1e-3, 0.01, 0.05, 0.1, 0.5, 1))
axis(1, at=x_range, labels=signif(exp(x_range), digits=2))
y_range=log(c(100, 1e3, 1e4, 1e5))
axis(2, at=y_range, labels=signif(exp(y_range), digits=2))

p_mod=glm(freq ~ x, data=p_lcnt)

# npsi of 4 seems to work best
seg_mod=segmented(p_mod, npsi=4, it.max=100)

plot(seg_mod, add=TRUE, col=pal_col[1])


