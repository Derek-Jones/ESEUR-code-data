#
# ADA177652.R, 22 Nov 17
# Data from:
# Application of halstead's timing model to predict the compilation time of ADA compilers
#  Dennis M. Miller
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


comp=read.csv(paste0(ESEUR_dir, "src_measure/ADA177652.csv.xz"), as.is=TRUE)

# Program,IO,n1,n2,CN2,CN1,VAX11/785-Unix,DGMV8000-AOS/VS,VAX11/780-VMS_ISL,VAX11/785-VMS_CSC

Unix=comp$VAX11.785.Unix
AOSVS=comp$DGMV8000.AOS.VS
ISL=comp$VAX11.780.VMS_ISL
CSC=comp$VAX11.785.VMS_CSC

Ntotal = comp$CN1 + comp$CN2
Nhat = comp$nl*log(comp$n1) + comp$n2*log(comp$n2)
LOGNtot = log(Ntotal)
LOGNhat = log(Nhat)
VOL = Ntotal*log(2 + comp$n2)
Vstar = (2+comp$IO)*log(2 + comp$IO)
LOGVOL = log(VOL)
LOGVstar = log(Vstar)
VOLest = Nhat*log(comp$n1 + comp$n2)
Lhat = 2/comp$nl*comp$n2/comp$CN2
LOGVOLes = log(VOLest)
LOGLhat = log(Lhat)
logtime1 = log(Unix)
logtime2 = log(AOSVS)
logtime3 = log(ISL)
logtime4 = log(CSC)
Effort = VOL^2 / Vstar

Unix_mod=glm(logtime1 ~ Ntotal, data=comp)
Unix_mod=glm(logtime1 ~ (log(2+IO)+log(n1)+log(n2)+CN1 + CN2)^2, data=comp)
summary(Unix_mod)


