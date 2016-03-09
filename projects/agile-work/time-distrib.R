#
# time-distrib.R, 14 Feb 16
#
# 10 Dec 14 Fixed fault reported by Tom Clifford
# 27 Aug 12 Initial release 27 Aug 12

# Data from:
#
# http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# Load.Time and Cycle.Time were calculated as Done-Prioritised and
# Done-Dev.Started respectively.  Weekends were removed and dates
# corresponding to Saturday were moved to Friday and Sundays were moved
# to Monday.  Public holidays were subtracted to give working days.
# The  values of Prioritised, Dev.Started and Done have not
# been modified from their original values (i.e., some entries still
# denote Saturday/Sunday).

# The following is a mish mash of ideas that were tried out.
# See feat-*.R files for specific examples used in book.

source("ESEUR_config.r")

plot_layout(2, 1)

source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


Done_day=as.integer(p$Done)-base_day


# Fit a power law and draw it to an existing plot
plot_pow=function(y, x, line_color)
{
pow_equ=nls(y~ a*x^b, start=list(a=1200, b =-2))

y=predict(pow_equ, x)
lines(x, y, col=line_color)

# print(coef(pow_equ))

text(x[2]*2.5, y[2], paste("days ^ ", signif(as.numeric(coef(pow_equ)[2]), digits=3)))
}


# Plot sum of data values and fit various equations to parts of it
plot_pow_exp=function(day_info)
{
ct=table(day_info)
all_x=x=as.integer(dimnames(ct)[[1]])

plot(ct, xlim=c(1, 90), ylim=c(1, 1200), log="xy", type="p",
            xlab="Implementation duration (working days)", ylab="Features")

cv=as.vector(ct[1:16])
x=as.integer(dimnames(ct)[[1]][1:16])
plot_pow(cv, x, "red")

cv2=as.vector(ct[17:length(ct)])
x2=as.integer(dimnames(ct)[[1]][17:length(ct)])
plot_pow(cv2, x2, "blue")

# Build an exponential model
#expr_start=list(a=10000, b=-2.0, c=0.5)
#exp_mod=nls(as.vector(ct) ~ a*exp(b*all.x^c), start=expr_start, trace=TRUE)
#exp_mod=nls(as.vector(ct) ~ a*exp(b*all.x), start=expr_start)
#
#y=predict(exp_mod, all.x)
#lines(all.x, y, col="green")
#
#print(coef(exp_mod))
}

plot_pow_exp(p$Cycle.Time[Done_day >= 650])
plot_pow_exp(p$Cycle.Time[Done_day < 650])
plot_pow_exp(p$Lead.Time)

plot_pow_exp(p$Cycle.Time[p$Size == "Small"])
plot_pow_exp(p$Cycle.Time[p$Size == "Medium"])

plot_pow_exp(p$Cycle.Time[p$Size == "N/A"])

plot_pow_exp(p$Cycle.Time[p$Type == "MMF"])
plot_pow_exp(p$Cycle.Time[p$Type == "Production Bug"])


# Sum project counts over a month and plot them for each year
p$Month=as.integer(strftime(p$Dev.Started, "%m"))
p$Year=as.integer(substr(p$Done, start=7, stop=10))

ym=ddply(p, .(Year, Month), function(df) nrow(df))


month_cnt=function(year, col_str)
{
par(new=(year != 2009))
this_year=subset(ym, Year == year)
plot(this_year$Month, this_year$V1, type="l", col=col_str,
	xlim=c(1, 12), ylim=c(0, 210),
         xlab="Month", ylab="Number started")
}

month_cnt(2009, col="black")
month_cnt(2010, col="red")
month_cnt(2011, col="blue")
month_cnt(2012, col="green")



# Which of the 'common' distributions is a good fit?
library("fitdistrplus")

fit_equ=function(day_count)
{
#descdist(day_count, discrete=TRUE, boot=100)

fd=fitdist(day_count, "nbinom", method="mme")
print(summary(fd))
#print(gofstat(fd, print.test=TRUE))
# gofstat(fd, print.test=TRUE)$chisqtable
size.ct=fd$estimate[1]
mu.ct=fd$estimate[2]

# Calculate distribution parameters the approximate way
# mu.ct=desc.ct$mean
# size.ct=desc.ct$mean^2/(desc.ct$sd^2-desc.ct$mean)

plot(table(day_count), xlim=c(1, 90), ylim=c(1, 1200), log="xy", type="p",
            xlab="Elapsed working days", ylab="Features")

par(new=TRUE)
plot(dnbinom(1:93, size=size.ct,  mu=mu.ct)*length(day_count),
       xlim=c(1,90), ylim=c(1,1200), log="xy",
       xlab="", ylab="",
       type="l", col="black")
}


