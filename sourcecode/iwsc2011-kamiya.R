#
# iwsc2011-kamiya.R, 21 Feb 20
# Data from:
# How Code Skips Over Revisions
# Toshihiro Kamiya
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C line_reuse


source("ESEUR_config.r")


library("plyr")


plot_layout(2, 1)
pal_col=rainbow(2)


added=read.csv(paste0(ESEUR_dir, "sourcecode/iwsc2011-kamiya.csv.xz"), as.is=TRUE)

reuse=subset(added, delta > 0)

x_bounds=1:100

delta_cnt=count(reuse$delta)
plot(delta_cnt, log="xy", col=pal_col[1],
	xlim=c(2, 100), ylim=c(10, 1e3),
	xlab="Revision difference", ylab="Occurrences\n")

dc_mod=glm(log(freq) ~ log(x)+I(log(x)^2), data=delta_cnt, subset=x_bounds)
# summary(dc_mod)

pred=predict(dc_mod)
lines(delta_cnt$x[x_bounds], exp(pred), col=pal_col[2])

add_cnt=count(reuse$added)
plot(add_cnt, log="xy", col=pal_col[1],
	xlim=c(1, 100), ylim=c(10, 1e5),
	xlab="Reused lines", ylab="Occurrences\n")

ac_mod=glm(log(freq) ~ log(x), data=add_cnt, subset=x_bounds)
summary(ac_mod)

pred=predict(ac_mod)
lines(add_cnt$x[x_bounds], exp(pred), col=pal_col[2])

# plot(jitter(reuse$delta, amount=0.1), jitter(reuse$added, amount=0.1), log="xy", col=point_col,
# 	xlim=c(1, 1e2), ylim=c(1, 1e2),
# 	xlab="Revision delta", ylab="Lines added\n")
# 
# plot(count(count(reuse$revision)$freq), type="p", log="xy", col=point_col,
# 	xlim=c(1, 80),
# 	xlab="Number of deltas", ylab="Occurrences\n")
# 
# reuse_100=subset(reuse, delta <= 100 && added <= 100)
# 
# smoothScatter(reuse_100$delta, reuse_100$added, log="xy", col=point_col,
# 	xlim=c(2, 100), ylim=c(1, 25),
# 	xlab="Revision delta", ylab="Lines reused\n")
# 
 
