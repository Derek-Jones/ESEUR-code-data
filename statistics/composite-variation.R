#
# composite-variation.R, 17 Jul 20
# Data from:
# Cost and Schedule Estimation Study Report
# Steve Condon and Myrna Regardie and Mike Stark and Sharon Waligora
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_schedule composite-data project_schedule


source("ESEUR_config.r")


library("compositions")


est=read.csv(paste0(ESEUR_dir, "projects/EstimationStudy.csv.xz"), as.is=TRUE)

est=subset(est, !is.na(Design_Phase))

percent_phase=rcomp(est, parts=c("Design_Phase", "Code_Phase", "Test_Phase"))
hours_phase=rplus(est, parts=c("Design_Phase", "Code_Phase", "Test_Phase"))

mean(percent_phase)
mean(hours_phase)


est$Test_Sched=est$Systest_Sched+est$Acctest_Sched

est=subset(est, !is.na(Design_Sched))
sched=rcomp(est, parts=c("Design_Sched", "Code_Sched", "Systest_Sched", "Acctest_Sched"))

# mean(sched)

variation(sched)
mvar(sched)


outlierplot(percent_phase)

# outliersInCompositions(percent_phase)
 