fit_quality=function(half_day_list)
{
fd=fitdist(half_day_list, "nbinom", method="mme")
return(c(loglikelihood=fd$loglik, AIC=fd$aic, BIC=fd$bic))
}


sub_divide=function(cycle_list)
{
cl=length(cycle_list)
dither=as.integer(runif(cl, 0, 1) > 0.33)
return(2*cycle_list-dither)
}


fit.quality(p$Cycle.Time[Done_day < 650])
rowMeans(replicate(1000, fit_quality(sub_divide(p$Cycle.Time[Done_day < 650]))))


fit_equ(p$Cycle.Time[Done.day < 650])
fit_equ(p$Cycle.Time[Done.day >= 650])

fit_equ(p$Lead.Time)

fit_equ(p$Cycle.Time[p$Size == "Small"])

fit_equ(p$Cycle.Time[p$Size == "N/A"])

fit_equ(p$Cycle.Time[p$Type == "MMF"])
fit_equ(p$Cycle.Time[p$Type == "Production Bug"])


# Fit a zero-truncated NB distribution, plus some other Poisson
# variant distributions.

library(gamlss)
library(gamlss.tr)

# We need to explicitly specify where the distribution is to be truncated
gen.trun(par=0, family=NBII)


# Fit a zero-truncated, type II, negative binomial distribution
fit.NBII=function(day.list)
{
g_NBIItr=gamlss(day.list ~ 1, family=NBIItr)

print(summary(g_NBIItr))

NBII_mu=exp(coef(g_NBIItr, "mu"))
NBII_sigma=exp(coef(g_NBIItr, "sigma"))

print(c(NBII_mu, NBII_sigma))

plot(table(day_list), xlim=c(1, 90), ylim=c(1, 1200), log="xy", type="p",
            xlab="Elapsed working days", ylab="Feature count")

par(new=TRUE)
plot(dNBIItr(1:93, mu=NBII_mu, sigma=NBII_sigma)*length(day_list),
       xlim=c(1,90), ylim=c(1,1200), log="xy",
       xlab="", ylab="",
       type="l", col="red")
return(c(AIC=as.numeric(AIC(g_NBIItr)),
         log_likelihood=as.numeric(logLik(g_NBIItr))))
}


qual_pre650=fit.NBII(p$Cycle.Time[Done_day <= 650])
qual_post650=fit.NBII(p$Cycle.Time[Done_day > 650])

fit_NBII(p$Cycle.Time[p$Type == "Production Bug"])
fit_NBII(p$Cycle.Time[p$Type == "MMF"])
fit_NBII(p$Cycle.Time[p$Size == "Small"])

d1=p$Cycle.Time[Done_day <= 650]
d2=p$Cycle.Time[Done_day >= 650]
g2_NBI=gamlss(d2 ~ 1, family=NBI)

gen.trun(par=0, family=DEL)
g2_DELtr=gamlss(d2 ~ 1, family=DELtr)
plot(table(d2), xlim=c(1, 90), ylim=c(1, 1200), log="xy", type="p",
            xlab="Elapsed working days", ylab="Features")

par(new=TRUE)
plot(dDELtr(1:93, mu=exp(coef(g2_DELtr, "mu")),
                sigma=exp(coef(g2_DELtr, "sigma")),
                 nu=inv.logit(coef(g2_DELtr, "nu")))*length(d2),
       xlim=c(1,90), ylim=c(1,1200), log="xy",
       xlab="", ylab="",
       type="l", col="red")




# For each day return the total number of work-days for each
# feature that has reached a Done 'state'
feature.work.increment=function(done.list)
{
done.num=as.integer(as.Date(done.list$Done, format="%d/%m/%Y"))-base.day
dl=rep(0, end.day)

sum.done=function(done.day)
   {
   dl[done.day] <<- dl[done.day]+sum(done.list$Cycle.Time[done.num == done.day])
   }

t=sapply(1:end.day, function(x) sum.done(x))

return(dl)
}


# Bug/Non-bug feature start ratio
plot.two.ratio=function(red.vals, blue.vals)
{
plot(red.vals, col="red",
	xlim=c(0, 820), ylim=c(0, 7),
	xlab="Work Days since Apr 2009", ylab="")
par(new=TRUE)
plot(blue.vals, col="blue",
	xlim=c(0, 820), ylim=c(0, 7),
	xlab="", ylab="")
par(new=TRUE)
plot(rollmean(blue.vals/red.vals, 40), xlim=c(0, 820), ylim=c(0, 7),
          type="l", xlab="", ylab="")
}


