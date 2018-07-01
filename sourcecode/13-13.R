#
# 13-13.R, 29 Jun 18
# Data from:
# A {LLVM} Just-in-Time Compilation Cost Analysis
# Rafael Auler and Edson Borin
# Data kindly provided by Auler
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG LLVM compile SPEC optimization function basic-block instructions parameters


source("ESEUR_config.r")


pal_col=rainbow(2)


dad=read.csv(paste0(ESEUR_dir, "sourcecode/13-13.csv.xz"), as.is=TRUE)

# plot(dad$inscount, dad$O0, log="xy",
# 	xlab="Instructions", ylab="Cycles\n")
# 
# plot(dad$inscount, dad$O1, log="xy",
# 	xlab="Instructions", ylab="Cycles\n")

plot(dad$inscount, dad$O3, log="xy", col=pal_col[2],
	xlab="LLVM instructions", ylab="Compile time (secs)\n")

# Select one of the timing 'arms'
one_dad=subset(dad, (inscount >= 300) | (inscount < 300 & O3 <= 0.10))

# O3_mod=glm(log(O3) ~ log(inscount), data=one_dad)
# summary(O3_mod)

O3_mod=nls(O3 ~ a+b*inscount^c, data=one_dad, # trace=TRUE,
			start=list(a=0.01, b=1e-3, c=0.6))
# summary(O3_mod)

x_vals=exp(seq(1, 10, by=0.1))
pred=predict(O3_mod, newdata=data.frame(inscount=x_vals))

lines(x_vals, pred, col=pal_col[1])

