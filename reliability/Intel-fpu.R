#
# Intel-fpu.R, 25 Aug 20
# Data from:
# Intel overstates {FPU} accuracy
# Scott Duplichan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_floating-point cos_accuracy

source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

pal_col=rainbow(2)


fcos=read.csv(paste0(ESEUR_dir, "reliability/Intel-fpu.csv.xz"), as.is=TRUE)

plot(fcos$x, abs(fcos$ulp), log="y", pch=".", col=pal_col[1],
	xaxs="i", yaxt="n",
	ylim=c(1e-1, 1e6),
	xlab="x", ylab="cos(x) accuracy (ULP)\n\n")

axis(2, at=c(0.1, 10, 1000, 100000),
		label=c("0.1", "10", "1,000", "100,000"))

text(pi/2, 0.5, expression(frac(pi, 2)), col=pal_col[2])

# Filter original results to reduce size of data and pdf
#
# fcr=fc[seq(1, nrow(fc), by =13),]
# plot(fcr$x, abs(fcr$cos_x), log="y", pch=".")
# 
# t=signif(fcr$cos_x, 3)
# 
# fcr$cos_x=NULL
# fcr$ulp=t
# 
# write.csv(fcr, file="/usr1/rbook/fcos.csv", row.names=FALSE)
# 
