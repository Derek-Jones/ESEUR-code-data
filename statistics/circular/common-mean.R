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

# Code reworked from page 134 of Circular statistics in R
YgVal = function(cdat, ndat)
{
g=length(ndat)
N = length(cdat)
ndatcsum = cumsum(ndat) 
delhat = 0 ; tbar = 0
for (k in 1:g)
   {
   if (k==1)
      low = 0
   else
      low = ndatcsum[k-1]

   sample = cdat[(1:ndat[k])+low]
   tm1 = trigonometric.moment(sample, p=1)
   tm2 = trigonometric.moment(sample, p=2)
   Rbar1 = tm1$rho
   Rbar2 = tm2$rho
   tbar[k] = tm1$mu
   delhat[k] = (1-Rbar2)/(2*Rbar1*Rbar1)
   }
# The P procedure
if (max(delhat)/min(delhat) <= 4)
   {
   CP = sum(ndat[1:g]*cos(tbar[1:g]))
   SP = sum(ndat[1:g]*sin(tbar[1:g]))
   dhat0 = sum(ndat[1:g]*delhat[1:g]/N)
   RP = sqrt(CP*CP+SP*SP)
   Yg = 2*(N-RP)/dhat0
   }
else
# The M procedure
   {
   CM = sum((ndat[1:g]*cos(tbar[1:g])/delhat[1:g]))
   SM = sum((ndat[1:g]*sin(tbar[1:g])/delhat[1:g]))
   Yg = sum((ndat[1:g]/delhat[1:g]))
   RM = sqrt(CM*CM+SM*SM)
   Yg = 2*(Yg-RM)
   }
return(Yg)
}

comm_Yg=YgVal(c(F_circ, B_circ),
              c(length(F_circ), length(B_circ)))

pchisq(comm_Yg, 1, lower.tail=FALSE)

