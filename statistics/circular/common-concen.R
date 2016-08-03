#
# common-mean.R,  6 Jun 16
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("circular")


plot_layout(1, 2)
pal_col=rainbow(3)

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commitbasicinformation.tsv.xz"), sep="\t", as.is=TRUE)

commits$is_introducing= (commits$is_introducing == "t")
commits$is_fixing= (commits$is_fixing == "t")

fault_commits=subset(commits, is_introducing)
basic_commits=subset(commits, !is_introducing)

week_fault=subset(fault_commits, week_day < 5)
week_basic=subset(basic_commits, week_day < 5)

# YgVal requires radians as input
F_circ=circular(week_fault$hour*2*pi/24)
B_circ=circular(week_basic$hour*2*pi/24)

# Code reworked from page 139 of Circular statistics in R
# Walraff Test for common concentration
WalraffTest = function(cdat, ndat)
{
g=length(ndat)
N = length(cdat)
ndatcsum = cumsum(ndat) 
tbar = circular(0)
distdat = 0
for (k in 1:g)
   {
   if (k==1)
      low = 0
   else
      low = ndatcsum[k-1]

   sample = cdat[(1:ndat[k])+low]
   tm1 = trigonometric.moment(sample, p=1)
   tbar[k] = tm1$mu

   dist = pi-abs(pi-abs(sample[1:ndat[k]]-tbar[k]))
   distdat = c(distdat, dist)
   }
distdat = distdat[-1]
gID = rep(1:g, times=ndat)
TestRes = kruskal.test(distdat, g=gID)
return(TestRes)
} 


comm_con=WalraffTest(c(F_circ, B_circ),
			c(length(F_circ), length(B_circ)))

comm_con

