#
# composite-variation.R, 12 Sep 18
# Data from:
# Cost and Schedule Estimation Study Report
# Steve Condon and Myrna Regardie and Mike Stark and Sharon Waligora
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment estimation composite project schedule


source("ESEUR_config.r")


library("compositions")


est=read.csv(paste0(ESEUR_dir, "projects/EstimationStudy.csv.xz"), as.is=TRUE)

est=subset(est, !is.na(Design_Phase))

phase=acomp(est, parts=c("Design_Phase", "Code_Phase", "Test_Phase"))

# mean(phase)

est$Test_Sched=est$Systest_Sched+est$Acctest_Sched

est=subset(est, !is.na(Design_Sched))
sched=acomp(est, parts=c("Design_Sched", "Code_Sched", "Systest_Sched", "Acctest_Sched"))

# mean(sched)

print(variation(sched))

