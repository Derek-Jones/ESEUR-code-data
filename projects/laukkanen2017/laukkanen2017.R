#
# laukkanen2017.R, 26 Jan 19
# Data from:
# Towards Continuous Delivery by Reducing the Feature Freeze Period: {A} Case Study
# Eero Laukkanen and Maria Paasivaara and Juha Itkonen and Casper Lassenius and Teemu Arvonen
# Kindly provided by Laukkanen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG commercial project commits release

source("ESEUR_config.r")


library("bizdays")
library("plyr")


pal_col=rainbow(3)


# Get commits between the last delpoy and the next deploy, then
# add column giving days to next deploy.
days_to_deploy=function(ind, df)
{
dep_days=subset(df, (date >= lrel$production_deployment_date[ind-1]) &
			(date < lrel$production_deployment_date[ind]))
if (nrow(dep_days) == 0)
   return(NULL)

dep_days$days_to_dep=bizdays::bizdays(dep_days$date, lrel$production_deployment_date[ind], "UK")
# print(c(diff(range(dep_days$date)), range(dep_days$days_to_dep)))
dep_days$freeze_days=bizdays::bizdays(lrel$feature_freeze_date[ind], lrel$production_deployment_date[ind], "UK")
dep_days$before_freeze=(dep_days$date < lrel$feature_freeze_date[ind])

dep_days$norm_days_to_dep=dep_days$days_to_dep*100/max(dep_days$days_to_dep)
dep_days$norm_freeze_days=dep_days$freeze_days*100/max(dep_days$days_to_dep)

# After freeze date, only consider commits to freeze branch
deploy_coms=c(dep_days$m_freq[dep_days$before_freeze],
		dep_days$f_freq[!dep_days$before_freeze])

total_com=sum(deploy_coms)
dep_days$com_todo=total_com-cumsum(deploy_coms)
dep_days$norm_com_todo=100-cumsum(deploy_coms)*100/total_com

lines(dep_days$norm_days_to_dep[dep_days$before_freeze],
	dep_days$norm_com_todo[dep_days$before_freeze], col=pal_col[2])
lines(dep_days$norm_days_to_dep[!dep_days$before_freeze],
	dep_days$norm_com_todo[!dep_days$before_freeze], col=pal_col[1])

return(dep_days)
}


# Model commits per day
commits_per_day=function(df)
{
master_com=subset(df, branch == "master")
m_per_day=count(master_com$date)
m_per_day$m_freq=m_per_day$freq
m_per_day$freq=NULL
freeze_com=subset(df, branch == "freeze")
f_per_day=count(freeze_com$date)
f_per_day$f_freq=f_per_day$freq
f_per_day$freq=NULL

com_per_day=merge(m_per_day, f_per_day, all=TRUE)
com_per_day$m_freq[is.na(com_per_day$m_freq)]=0
com_per_day$f_freq[is.na(com_per_day$f_freq)]=0
com_per_day$date=com_per_day$x

return(com_per_day)
}


fit_com_mod=function(df)
{
com_per_day=commits_per_day(df)
plot(0, type="n",
	xlim=c(0,100), ylim=c(0, 100),
	xlab="Days to deploy (percentage)", ylab="Commits todo (percentage)\n")

all_rel=adply(2:nrow(lrel), 1, days_to_deploy, com_per_day)

# plot(all_rel$days_to_dep, all_rel$freq)

# lines(loess.smooth(all_rel$days_to_dep, all_rel$freq, span=0.3), col=loess_col)

com_mod=glm(com_todo ~ days_to_dep+freeze_days+before_freeze, data=all_rel)
return(com_mod)
}


# Model number of commits remaining before deployment
com_to_deploy=function(df)
{
com_per_day=commits_per_day(df)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0,100), ylim=c(0, 100),
	xlab="Days to deploy", ylab="Commits todo\n")

lines(c(0, 100), c(0, 100), col=pal_col[3])

all_rel=adply(2:nrow(lrel), 1, days_to_deploy, com_per_day)

# plot(all_rel$days_to_dep, all_rel$com_todo, type="l")

# lines(loess.smooth(all_rel$days_to_dep, all_rel$freq, span=0.3), col=loess_col)

com_mod=glm(norm_com_todo ~ norm_days_to_dep*before_freeze, data=all_rel)
return(com_mod)
}


lcom=read.csv(paste0(ESEUR_dir, "projects/laukkanen2017/commits.csv"), as.is=TRUE)
lcom$time=as.POSIXct(lcom$timestamp, format="%Y-%m-%d %H:%M:%S")
lcom$date=as.Date(lcom$timestamp, format="%Y-%m-%d")

lrel=read.csv(paste0(ESEUR_dir, "projects/laukkanen2017/releases.csv"), as.is=TRUE)
lrel$feature_freeze_date=as.Date(lrel$feature_freeze_date, format="%Y-%m-%d")
lrel$production_deployment_date=as.Date(lrel$production_deployment_date, format="%Y-%m-%d")

mean(lrel$production_deployment_date-lrel$feature_freeze_date)

table(lcom$referenced_issue, lcom$repository)

# acf(table(lcom$date), lag=100)
# pacf(table(lcom$date), lag=100)

bankhol=read.csv(paste0(ESEUR_dir, "economics/ukbankholidays.csv"), as.is=TRUE)
bankhol$UK.BANK.HOLIDAYS=as.Date(bankhol$UK.BANK.HOLIDAYS, format="%d-%b-%Y")

create.calendar("UK", bankhol$UK.BANK.HOLIDAYS, weekdays=c("saturday", "sunday"))

com_mod=fit_com_mod(lcom)
summary(com_mod)

dep_mod=com_to_deploy(lcom)
summary(dep_mod)


exist_proj=subset(lcom, repository == "NewFrontend")

com_mod=fit_com_mod(exist_proj)
summary(com_mod)

dep_mod=com_to_deploy(subset(lcom, repository != "NewFrontend"))
summary(dep_mod)

dep_mod=com_to_deploy(subset(lcom, repository == "NewFrontend"))
summary(dep_mod)

dep_mod=com_to_deploy(subset(lcom, repository == "OldFrontend"))
summary(dep_mod)

dep_mod=com_to_deploy(subset(lcom, repository == "Backend1"))
summary(dep_mod)

dep_mod=com_to_deploy(subset(lcom, repository == "Backend2"))
summary(dep_mod)



