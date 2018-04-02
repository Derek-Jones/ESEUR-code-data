#
# LANL-system-total-fail.R, 15 Oct 16
# Data from:
# Los Alamos National Lab (LANL)
# http://www.lanl.gov/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

plot_layout(5, 1)
par(mai=c(0.3, 0.7, 0.1, 0.4))


# System,machine type,nodes,procstot,procsinnode,nodenum,nodenumz,node install,node prod,node decom,fru type,mem,cputype,memtype,num intercon,purpose,Prob Started,Prob Fixed,Down Time,Facilities,Hardware,Human Error,Network,Undetermined,Software,Same Event
# 2,cluster,49,6152,80,0,0,5-Apr,5-Jun,current,part,80,1,1,0,graphics.fe,6/21/2005 10:54,6/21/2005 11:00,6,,Graphics Accel Hdwr,,,,,No


# Number of failures binned into 30 day intervals
total_failures=function(sys.num)
{
t=fail_rec[fail_rec$System == sys.num, ]
day_start=as.integer(min(t$Prob.Started))

t$fail_bin=(as.integer(t$Prob.Started)+1- day_start) %/% 30

return(t)
}

plot_sys.failures=function(sys.num)
{
sys.n=total_failures(sys.num)

plot(table(sys.n$fail_bin+1-min(sys.n$fail_bin)), col=point_col,
        xlab="", ylab="Failures\n")
legend(x="topright", legend=paste("system", sys.num), bty="n")

return(sys.n)
}


time_format="%m/%d/%Y %H:%M"

fail_rec=read.csv(paste0(ESEUR_dir, "reliability/LA-UR-05-7318-failure-data-1996-2005.csv.xz"), as.is=TRUE)

fail_rec$Prob.Started=as.Date(fail_rec$Prob.Started, format=time_format)

# System 2, 16, 18, 19, 20 each have an order of magnitude more
# failure records than the other systems.

sys.2=plot_sys.failures(2)
sys.16=plot_sys.failures(16)
sys.18=plot_sys.failures(18)
sys.19=plot_sys.failures(19)
sys.20=plot_sys.failures(20)

