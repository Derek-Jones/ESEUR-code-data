#
# var_rw.R, 29 May 18
# Data from:
# Empirical Study of Opportunities for Bit-Level Specialization in Word-Based Programs
# Eylon Caspi
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAGS variable runtime


source("ESEUR_config.r")


library("MASS")


pal_col=rainbow(4)

rw=read.csv(paste0(ESEUR_dir, "sourcecode/var_rw.csv.xz"), sep="\t", as.is=TRUE)

rw=subset(rw, bits != 0)

rw_8=subset(rw, bits == 8)
rw_16=subset(rw, bits == 16)
rw_32=subset(rw, bits == 32)
rw_33p=subset(rw, bits > 32)


plot(rw_32$reads, rw_32$writes, log="xy", col=pal_col[3],
	xlab="Reads", ylab="Writes\n")
points(rw_8$reads, rw_8$writes, col=pal_col[1])
points(rw_16$reads, rw_16$writes, col=pal_col[2])
points(rw_33p$reads, rw_33p$writes, col=pal_col[4])

legend(x="topleft", legend=c("8-bit", "16-bit", "32-bit", "Larger"), bty="n", fill=pal_col, cex=1.2)

k=5
den_col=rainbow(k)

d2_den=kde2d(log(rw_32$reads+1e-5), log(rw_32$writes+1e-5), n=50)
contour(exp(d2_den$x), exp(d2_den$y), d2_den$z, , nlevels=k, add=TRUE)

lines(c(1, 1e9), c(1, 1e9), col="grey")

# r_ord=order(rw_32$reads)
# 
# rw32_mod=nls(writes ~ b*reads^c+d*I(reads^2)^e, data=rw_32,
# 			start=list(b=1, c=1))
# summary(rw32_mod)
# pred=predict(rw32_mod)
# lines(rw_32$reads[r_ord], pred[r_ord], col="pink")
# 
# # No difference!
# rw32_mod=glm(log(writes+1e-5) ~ log(reads+1e-5)+I(log(reads^2+1e-5)), data=rw_32)
# rw32_mod=glm(log(writes+1e-5) ~ log(reads+1e-5)+I(log(reads^0.5+1e-5)), data=rw_32)
# summary(rw32_mod)
# pred=predict(rw32_mod)
# lines(rw_32$reads[r_ord], exp(pred[r_ord]), col="green")
# 
# loess_mod=loess(log(writes+1e-3) ~ log(reads+1e-3), data=rw_32, span=0.3)
# loess_pred=predict(loess_mod)
# lines(rw_32$reads[r_ord], exp(loess_pred[r_ord]), col=loess_col)
# 
# rw16_mod=nls(writes ~ b*reads^c, data=rw_16,
# 			start=list(b=1, c=1))
# summary(rw16_mod)
# 

