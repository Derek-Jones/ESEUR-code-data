#
# syspop16.R, 12 Jun 20
# Data from:
# A Study of Modern {Linux} {API} Usage and Compatibility: {What} to Support When You're Supporting
# Chia-Che Tsai and Bhushan Jain and Nafees Ahmed Abdul and Donald E. Porter
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG libc_usage ioctl_usage syscall_usage Ubuntu_usage pseudo-file_usage


source("ESEUR_config.r")


pal_col=rainbow(4)


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

sc=read.csv(paste0(ESEUR_dir, "ecosystems/syspop16-syscall.csv.xz"), as.is=TRUE)
lc=read.csv(paste0(ESEUR_dir, "ecosystems/syspop16-libc.csv.xz"), as.is=TRUE)
ioc=read.csv(paste0(ESEUR_dir, "ecosystems/syspop16-ioctl.csv.xz"), as.is=TRUE)
pse=read.csv(paste0(ESEUR_dir, "ecosystems/syspop16-pseudo.csv.xz"), as.is=TRUE)


plot(lc$unweighted.API.importance*100, log="xy", col=pal_col[1],
	yaxs="i",
	xlim=c(1, 1e3), ylim=c(1e-2, 101),
	xlab="Rank", ylab="Packages (percent)\n\n")
points(sc$unweighted.API.importance*100, col=pal_col[2])
points(pse$unweighted.API.importance*100, col=pal_col[3])
points(ioc$unweighted.API.importance*100, col=pal_col[4])

legend(x="bottomleft", legend=c("libc", "system calls", "pseudo", "ioctl"), bty="n", fill=pal_col, cex=1.2)

unq_lc=subset(lc, unweighted.API.importance > 0)
rank=1:nrow(unq_lc)

lc_mod=glm(log(unweighted.API.importance) ~ rank, data=unq_lc)
#summary(lc_mod)

pred=predict(lc_mod)
lines(exp(pred)*100, col="grey")

unq_ioc=subset(ioc, unweighted.API.importance > 0)
rank=1:nrow(unq_ioc)

ioc_mod=glm(log(unweighted.API.importance) ~ log(rank), data=unq_ioc)
#summary(ioc_mod)

pred=predict(ioc_mod)
lines(exp(pred)*100, col="grey")

