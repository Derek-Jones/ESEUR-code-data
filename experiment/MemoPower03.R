#
# MemoPower03.R, 23 May 15
#
# Data from:
# "Look It up" or "Do the Math": An Energy, Area, and Timing Analysis of Instruction Resuse and Memoization
# Daniel Citron and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("MASS")

Memo=read.csv(paste0(ESEUR_dir, "experiment/MemoPower03.csv.xz"), as.is=TRUE)

Memo$size=as.factor(Memo$size)
Memo$associativity=as.factor(Memo$associativity)
Memo$mapping=as.factor(Memo$mapping)
Memo$replacement=as.factor(Memo$replacement)

Memo_mod2=glm(cint ~ (size+associativity+mapping)^2, data=Memo)
summary(Memo_mod2)


# What about a model with everything interactions?
Memo_mod3=glm(cint ~ (size+associativity+mapping)^3, data=Memo)

t=stepAIC(Memo_mod3)
summary(t)

