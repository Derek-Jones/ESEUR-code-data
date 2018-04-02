#
# issta16.R,  3 Dec 17
# Data from:
# Toward Understanding Compiler Bugs in GCC and LLVM
# Chengnian Sun and Vu Le and Qirun Zhang and Zhendong Su
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("gnm")


pal_col=rainbow(3)


dupbug=read.csv(paste0(ESEUR_dir, "faults/issta16.csv.xz"), as.is=TRUE)

gcc=subset(dupbug, compiler == "gcc")
gcc=gcc[-7, ]
llvm=subset(dupbug, compiler == "llvm")
llvm=llvm[-7, ]

plot(gcc$duplicates, gcc$reported, log="y", col=point_col,
	xlab="Duplicates", ylab="Reported bugs\n")

gcc_mod=gnm(reported ~ instances(Mult(1, Exp(duplicates)), 2)-1,
                data=gcc, verbose=FALSE,
                start=c(22000.0, -1.6, 900.0, -0.1),
                family=poisson(link="identity"))
# summary(gcc_mod)
pred=predict(gcc_mod)
lines(gcc$duplicates, pred, col="green")

exp_coef=as.numeric(coef(gcc_mod))

lines(gcc$duplicates, exp_coef[1]*exp(exp_coef[2]*gcc$duplicates), col=pal_col[1])
lines(gcc$duplicates, exp_coef[3]*exp(exp_coef[4]*gcc$duplicates), col=pal_col[3])

pred=predict(gcc_mod)
lines(gcc$duplicates, pred, col=pal_col[2])


# 
# plot(llvm$duplicates, llvm$reported, log="y", col=point_col,
# 	xlab="Duplicates", ylab="Reported bugs\n")
# llvm_mod=gnm(reported ~ instances(Mult(1, Exp(duplicates)), 2)-1,
#                 data=llvm, verbose=FALSE,
#                 start=c(12000.0, -1.6, 300.0, -0.1),
#                 family=poisson(link="identity"))
# # summary(llvm_mod)
# pred=predict(llvm_mod)
# 
# 
# exp_coef=as.numeric(coef(llvm_mod))
# 
# lines(llvm$duplicates, exp_coef[1]*exp(exp_coef[2]*llvm$duplicates), col=pal_col[1])
# lines(llvm$duplicates, exp_coef[3]*exp(exp_coef[4]*llvm$duplicates), col=pal_col[3])
# 
# pred=predict(llvm_mod)
# lines(llvm$duplicates, pred, col=pal_col[2])
# 
