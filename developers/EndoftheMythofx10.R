#
# EndoftheMythofx10.R,  8 Oct 20
# Data from:
# The end to the myth of {"}{Individual} {Programmer} {Productivity}{"}
# William Nichols
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG PSP_course PSP_performance developer_performance

source("ESEUR_config.r")


library("lme4")
library("plyr")
library("vioplot")


sad=read.csv(paste0(ESEUR_dir, "developers/EndoftheMythofx10.csv.xz"), as.is=TRUE)
sad$ProgExp=as.numeric(sad$YearsProgrammingExperience)

cad=subset(sad, (ProgrammingLanguage == "C") & (ActMin > 0))

# plot(cad$EstMin, cad$ActMin, log="xy")
# # EA_mod=glm(log(ActMin) ~ log(EstMin)+I(PSPLevel^0.5)+as.factor(ProgramAssignment),
# # 				subset=(ActMin>0) & (EstMin>0), data=cad)
# EA_mod=lmer(log(ActMin) ~ log(EstMin)+I(PSPLevel^0.5)+as.factor(ProgramAssignment)+(1|PSPStuDataID),
# 				subset=(ActMin>0) & (EstMin>0), data=cad)
# summary(EA_mod)


# # psp_mod=glm(ActMin ~ PSPLevel+as.factor(ProgramAssignment)+ProgExp,
# #				subset=(ActMin>0), data=cad)
# psp_mod=lmer(ActMin ~ PSPLevel+as.factor(ProgramAssignment)+ProgExp+(1|PSPStuDataID),
# 				subset=(ActMin>0), data=cad)
# summary(psp_mod)


mean_act=ddply(cad, .(PSPStuDataID), function(df) mean(df$ActMin))

u_sid=mean_act$PSPStuDataID[order(mean_act$V1)]
mean_act$SID=mapvalues(mean_act$PSPStuDataID, u_sid, 1:length(u_sid))
cad$SID=mapvalues(cad$PSPStuDataID, u_sid, 1:length(u_sid))

# plot(as.factor(cad$SID), cad$ActMin, log="y")
# 
# 
# plot(1, type="n", log="y",
# 	xlim=c(1, length(u_sid), ylim=c(20, 2000),
# 	xlab="Subject", ylab="Actual time")
# 
# d_ply(cad, .(ProgramAssignment), function(df) points(df$SID, df$ActMin))
# 

brew_col=rainbow(20)
# brew_col=rainbow(length(u_sid))

vioplot(ActMin ~ SID, data=cad,
        # horizontal=TRUE, cex.axis=1.0, cex=1, # cex needed for cex.axis to work
        col=brew_col, border=brew_col, colMed=NA, lineCol=NA,
        # line=FALSE,
        # plotCenter="line",
        xaxt="n", xaxs="i", ylog=TRUE,
        xlab="Subject", ylab="Actual time (minutes)\n")

mean_act=mean_act[order(mean_act$SID), ]
lines(mean_act$SID, mean_act$V1, col="white")


# StatsCourse,did student take a statistics course,True/False,PSPClassID
# ProgrammingLanguage,Programming language used in the course,Class_Size
# YearsProgrammingExperience,Years of students experience programming,Complete
# PSPAssgtDataID,Unique ID for each assignment,Country
# PSPStuDataID,Unique ID for each student,Product Domain
# PSPLevel,PSP training level,"0,1,2",ClassDate
# ProgramAssignment,program,1-10
# EstLOC,estimated program size,LOC
# ActLOC,actual program size,LOC
# EstMin,estimated program effort,minutes
# ActMin,actual program effort,minutes
# EstDefRem,estimated defects,minutes
# ActDefRem,actual defects,minutes
# EstMinPlan,estimated effort in plan,minutes
# ActMinPlan,actual effort in plan,minutes
# EstMinDsgn,estimated effort in design,minutes
# ActMinDsgn,actual effort in design,minutes
# EstMinDLDR,estimated effort in detailed design review,minutes
# ActMinDLDR,actual effort in detailed design review,minutes
# EstMinCode,estimated effort coding,minutes
# ActMinCode,actual effort coding,minutes
# EstMinCR,estimated effort code review,minutes
# ActMinCR,actual effort code review,minutes
# EstMinCompile,estimated effort in compile,minutes
# ActMinCompile,actual effort in compile,minutes
# EstMinTest,estimated effort in test,minutes
# ActMinTest,actual effort in test,minutes
# EstMinPM,estimated effort in post mortem,minutes
# ActMinPM,actual effort in postmortem,minutes
# EstDefInjPlan,estimated defects injected in Plan,defect count
# EstDefInjDsgn,estimated defects injected in Design,defect count
# EstDefInjDLDR,estimated defects injected in Design Review,defect count
# EstDefInjCode,estimated defects injected in Code,defect count
# EstDefInjCR,estimated defects injected in Code Review,defect count
# EstDefInjCompile,estimated defects injected in compile,defect count
# EstDefInjTest,estimated defects injected in test,defect count
# EstDefRemPlan,estimated defects removed in Plan,defect count
# EstDefRemDsgn,estimated defects removed in Design,defect count
# EstDefRemDLDR,estimated defects removed in Design Review,defect count
# EstDefRemCode,estimated defects removed in Code,defect count
# EstDefRemCR,estimated defects removed in Code Review,defect count
# EstDefRemCompile,estimated defects removed in compile,defect count
# EstDefRemTest,estimated defects removed in test,defect count
# ActDefInjPlan,actual defects injected in Plan,defect count
# ActDefInjDsgn,actual defects injected in Design,defect count
# ActDefInjDLDR,actual defects injected in Design Review,defect count
# ActDefInjCode,actual defects injected in Code,defect count
# ActDefInjCR,actual defects injected in Code Review,defect count
# ActDefInjCompile,actual defects injected in compile,defect count
# ActDefInjTest,actual defects injected in test,defect count
# ActDefRemPlan,actual defects removed in Plan,defect count
# ActDefRemDsgn,actual defects removed in Design,defect count
# ActDefRemDLDR,actual defects removed in Design Review,defect count
# ActDefRemCode,actual defects removed in Code,defect count
# ActDefRemCR,actual defects removed in Code Review,defect count
# ActDefRemCompile,actual defects removed in compile,defect count
# ActDefRemTest,actual defects removed in test,defect count
# 
