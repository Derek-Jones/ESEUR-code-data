#
# maint-dev-ratio.R, 19 Apr 17
#
# Data from:
# An Investigation of the Factors Affecting the Lifecycle Costs of COTS-Based Systems
# Laurence Michael Dunn
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG lifetime COTS maintenance


source("ESEUR_config.r")


# What percentage of maint/dev ratio is greater than 1
perc_gt_1=function()
{
samp_ind=sample(num_data, size=num_sys, replace=TRUE)
sys_samp=dme[samp_ind, ]
t=maint_weight*sys_samp$y_maint.effort/sys_samp$dev.effort
# A ratio, so use harmonic mean
t_len=length(t)
return(sapply(c(1, 2, 3, 4, 5, 6, 10),
		function(X) length(which(t > X))/t_len))
}

# Sample the systems and return mean maint/dev ratio
sys_samp_mean=function()
{
samp_ind=sample(num_data, size=num_sys, replace=TRUE)
sys_samp=dme[samp_ind, ]
t=maint_weight*sys_samp$y_maint.effort/sys_samp$dev.effort
# A ratio, so use harmonic mean
return(1/mean(1/t))
}

survival_rate=function(years)
{
# Values from fitted system survival data

# yr1_mod=glm(remaining ~ years, data=life, family=poisson)
# return(exp(-0.140833*years))

# yr2_mod=glm(remaining ~ years+I(years^2), data=life, family=poisson)
return(exp(-0.0852127*years-0.0025576*years^2))

# q=nls(remaining ~ a*b^years, data=life, start=list(a=100, b=0.8))
# return(0.8829^years)
}


pal_col=rainbow(2)

dme=read.csv(paste0(ESEUR_dir,"economics/dev-maint-effort.csv.xz"), as.is=TRUE)


y=sort(dme$dev.effort/dme$maint.effort, decreasing=TRUE)

# Harmonic mean of single year maintenance, i.e., d/m
# 1/mean(1/(y*5))

max_years=25
NPV_rate=1.05
# Maintenance over five years
y5_rate=(1-NPV_rate^6)/(1-NPV_rate)-1
# Assume fixed amount per year
dme$y_maint.effort=dme$maint.effort/y5_rate

num_data=nrow(dme)
num_sys=trunc(0.5+num_data/survival_rate(5))
yearly_death=trunc(0.5-diff(num_sys*survival_rate(0:(max_years-1))))
# All remaining systems are replaced in the last year
yearly_death=c(yearly_death, num_sys-sum(yearly_death))
# Assume maintenance happens for a year, then a yes/no termination
# decision is made

# Calculate Net Present Value, yearly discount of NPV_rate
maint_per_year=(1-NPV_rate^(2:(max_years+1)))/(1-NPV_rate)-1
maint_weight=rep(maint_per_year, times=yearly_death)

# maint_weight=rep(1, num_sys)

# mean_rep=replicate(1000, sys_samp_mean())
# Harmonic mean
# 1/mean(1/mean_rep)

gt_1=replicate(1000, perc_gt_1())

rowMeans(gt_1)


