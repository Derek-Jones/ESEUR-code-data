#
# sloc_sd.R,  4 Oct 17
# Data from:
# The Effectiveness of Software Diversity
# Meine Jochum Peter {van der Meulen}
# CLEANROOM Software Development: {An} Empirical Evaluation
# Richard W. {Selby, Jr.} and Victor R. Basili and F. Terry Baker
# Development of {N}-Version Software Samples for an Experiment in Software Fault Tolerance
# L. Lauterbach
# Experiments in Fault Tolerant Software Reliability
# David F. McAllister and Mladen A. Vouk
# An Analysis of {Pascal} Programs in Compiler Writing
# Masaaki Shimasaki and Shigeru Fukaya and Katsuo Ikeda and Takeshi Kiyono
# Better Selection of Software Providers Through Trialsourcing
# Magne J{\o}rgensen
# Variability and Reproducibility in Software Engineering: A Study of Four Companies that Developed the Same System
# Bente C.D. Anda and Dag I.K. Sjøberg and Audris Mockus
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(8)


plot_dist=function(lines, col_num)
{
t=data.frame(m=mean(lines), s=sd(lines))
points(t$m, t$s, col=pal_col[col_num])

return(t)
}


n3=read.csv(paste0(ESEUR_dir, "probability/3np1.csv.xz"), as.is=TRUE)
li=n3$lines
li=li[li <= 120]

clean=read.csv(paste0(ESEUR_dir, "projects/CLEANROOM.csv.xz"), as.is=TRUE)

NASA_87=read.csv(paste0(ESEUR_dir, "projects/NASA_19870020663.csv.xz"), as.is=TRUE)
NASA_90=read.csv(paste0(ESEUR_dir, "projects/NASA_19900002144.csv.xz"), as.is=TRUE)

compiler=read.csv(paste0(ESEUR_dir, "projects/shimasaki1980.csv.xz"), as.is=TRUE)
jorg=read.csv(paste0(ESEUR_dir, "projects/Simula.2116.csv.xz"), as.is=TRUE)

anda=c(7937, 14549, 7208, 8293)

plot(1, type="n", log="xy",
	xlim=c(10, 1e4), ylim=c(10, 1e4),
	xlab="Mean LOC", ylab="Standard deviation\n")

# The defintion of a line of code is unlikely to be consistent
# accross the sample below.
# Some of the small samples have outliers that have a noticeable impact.
ms=plot_dist(li, 1)
ms=rbind(ms, plot_dist(clean$SLOC, 2))
ms=rbind(ms, plot_dist(NASA_87$LOC, 3))
ms=rbind(ms, plot_dist(NASA_90$LOC, 4))
ms=rbind(ms, plot_dist(c(compiler$C1[21], compiler$C2[21], compiler$C3[21],
		compiler$C4[21], compiler$C5[21]), 5))
ms=rbind(ms, plot_dist(jorg$LOC, 6))
ms=rbind(ms, plot_dist(anda, 7))


# Before I did this analysis my wet-finger in the air approximation was 10%,
# and 25% is a large variation...
ms_mod=glm(log(s) ~ log(m), data=ms)
# summary(ms_mod)

x_vals=seq(10, 10000, by=25)

pred=predict(ms_mod, newdata=data.frame(m=x_vals))
lines(x_vals, exp(pred), col="grey")


# plot_dist(NASA_87$Lines, 3)
# plot_dist(NASA_90$Lines, 4)

