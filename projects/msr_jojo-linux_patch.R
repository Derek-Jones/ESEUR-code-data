#
# msr_jojo-linux_patch.R, 21 Jan 19
# Data from:
# Yujuan Jiang and Bram Adams and Daniel M. German
# Will My Patch Make It? {And} How Fast? {Case} Study on the {Linux} Kernel
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Linux patch evolution

source("ESEUR_config.r")


library("foreign")
library("survival")


pal_col=rainbow(2)


lp=read.arff(paste0(ESEUR_dir, "projects/msr_jojo-linux_patch.arff.xz"))

accepted=subset(lp, accepted=="yes")

# length(which(accepted$review_time <= 0))
# [1] 41097
# length(which(accepted$integration_time <= 0))
# [1] 0

# plot(sort(accepted$review_time)/3600, type="l", log="y", col=pal_col[1],
# 	ylab="Hours")
# lines(sort(accepted$linus_time)/3600, col=pal_col[2])

rev=density(log(accepted$review_time/3600+1e-2), from=-4.61, to=8, adjust=0.5)
plot(exp(rev$x), rev$y, log="x", type="l", col=pal_col[1],
	xaxs="i", yaxs="i", xaxp=c(1e-2, 4, 1),
	ylim=c(0, 1.06),
	xlab="Submitted/Accepted interval (hours)", ylab="Patches accepted (density)\n")
linus=density(log(accepted$linus_time/3600+1e-2), adjust=0.5)
lines(exp(linus$x), linus$y, col=pal_col[2])

legend(x="topright", legend=c("Maintainers", "Linus Torvalds"), bty="n", fill=pal_col, cex=1.2)

