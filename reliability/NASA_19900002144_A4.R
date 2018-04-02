#
# NASA_19900002144_A4.R, 23 Mar 18
# Data from:
# Experiments in Fault Tolerant Software Reliability",a
# David F. McAllister and Mladen A. Vouk
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")

pal_col=rainbow(3)


unexec=function(df, col_num)
{
points(df$tests, df$ex_percent, col=pal_col[col_num])

# un_mod=nls(ex_percent ~ a*l_tests^c/(1+b*l_tests^c), data=df,
#                 start=list(a=0.9, b=0.8, c=1))
un_mod=nls(ex_percent ~ a*(1-b*l_tests^c), data=df,
		start=list(a=0.9, b=0.8, c=-1.0))
# summary(un_mod)
# 
x_bounds=seq(5, 1000, by=5)

pred=predict(un_mod, newdata=data.frame(l_tests=log(x_bounds)))
lines(x_bounds, pred, col=pal_col[col_num])

return(un_mod)
}


A4=read.csv(paste0(ESEUR_dir, "reliability/NASA_19900002144_A4.csv.xz"), as.is=TRUE)

A4_L=melt(A4, id.vars=c("Data", "Program", "Blocks"),
			variable.name="BF", value.name="not_exec")
A4_L$BF=as.character(A4_L$BF)
A4_L$tests=as.integer(substring(A4_L$BF, 2))
A4_L$BF=substring(A4_L$BF, 1, 1)
A4_L$l_tests=log(A4_L$tests)

blocks=subset(A4_L, BF == "B")
blocks$un_percent=blocks$not_exec/blocks$Blocks
blocks$ex_percent=1-blocks$un_percent

plot(0, type="n", log="x",
	yaxs="i",
	xlim=c(5, 1000), ylim=c(0.2, 1),
	xlab="Tests", ylab="Executed blocks\n")

rI_mod=unexec(subset(blocks, Data == "RANDOM_I"), 1)
rII_mod=unexec(subset(blocks, Data == "RANDOM_II"), 2)
rE_mod=unexec(subset(blocks, Data == "ESV_I"), 3)

# 
# r1=subset(blocks, Data == "ESV_I")
# r1=subset(r1, Program != "UVAC")
# 
# un_mod=nls(ex_percent ~ a*l_tests^c/(1+b*l_tests^c), data=r1, trace=TRUE,
#               start=list(a=0.9, b=0.8, c=1))
# un_mod=nls(ex_percent ~ a*(1-b*l_tests^c), data=r1, trace=TRUE,
# 		start=list(a=0.9, b=0.8, c=-1.0))
# summary(un_mod)
# 
# x_bounds=seq(5, 1000, by=5)
# 
# pred=predict(un_mod, newdata=data.frame(l_tests=log(x_bounds)))
# lines(x_bounds, pred, col="blue")

