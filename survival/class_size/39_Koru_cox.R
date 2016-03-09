#
# 39_Koru_cox.R,  1 Mar 16
#
# Code to process data from:
# Theory of relative defect proneness: Replicated studies on the functional form of the size-defect relationship
# "A. G\"{u}ne\c{s} Koru and Khaled {El Emam} and Dongsong Zhang and Hongfang Liu and Divya Mathew
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("splines")
library("survival")


# k_files=list.files(paste0(ESEUR_dir, "survival/class_size"), pattern="k.*csv")

kw_data=read.csv(paste0(ESEUR_dir, "survival/class_size/kword.csv.xz"))


# fit = coxph(Surv(start,end,event) ~ ns(size, df=2) + cluster(id), data=kw_data)
fit = coxph(Surv(start,end,event) ~ log(size) + cluster(id), data=kw_data)
pred = predict(fit, type="terms", se.fit=TRUE)
size_ord=order(kw_data$size)
plot(kw_data$size[size_ord], pred$fit[size_ord], type="l",
        xlab = "LOC", ylab="Log Relative Risk")
lines(kw_data$size[size_ord], pred$fit[size_ord]+1.96*pred$se[size_ord])
lines(kw_data$size[size_ord], pred$fit[size_ord]-1.96*pred$se[size_ord])



#kw = coxph(Surv(start, end, event) ~ log(size)+state+cluster(id), data=kw_data)
kw = coxph(Surv(start, end, event) ~ log(size)+cluster(id), data=kw_data)
summary(kw)
cox.zph(kw)
skm=survfit(kw)

#kws = coxph(Surv(start, end, event) ~ log(size)+strata(state)+cluster(id), data=kw_data)
summary(kws)
cox.zph(kws)

skm=survfit(kws)
plot(skm, log="x")

# Paper used Design package which has been superceeded by rms package
library("rms")

d=datadist(kw_data)
options(datadist="d")
kw = cph(Surv(start, end, event) ~ size, data=kw_data, x=TRUE, y=TRUE)
summary(kw)
cox.zph(kw)
survplot(kw, size)

