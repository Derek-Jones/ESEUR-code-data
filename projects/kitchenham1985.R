#
# kitchenham1985.R, 28 Aug 17
# Data from:
# Software Project Development Cost Estimation
# Barbara A. Kitchenham and N. R. Taylor
# Cost Reporting Elements and Activity Cost Tradeoffs for Defense System Software (study results)
# C. A. Graver and W. M. Carriere and E. E. Balkovich and R. Thibodeau
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("compositions")

pal_col=rainbow(3)
hcl_col=rainbow_hcl(3)
pt_col=rainbow(4)


# Effort/Schedule is measured in months
eff=read.csv(paste0(ESEUR_dir, "projects/kitchenham1985.csv.xz"), as.is=TRUE)

ICL=subset(eff, Company == "ICL_VME")
BT=subset(eff, Company == "BT_SoftHse")

phase_ICL=acomp(ICL, parts=c("Design", "Code", "Test"))
phase_BT=acomp(BT, parts=c("Design", "Code", "Test"))

plot(phase_ICL, col=pt_col[1], labels="", mp=NULL)
plot(phase_BT, col=pt_col[2], labels="", mp=NULL, add=TRUE)
ternaryAxis(side=-1:-3, at=seq(0.25, 0.75, 0.25), labels="",
                pos=c(0.5,0.5,0.5), col.axis=hcl_col, col.lab=pal_col,
                small=TRUE, aspanel=TRUE,
                Xlab="Design", Ylab="Code", Zlab="Test")


# mean(phase_ICL)
# mean(phase_BT)

# Effort as percentage
eff=read.csv(paste0(ESEUR_dir, "projects/a053020.csv.xz"), as.is=TRUE)

project=subset(eff, Category == "Project")
author=subset(eff, Category == "Author")

phase_proj=acomp(project, parts=c("Anal_Des", "Coding", "Integ_Test"))
phase_aut=acomp(author, parts=c("Anal_Des", "Coding", "Integ_Test"))

plot(phase_proj, col=pt_col[3], labels="", mp=NULL, add=TRUE)
plot(phase_aut, col=pt_col[4], labels="", mp=NULL, add=TRUE)


# mean(phase_proj)
# mean(phase_aut)

