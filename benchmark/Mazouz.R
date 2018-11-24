# 
# Mazouz.R,  7 Nov 18
#
# Data from:
# An Empirical Study of Program Performance of {OpenMP} Applications on Multicore Platforms
# Abdelhafid Mazouz
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark OpenMP multicore


source("ESEUR_config.r")


library("lattice")


bench=read.csv(paste0(ESEUR_dir, "benchmark/Mazouz.csv.xz"), as.is=TRUE)

art_m=subset(bench, program == "330.art_m")

t=bwplot(time ~ affinity | compiler+as.character(threads), data=art_m,
		layout=c(2, 3), col="yellow",
		panel=panel.violin,
                par.strip.text=list(cex=0.75),
		scales=list(x=list(rot=15), y=list(cex=0.8)),
		ylab="Seconds")

plot(t, panel.height=list(2.5, "cm"),
		panel.width=list(3.0, "cm"))

# library("lme4")
# t_mod=lmer(time ~ (threads+compiler+affinity)^2-compiler:affinity+(threads+compiler | program), data=bench)
# summary(t_mod)
# confint(t_mod)

