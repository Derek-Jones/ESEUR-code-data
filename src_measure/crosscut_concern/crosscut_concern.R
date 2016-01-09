#
# crosscut_concern.R, 23 Jun 15
#
# Data from:
# Do Crosscutting Concerns Cause Defects?
# Marc Eaddy and Thomas Zimmermann and Kaitlin D.  Sherwood and Vibhav Garg and Gail C. Murphy and Nachiappan Nagappan and Alfred V. Aho
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("MASS")


mk_model=function(prog_data)
{
r1_mod=glm(Count ~ (CDC+CDO+DOSC+DOSM)^2, data=prog_data)
min_r1_mod=stepAIC(r1_mod)
print(summary(min_r1_mod))

r2_mod=glm(Count ~ SLOCC, data=prog_data)
print(summary(r2_mod))
}

rhino=read.csv(paste0(ESEUR_dir, "src_measure/crosscut_concern/Rhino_metrics.csv.xz"), as.is=TRUE)

pairs(~ CDC+ CDO+ DOSC+ DOSM+ SLOCC+Count, data=rhino)

mk_model(rhino)

# The following 'magic' start values result in convergence.
# Plugging in the fitted glm values sortof'ish almost got there.
rnl_mod=nls(Count ~ k+a*CDC+b*CDO+c*DOSC+d*exp(e*DOSM), data=rhino,
		start=list(k=1, a=1, b=1, c=5, d=-0.2, e=-6), trace=TRUE)
summary(rnl_mod)
AIC(rnl_mod)


mylyn=read.csv(paste0(ESEUR_dir, "src_measure/crosscut_concern/Mylyn_metrics.csv.xz"), as.is=TRUE)

pairs(~ CDC+ CDO+ DOSC+ DOSM+ SLOCC+Count, data=mylyn)

mk_model(mylyn)

iBATIS=read.csv(paste0(ESEUR_dir, "src_measure/crosscut_concern/iBATIS_metrics.csv.xz"), as.is=TRUE)

pairs(~ CDC+ CDO+ DOSC+ DOSM+ SLOCC+Count, data=iBATIS)

mk_model(iBATIS)


