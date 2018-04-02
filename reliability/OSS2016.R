#
# OSS2016.R, 22 Feb 18
# Data from:
# The Impact of a Low Level of Agreement among Reviewers in a Code Review Process
# Toshiki Hirao and Akinori Ihara and Yuki Ueda and Passakorn Phannachitta and Ken-ichi Matsumoto
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")


OSS=read.csv(paste0(ESEUR_dir, "reliability/OSS2016.csv.xz"), as.is=TRUE)

OSS_vec=melt(OSS, id.vars=c("Program", "P"), variable.name="N", value.name="MA")
OSS_vec$N=as.integer(OSS_vec$N)-1
t=as.integer(unlist(strsplit(OSS_vec$MA, ":")))
OSS_vec$M=t[seq(1, length(t), by=2)]
OSS_vec$A=t[seq(2, length(t), by=2)]

Qt=subset(OSS_vec, Program == "Qt")
OpenStack=subset(OSS_vec, Program == "OpenStack")

plot(~ I(P/(P+N))+M+A, data=Qt, log="xy")
plot(~ I(P/(P+N))+I(M/(M+A)), data=Qt)

Qt_mod=glm(cbind(M, A) ~ P+N, data=Qt, family=binomial)
summary(Qt_mod)

OS_mod=glm(cbind(M, A) ~ P+N, data=OpenStack, family=binomial)
summary(OS_mod)


