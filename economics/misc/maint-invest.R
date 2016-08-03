#
# main-invest.R, 17 Dec 15
#
# Data from:
# An Investigation of the Factors Affecting the Lifecycle Costs of COTS-Based Systems
# Laurence Michael Dunn
#   plus:
# Software Lifetime and its Evolution Process over Generations
# Tetsuo Tamai and Yohsuke Torimitsu
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


sur=function(c, y=6)
   return((1-c)/(c*(1-c^y)))

sur.int=seq(0.3, 0.95, by=0.05)

print.sur=function(y)
{
signif(c(y, sur(sur.int, y)), digits=3)
}

print.sur(1)
print.sur(3)
print.sur(5)


plot.cost.benefit=function(surviv, color, years)
{
cost.total=1+dm_ratio*sur(surviv, years)
lines(dm_ratio, cost.total, col=color)
}

# Plot various project lifespans for given survival rate
cost.benefit=function(surviv, color)
{
cost.total=1+dm_ratio*sur(surviv, 5.5)
lines(dm_ratio, cost.total, col=color)
plot.cost.benefit(surviv, color, 6)
plot.cost.benefit(surviv, color, 6.5)
plot.cost.benefit(surviv, color, 7)
plot.cost.benefit(surviv, color, 7.5)
}

years=1:10
dm_ratio=seq(1, 10, by=0.5)

# Plot various survival rates
cost.benefit(0.9, "black")
cost.benefit(0.8, "red")
cost.benefit(0.7, "blue")
cost.benefit(0.6, "green")


life=read.csv(paste0(ESEUR_dir, "economics/system-lifetime.csv.xz"), as.is=TRUE)

num_years=nrow(life)
t=cumsum(life$projects)
num_proj=max(t)
t=num_proj-t
plot(t, ylim=c(0,num_proj), col="red", xlab="Years", ylab="Systems still in Use")
x=1:num_years
#q=nls(t ~ a*exp(b*x), start=list(a=100, b=0.2))
q=nls(t ~ a*b^x, start=list(a=100, b=0.8))
summary(q)
points(predict(q))


cost.year=function(maint.actual, invest.cost=0.1, invest.saving=0.2)
{
return (c(maint.actual, (1-invest.saving)*(1+invest.cost)*maint.actual))
}



total.cost=function(dev.effort, maint.actual, cancel.rate=0.3, invest.cost=0.1, invest.saving=0.2)
{
cost.total=c(dev.effort, dev.effort*(1+invest.cost))

for (year in 1:5)
   if (cancel.rate > runif(1, 0, 1))
      return(cost.total)
   else
      cost.total=cost.total+cost.year(maint.actual/5, invest.cost, invest.saving)

return(cost.total)
}


library(fitdistrplus)

dme=read.csv(paste0(ESEUR_dir, "economics/dev-maint-effort.csv.xz"), as.is=TRUE)

#y=sort(dme$maint.effort, decreasing=TRUE)
#y=sort(dme$dev.effort, decreasing=TRUE)
y=sort(dme$dev.effort/dme$maint.effort, decreasing=TRUE)
x=1:length(y)
descdist(y, boot=100)

t=fitdist(y/(max(y)+1), distr="beta", start=list(shape1=0.2, shape2=10), method="mle")
summary(t)
tb=dbeta(seq(1/length(y), 1, by=1/length(y)), shape1=t$estimate[1], shape2=t$estimate[2])

# fitdist requires values in [0, 1] while dbeta can return values
# outside that range, so some scaling is required.  We could do
# lots of work and get it correct, choose the first element to align
# or do it by eye (10 looks good).
#norm=dbeta(1/length(y), shape1=t$estimate[1], shape2=t$estimate[2])
norm=10

plot(tb*max(y)/norm, ylim=c(0, 12),
       xlab="Sorted list of systems", ylab="Development/Maintenance")
points(y, col="red")

