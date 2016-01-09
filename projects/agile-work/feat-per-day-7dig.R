#
# feat-per-day-7dig.R, 14 Aug 12
#
# Various analysis of http://www.7digital.com feature data
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


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


# How many feature implementations are started on each day?
t=sum.starts(p$Dev.Started)
t=table(t[-weekends])
y=t/sum(t)


library("ascii")

res=rbind(dimnames(y)[[1]], signif(as.vector(y), digits=2))

print(ascii(res[ ,1:10]))

