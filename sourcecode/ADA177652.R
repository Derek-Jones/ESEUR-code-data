#
# ADA177652.R, 26 Jun 18
# Data from:
# Application of halstead's timing model to predict the compilation time of ADA compilers
#  Dennis M. Miller
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG compiler source-code tokens halstead ADA


source("ESEUR_config.r")


comp=read.csv(paste0(ESEUR_dir, "sourcecode/ADA177652.csv.xz"), as.is=TRUE)

# Program,IO,n1,n2,CN2,CN1,VAX11/785-Unix,DGMV8000-AOS/VS,VAX11/780-VMS_ISL,VAX11/785-VMS_CSC

Unix=comp$VAX11.785.Unix
AOSVS=comp$DGMV8000.AOS.VS
ISL=comp$VAX11.780.VMS_ISL
CSC=comp$VAX11.785.VMS_CSC

plot( ~ log(IO)+log(n1)+log(n2)+log(CN1)+log(CN2)+log(Unix)+log(AOSVS)+log(ISL)+log(CSC), data=comp)

# SAS code appearing in the thesis, mapped to R here.
# Used for the Halstead related models that were fitted.
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

Unix_mod=glm(logtime1 ~ LOGNtot, data=comp)
# Unix_mod=nls(Unix ~ b*Ntotal^c, data=comp,
# 			start=list(b=1, c=0.5))
Unix_mod=glm(logtime1 ~ log(2+IO):(log(n1)+LOGNtot)+log(n1):LOGNtot, data=comp)
summary(Unix_mod)


