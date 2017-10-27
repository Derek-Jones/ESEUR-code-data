#
# CSA20170500000.R, 25 Oct 17
# Data from:
# The Effort Distribution of Software Development Phases
# Yong Wang and Jing Zhang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(5)


CSA=read.csv(paste0(ESEUR_dir, "projects/CSA20170500000-data.csv.xz"), as.is=TRUE)

plot(density(CSA$Implement, from=0, to=1.0), col=pal_col[1],
	xaxs="i", yaxs="i",
	xlab="Effort (fraction of total)", ylab="Project density", main="")
lines(density(CSA$Optimize, from=0, to=1.0), col=pal_col[2])
lines(density(CSA$Define.Analyze, from=0, to=1.0), col=pal_col[3])
lines(density(CSA$Design, from=0, to=1.0), col=pal_col[4])
lines(density(CSA$Produce, from=0, to=1.0), col=pal_col[5])

legend(x="topright", legend=c("Implement", "Optimize", "Define/Analyze", "Design", "Produce"), bty="n", fill=pal_col, cex=1.2)

# 
# library("fitdistrplus")
# library("extraDistr")
# 
# # 
# # descdist(CSA$Design, discrete=FALSE, boot=1000)
# 
# # t=fitdist(CSA$Define.Analyze, distr="beta", start=list(shape1=0.2, shape2=10), method="mle")
# t=fitdist(CSA$Design, distr="gamma", start=list(shape=0.2, rate=10), method="mle")
# t=fitdist(CSA$Define.Analyze, distr="kumar", start=list(a=0.9, b=0.8), method="mle")
# #summary(t)
# 
# x_vals=seq(1/nrow(CSA), 1, by=1/nrow(CSA))
# tb=dkumar(x_vals, a=t$estimate[1], b=t$estimate[2])
# 
# lines(x_vals, tb, col="red")
# 
# 

