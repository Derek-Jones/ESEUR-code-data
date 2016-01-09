# 
# Mazouz.R, 28 May 15
#
# Data from:
# An Empirical Study of Program Performance of {OpenMP} Applications on Multicore Platforms
# Abdelhafid Mazouz
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("lattice")


bench=read.csv(paste0(ESEUR_dir, "benchmark/Mazouz.csv.xz"), as.is=TRUE)

art_m=subset(bench, program == "330.art_m")

t=bwplot(affinity ~ time | as.character(threads)+compiler, data=art_m,
	layout=c(3, 2),
       panel=panel.violin, col="yellow",
               xlab="Seconds")

plot(t)

# library("lme4")
# t_mod=lmer(time ~ (threads+compiler+affinity)^2-compiler:affinity+(threads+compiler | program), data=bench)
# summary(t_mod)


