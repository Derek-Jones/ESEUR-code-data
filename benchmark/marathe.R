#
# marathe.R,  9 Apr 20
# Data from:
# An empirical survey of performance and energy efficiency variation on {Intel} processors
# Aniruddha Marathe and Yijia Zhang and Grayson Blanks and Nirmal Kumbhare and Ghaleb Abdulla and Barry Rountree
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Intel_performance benchmark_performance power-performance

source("ESEUR_config.r")


library("vioplot")

pal_col=rainbow(2)


ep=read.csv(paste0(ESEUR_dir, "benchmark/marathe.csv.xz"), as.is=TRUE)

cur_par=par(no.readonly = TRUE) # save default, for resetting...

vp=layout(matrix(c(2, 0, 1, 3), 2, 2, byrow=TRUE),
                widths=c(3, 1), heights=c(1, 3), respect=TRUE)
layout.show(vp)

par(mar=c(4, 4, 0, 0))

plot(ep$fa65, ep$secs65, col=pal_col[1],
        xlab="Frequency", ylab="Seconds\n")

text(1.065, 305, "65 Watts", cex=1.2)

par(mar=c(0, 4, 0, 0))
vioplot(ep$fa65, horizontal=TRUE, axes=FALSE, xaxt="n", yaxt="n", col=pal_col[2])

par(mar=c(4, 0, 0, 0))
vioplot(ep$secs65, axes=FALSE, xaxt="n", yaxt="n", col=pal_col[2])

# plot(density(mg$fa95))

par(cur_par) # restore defaults


