#
# var_rw.R,  6 Sep 16
# Data from:
# Empirical Study of Opportunities for Bit-Level Specialization in Word-Based Programs
# Eylon Caspi
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("MASS")

pal_col=rainbow(4)

rw=read.csv(paste0(ESEUR_dir, "communicating/var_rw.csv.xz"), sep="\t", as.is=TRUE)

rw=subset(rw, bits != 0)

rw_8=subset(rw, bits == 8)
rw_16=subset(rw, bits == 16)
rw_32=subset(rw, bits == 32)
rw_33p=subset(rw, bits > 32)


plot(rw_32$read, rw_32$write, log="xy", col=pal_col[3],
	xlab="Reads", ylab="Writes\n")
points(rw_8$read, rw_8$write, col=pal_col[1])
points(rw_16$read, rw_16$write, col=pal_col[2])
points(rw_33p$read, rw_33p$write, col=pal_col[4])

legend(x="topleft", legend=c("8-bit", "16-bit", "32-bit", "Larger"), bty="n", fill=pal_col, cex=1.2)

k=5
den_col=rainbow(k)

d2_den=kde2d(log(rw_32$read+1e-5), log(rw_32$write+1e-5), n=50)
contour(exp(d2_den$x), exp(d2_den$y), d2_den$z, , nlevels=k, add=TRUE)

# dataEllipse silently gives up
# library("car")
# dataEllipse(rw_32$read, rw_32$write, log="xy", draw=FALSE)

