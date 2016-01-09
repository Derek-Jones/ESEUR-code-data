#
# coxph.R, 24 Jun 13
#
# Code to process data from:
# Theory of relative defect proneness: Replicated studies on the functional form of the size-defect relationship
# "A. G\"{u}ne\c{s} Koru and Khaled {El Emam} and Dongsong Zhang and Hongfang Liu and Divya Mathew
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("survival")


k_files=list.files(data_dir)
k_files=k_files[grep("k.*csv", k_files)]

kw_data=read.csv(paste0(ESEUR_dir, "survival/class_size/kword.csv.xz"))


fit <- coxph(Surv(start,end,event) ~ ns(size, df=4) + cluster(id), data=kw_data)
pred <- predict(fit, type="terms", se=TRUE)
hmat <- cbind(pred$fit[,1], pred$fit[,1]+2*pred$se[,1], pred$fit[,1]-2*pred$se[,1])
matplot(kw_data$size[order(kw_data$size)], hmat[order(kw_data$size),],
        xlab = "LOC", ylab="Log Relative Risk",
        col=c("BLACK","BLACK","BLACK"), lty=c(1,2,2), type="l")


#kw = coxph(Surv(start, end, event) ~ log(size)+state+cluster(id), data=kw_data)
kw = coxph(Surv(start, end, event) ~ log(size)+cluster(id), data=kw_data)
summary(kw)
cox.zph(kw)
skm=survfit(kw)

#kws = coxph(Surv(start, end, event) ~ log(size)+strata(state)+cluster(id), data=kw_data)
kws = coxph(Surv(start, end, event) ~ log(size)+state+cluster(id), data=kw_data)
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

# coxph/cph give a beta of 9.210e-04
# which disagree with Theory of relative defect proneness paper
# which gives a value of 0.74

