#
# virt-random.R, 28 Jan 19
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark C++ compiler


source("ESEUR_config.r")


library("reshape2")


w_vr=read.csv(paste0(ESEUR_dir, "benchmark/time.txt.xz"), as.is=TRUE, sep="\t")

vr=melt(w_vr, id.vars=c("header", "compiler", "language", "empty_test"),
		value.name="time")

# unique(vr$compiler)
# [1] "VS15"  "VS17"  "clang"
# table(vr$compiler, vr$language)
#         c++03 c++11 c++14 c++17 c++20 c++98
#   clang  2451  5676 12384 12900 12513  2451
#   VS15   9417 12384 12384     0     0  2967
#   VS17   9417 12384 12384 12900 12255  2967

vr_amod=glm(time ~ header+compiler*language, data=vr)
summary(vr_amod)

vr_mod=glm(log(time) ~ header+compiler*language, data=vr)
summary(vr_mod)

# coef(vr_amod)/coef(vr_amod)[1]

# vr_emod=glm(empty_test ~ header+compiler+language, data=vr)
# summary(vr_emod)

# library("lme4")
# 
# Around a 20 min of cpu
# vr_rmod=lmer(log(time) ~ compiler*language+(1 | header), data=vr)
# summary(vr_rmod)