# MMF/Production bug ratio
t=sum.starts(p$Dev.Start[p$Type == "MMF"])
q=rollmean(t, 40)
plot(q, col="red",
	xlim=c(0, 1200), ylim=c(0, 4),
	xlab="Days", ylab="Occurrences")
r=sum.starts(p$Dev.Start[p$Type == "Production Bug"])
w=rollmean(r, 40)

par(new=TRUE)
plot(w, col="green",
	xlim=c(0, 1200), ylim=c(0, 4),
	xlab="", ylab="")

par(new=TRUE)
plot(rollmean(q/w, 20), xlim=c(0, 1200), ylim=c(0, 4),
          xlab="", ylab="")



# Some rolling mean plots

all.day.totals=sum.day.range(p$Dev.Started, p$Done)

weekday.totals=all.day.totals[-weekends]
hol.days=as.vector(get.ph.days())-base.day
hol.days=hol.days[hol.days > 0 & !is.na(hol.days)]
workday.totals=weekday.totals[-hol.days]

plot(all.day.totals, col="green",
	xlim=c(0, 1200), ylim=c(0, 50),
	xlab="Days", ylab="In-progress projects")

three.day.totals=sum.day.range(p$Dev.Started, p$Done, 3)
par(new=TRUE)
plot(three.day.totals, col="red",
	xlim=c(0, 1200), ylim=c(0, 50),
	xlab="Days", ylab="In-progress projects")

all.day.roll=rollmean(all.day.totals, 20)
plot(all.day.roll, col="green",
	xlim=c(0, 1200), ylim=c(0, 45),
	xlab="Days", ylab="In-progress projects (20 day rolling average)")

three.day.roll=rollmean(three.day.totals, 20)
par(new=TRUE)
plot(three.day.roll, col="red",
	xlim=c(0, 1200), ylim=c(0, 45),
	xlab="Days", ylab="In-progress projects (20 day rolling average)")



# Autocorrelation of in-progress features
day.totals=sum.day.range(p$Dev.Started, p$Done, 3)
weekday.totals=day.totals[-weekends]

day.totals=rollmean(day.totals, 3) # Just to tidy up the first two plots

hol.days=as.vector(get.ph.days())-base.day
hol.days=hol.days[hol.days > 0 & !is.na(hol.days)]
workday.totals=weekday.totals[-hol.days]

plot_layout(2, 2)
trend=glm(day.totals ~ time(day.totals))
plot(day.totals, xlab="Days since Apr 2009", ylab="Features in-progress")
abline(trend, col="pink")
most.day.totals=day.totals[250:length(day.totals)]
trend=glm(most.day.totals ~ time(most.day.totals))
# Adjust intercept because we fitted values offset by 250
abline(a=trend$coef[1]-trend$coef[2]*250, b=trend$coef[2], col="red")
day.detrend=most.day.totals-predict(trend)
as.Date(base.day)+250
plot(day.detrend, xlab="Days since Jan 2010", ylab="In-progress about mean")
w180.totals=workday.totals[-(1:180)] # remove first 180 days
trend=glm(w180.totals ~ time(w180.totals))
workday.detrend=w180.totals-predict(trend)
acf(day.detrend, lag.max=365, xlab="Lag in Days", main="")
acf(workday.detrend, lag.max=250, xlab="Lag in workdays", main="")

acf(workday.detrend[1:350], lag.max=250, xlab="Lag in workdays", main="")
acf(workday.detrend[-(1:350)], lag.max=250, xlab="Lag in workdays", main="")

pacf(workday.detrend, lag.max=250, xlab="Lag in workdays", main="")

lag.plot(workday.detrend, lag=9, diag=FALSE)


plot_layout(1, 1)
acf(day.totals, lag.max=365, xlab="Lag in Days", main="")
acf(day.totals, lag.max=365, type="p")
t=ts(day.totals, start=c(2009, 111), frequency=365)
plot(t, xlab="Year", ylab="In progress feature projects")

# Almost no difference in quality for the following two models
am=arima(workday.totals[150:837], order=c(1,1,1))
am
am=arima(workday.totals[150:837], order=c(2,1,2))
am
tsdiag(am)

acf(workday.totals, lag.max=250)

plot_layout(2, 1)
par(mai=c(1, 0.8, 0.0, 0.1))

