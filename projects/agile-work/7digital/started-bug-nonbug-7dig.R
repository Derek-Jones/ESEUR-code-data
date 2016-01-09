#
# started-bug-nonbug-7dig.R, 30 Dec 15
#
# Data from:
# http://www.7digital.com feature data
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("zoo")

p=read.csv(paste0(ESEUR_dir, "projects/7digital2012.csv.xz"), as.is=TRUE)

# Count number of projects running on each day
base.date="21/04/2009"
base.day=as.integer(as.Date(base.date, "%d/%m/%Y"))
end.day=as.integer(as.Date("01/08/2012", "%d/%m/%Y"))-base.day
day.totals=rep(0, end.day)


sum.starts=function(date.list)
{
dl=rep(0, end.day)
t=table(as.integer(as.Date(date.list, format="%d/%m/%Y"))-base.day)
dl[as.integer(dimnames(t)[[1]])]=as.vector(t)

return(dl)
}


# Calculate weekend days so they can be removed from totals.
# base.day is a Tuesday, so first Saturday starts at day 4
weekends=c(seq(4, end.day ,by=7), # Saturday
           seq(5, end.day, by=7))


# Bug/Non-bug feature start ratio
plot.two.ratio=function(red.vals, blue.vals)
{
plot(red.vals, col="red",
	xlim=c(0, 820), ylim=c(0, 7),
          xlab="Work Days since Apr 2009", ylab="")
points(blue.vals, col="blue")
lines(rollmean(blue.vals/red.vals, 40))
}

all.bugs=sum.starts(p[grep(".*Bug$", p$Type), ]$Dev.Start)
all.bugs=all.bugs[-weekends]
non.bugs=sum.starts(p[-grep(".*Bug$", p$Type), ]$Dev.Start)
non.bugs=non.bugs[-weekends]

plot_layout(2, 2)
plot(all.bugs, col="red",
	xlim=c(0, 820), ylim=c(0, 7),
          xlab="Work Days since Apr 2009", ylab="New feature starts")

#plot(rollmean(all.bugs+non.bugs, 120), xlim=c(0, 820), ylim=c(0, 7),
#          xlab="Work Days", ylab="New feature starts")
plot.two.ratio(rollmean(all.bugs, 20), rollmean(non.bugs, 20))
plot.two.ratio(rollmean(all.bugs, 50), rollmean(non.bugs, 50))
plot.two.ratio(rollmean(all.bugs, 120), rollmean(non.bugs, 120))

