#
# EstimationStudy.R, 23 Oct 17
# Data from:
# Cost and Schedule Estimation Study Report
# Steve Condon and Myrna Regardie and Mike Stark and Sharon Waligora
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("compositions")

pal_col=rainbow(3)
hcl_col=rainbow_hcl(3)
pt_col=rainbow(2)


est=read.csv(paste0(ESEUR_dir, "projects/EstimationStudy.csv.xz"), as.is=TRUE)

est=subset(est, !is.na(Design_Phase))

phase=acomp(est, parts=c("Design_Phase", "Code_Phase", "Test_Phase"))

plot(phase, col=pt_col[1], labels="", mp=NULL)
ternaryAxis(side=-1:-3, at=seq(0.25, 0.75, 0.25), labels="",
                pos=c(0.5,0.5,0.5), col.axis=hcl_col, col.lab=pal_col,
                small=TRUE, aspanel=TRUE,
                Xlab="Design", Ylab="Code", Zlab="Test")

# mean(phase)

est$Test_Sched=est$Systest_Sched+est$Acctest_Sched

est=subset(est, !is.na(Design_Sched))
sched=acomp(est, parts=c("Design_Sched", "Code_Sched", "Test_Sched"))

plot(sched, col=pt_col[2], labels="", mp=NULL, add=TRUE)

# mean(sched)

