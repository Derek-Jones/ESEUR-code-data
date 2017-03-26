#
# maint-dev-ratio.R, 23 Mar 17
#
# Data from:
# An Investigation of the Factors Affecting the Lifecycle Costs of COTS-Based Systems
# Laurence Michael Dunn
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# Sample the systems and return mean maint/dev ratio
sys_samp_mean=function()
{
samp_ind=sample(num_data, size=num_sys, replace=TRUE)
sys_samp=dme[samp_ind, ]
t=maint_weight*sys_samp$maint.effort/sys_samp$dev.effort
# A ratio, so use harmonic mean
return(1/mean(1/t))
}

pal_col=rainbow(2)

dme=read.csv(paste0(ESEUR_dir,"economics/dev-maint-effort.csv.xz"), as.is=TRUE)


y=sort(dme$dev.effort/dme$maint.effort, decreasing=TRUE)

# Harmonic mean of single year maintenance, i.e., d/m
# 1/mean(1/(y*5))

# Maintenance over five years, 0.88 survival rate
num_data=nrow(dme)
num_sys=trunc(0.5+num_data/0.88^5)
yearly_death=trunc(0.5-diff(num_sys*0.88^(0:20)))
# All remaining systems are replaced in the last year
yearly_death=c(yearly_death, num_sys-sum(yearly_death))
# Assume maintenance happens for a year, then a termination
# decision is made
maint_total=(1:(length(yearly_death)))/5
maint_weight=rep(maint_total, times=yearly_death)
# maint_weight=rep(1, num_sys)

mean_rep=replicate(1000, sys_samp_mean())

# Harmonic mean
1/mean(1/mean_rep)


