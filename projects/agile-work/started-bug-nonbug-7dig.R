#
# started-bug-nonbug-7dig.R, 22 Dec 15
#
# Data from:
#
# http://www.7digital.com feature data
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("zoo")

pal_col=rainbow(3)
plot_layout(2, 2)

p=read.csv(paste0(ESEUR_dir, "projects/agile-work/7digital2012.csv.xz"))

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
plot(red.vals, col=pal_col[1],
	xlim=c(0, 820), ylim=c(0, 7),
	xlab="Work Days since Apr 2009", ylab="")
points(blue.vals, col=pal_col[3])
lines(rollmean(blue.vals/red.vals, 40), col=pal_col[2])
}

all.bugs=sum.starts(p[grep(".*Bug$", p$Type), ]$Dev.Start)
all.bugs=all.bugs[-weekends]
non.bugs=sum.starts(p[-grep(".*Bug$", p$Type), ]$Dev.Start)
non.bugs=non.bugs[-weekends]


plot(all.bugs, col="red",
	xlim=c(0, 820), ylim=c(0, 7),
	xlab="Work Days since Apr 2009", ylab="New feature starts")
#plot(rollmean(all.bugs+non.bugs, 120), xlim=c(0, 820), ylim=c(0, 7),
#          xlab="Work Days", ylab="New feature starts")
plot.two.ratio(rollmean(all.bugs, 20), rollmean(non.bugs, 20))
plot.two.ratio(rollmean(all.bugs, 50), rollmean(non.bugs, 50))
plot.two.ratio(rollmean(all.bugs, 120), rollmean(non.bugs, 120))