# Plot cross-correlation between bugs and non-bugs
#all.bug.prio=sum.starts(p[p$Type == "Production Bug", ]$Done)
all.bug.prio=sum.starts(p[grep(".*Bug$", p$Type), ]$Prioritised)
all.bug.prio=all.bug.prio[-weekends]
all.bug.prio=rollmean(all.bug.prio, 3)
all.features=feature.work.increment(p)
all.features=all.features[-weekends]
all.features=rollmean(all.features, 3)
non.bug.done=feature.work.increment(p[-grep(".*Bug$", p$Type), ])
#non.bug.done=sum.starts(p[-grep(".*Bug$", p$Type), ]$Done)
#non.bug.done=sum.starts(p[p$Type == "MMF", ]$Done)
non.bug.done=non.bug.done[-weekends]
non.bug.done=rollmean(non.bug.done, 3)
# Many bugs reported at start will be caused by feature implementations
# that were Done before the start of recording.  Ignore the
# first 100 workdays so we are probably only checking for a correlation
# where one might exist
ccf(non.bug.done[-(1:100)], all.bug.prio[-(1:100)], lag.max=150,
        xlab="Work days (nonbug features)", ylab="Cross correlation",
        main="")
ccf(all.features[-(1:100)], all.bug.prio[-(1:100)], lag.max=150,
        xlab="Work days (all features)", ylab="Cross correlation",
        main="")


# Return vector of week information (i.e., sum of day information)
get.week.totals=function(day.list)
{
t=sapply(seq(1,end.day,by=7), function(x) sum(day.list[(0:6)+x]))
return(t[!is.na(t)])
}

day.totals=sum.starts(p$Done)
wt=get.week.totals(day.totals)
trend=lm(wt ~ time(wt))
detrend.wt=wt-predict(trend)
acf(detrend.wt, lag.max=52, xlab="Lag in weeks")
pacf(detrend.wt, lag.max=52, xlab="Lag in weeks")

all.bug.prio=sum.starts(p[grep(".*Bug$", p$Type), ]$Prioritised)
wt.all.bug.prio=get.week.totals(all.bug.prio)
non.bug.done=feature.work.increment(p[-grep(".*Bug$", p$Type), ])
wt.non.bug.done=get.week.totals(non.bug.done)
ccf(wt.non.bug.done[-(1:15)], wt.all.bug.prio[-(1:15)], lag.max=25,
        xlab="Weeks (nonbug features)", ylab="Cross correlation",
        main="")


# Look for relationship between decision to fix bugs and
# number of outstanding bugs.
# S_t = (C1 e^(-C2 B_t) + 1) B_c

# Calculate total number of bugs outstanding at time T
bug.out.totals=sum.day.range(prod.bug$Prioritised, prod.bug$Dev.Started)
bug.out.totals=bug.out.totals[-weekends]

# Calculate the number of work slots available at time T
prod.bug=p[p$Type == "Production Bug", ]
work.slots=rbind(prod.bug, p[p$Type == "MMF", ])
work.slots.avail=sum.starts(work.slots$Dev.Started)
work.slots.avail=work.slots.avail[-weekends]

# Calculate number of bug fix features started at time T
bug.fix.starts=sum.starts(prod.bug$Dev.Started)
bug.fix.starts=bug.fix.starts[-weekends]

mot.mod=nls(work.slots.avail ~ c1+bug.fix.starts*(c2*exp(-c3*bug.out.totals)+1),
              start=list(c1=1, c2=1, c3=0.1), trace=TRUE)

bot=8
x=0:10
y=1.153+ x*(1.12*exp(-0.167*bot)+1)
plot(x, y, col="red",
	xlab="Bug fix starts", ylab="Slots free", xlim=c(0, 10), ylim=c(0, 20))

bot.list=bug.out.totals == bot
par(new=TRUE)
plot(bug.fix.starts[bot.list], work.slots.avail[bot.list], col="blue",
           xlab="", ylab="",  xlim=c(0, 10), ylim=c(0, 20))

y=0:20
mot.glm=lm(bug.fix.starts ~ work.slots.avail + bug.out.totals)
x=-0.6+0.3*y+0.22*bot
par(new=TRUE)
plot(x, y, col="green",
           xlab="", ylab="",  xlim=c(0, 10), ylim=c(0, 20))


# How many feature implementations are started on each day?
t=sum.starts(p$Dev.Started)
t=table(t[-weekends])
y=t/sum(t)
print(signif(y, digits=2))

x=as.integer(dimnames(t)[[1]])
start.mod=nls(y ~ a*exp(-b*x), start=list(a=1, b=1), trace=TRUE)

plot(x, y, col="green",
	xlim=c(0, 16), ylim=c(0.002, 0.2), log="y",
	xlab="Days", ylab="Probability")

py=predict(start.mod, x)
par(new=TRUE)
plot(x, py, col="green",
	xlim=c(0, 16), ylim=c(0.002, 0.2), log="y", type="l",
	xlab="", ylab="")


