#
# ADA415138.R, 22 Aug 17
# Data from:
# Michael R. Garman
# The Generalizability of Private Sector Research on Software Project Management in Two {USAF} Organizations: {An} Exploratory Study
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("compositions")


proj=read.csv(paste0(ESEUR_dir, "projects/ADA415138.csv.xz"), as.is=TRUE)

plot(~ factor(Rank)+PM_SE_years+AF_years+Person_T+Person_B+Person_ME, data=proj)

table(proj$Rank, proj$Person_T)
table(proj$Rank, proj$Person_ME)
table(proj$Rank, proj$Munition_ME)
table(proj$Rank, proj$Account_ME)
table(proj$Developer, proj$Account_ME)
table(proj$New_Software.Legacy, proj$Account_ME)
table(proj$Lifecycle.Phase, proj$Account_ME)


pal_col=rainbow(3)
hcl_col=rainbow_hcl(3)


person=acomp(proj, parts=c("Person_T", "Person_B", "Person_ME"))

plot(person, col=point_col, labels="", mp=NULL)
ternaryAxis(side=-1:-3, at=seq(0.25, 0.75, 0.25), labels="",
                pos=c(0.5,0.5,0.5), col.axis=hcl_col, col.lab=pal_col,
                small=TRUE, aspanel=TRUE,
                Xlab="Design", Ylab="Code", Zlab="Test")


per_mod=lm(AF_years ~ ilr(person), data=proj)
summary(per_mod)

per_mod=lm(PM_SE_years ~ ilr(person), data=proj)
summary(per_mod)


