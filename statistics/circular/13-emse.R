#
# 13-emse.R, 16 Jul 16
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones


source("ESEUR_config.r")

library("circular")


plot_layout(2, 1)
pal_col=rainbow(3)

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commitbasicinformation.tsv.xz"), sep="\t", as.is=TRUE)

commits$is_introducing= (commits$is_introducing == "t")
commits$is_fixing= (commits$is_fixing == "t")

fault_commits=subset(commits, is_introducing)
basic_commits=subset(commits, !is_introducing)

week_fault=subset(fault_commits, week_day < 5)
week_basic=subset(basic_commits, week_day < 5)


# plot(table(fault_commit$hour))

plot_commits=function(df, repo_str, col_str)
{
HoW=circular(df$hour, units="hours", rotation="clock")
#plot(HoW, stack=TRUE, shrink=3, axes=FALSE, cex=0.01, col=col_str)
rose.diag(HoW, bins=24, shrink=1.1, prop=3, axes=FALSE, col=col_str)
axis.circular(at=circular(0:23, units="hours", rotation="clock"))

text(0.8, 1, repo_str, cex=1.4)

arrows.circular(mean(HoW), y=rho.circular(HoW), col=pal_col[2], lwd=3)
# print(c(mean(HoW)[[1]], rho.circular(HoW)))

lines(density(HoW, bw=30))

return(HoW)
}


F=plot_commits(week_fault, "Fault", pal_col[1])
B=plot_commits(week_basic, "non-Fault", pal_col[3])

# Two sample QQ plot from Circular statistics in R page 132-133
# Cleaned up a bit
TwoSampleQQ = function(cdat1, cdat2)
{
n1 = length(cdat1)
n2 = length(cdat2)
nmin = min(n1, n2)
nmax = max(n1, n2)
cdatref = cdat1
cdatoth = cdat2 
if (n2 < n1)
   {
   cdatref = cdat2
   cdatoth = cdat1
   }
zref = sin(0.5*(cdatref-median.circular(cdatref)))
szref = sort(zref)
zoth = sin(0.5*(cdatoth-median.circular(cdatoth)))
szoth = sort(zoth)

szothred = as.vector(szoth[1+nmax*((1:nmin)-0.5)/nmin])
szreffin = as.vector(szref[1:nmin])

plot(szreffin, szothred, col="red",
	xlim=c(-1, 1), ylim=c(-1, 1),
	xlab = "Smaller sample", ylab = "Larger sample")
xlim = c(-1, 1)
ylim = c(-1, 1)
lines(xlim, ylim, lty=2)
}

# F_t=circular(week_fault$hour*2*pi/24)
# nF_t=circular(week_basic$hour*2*pi/24)

# TwoSampleQQ(F_t, nF_t)


