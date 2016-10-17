#
# LANL-node-total-fail.R, 15 Oct 16
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


# Number of failures by node number for a given system
total_node.failures=function(sys.num)
{
sys.n=fail.rec[fail.rec$System == sys.num, ]

plot(table(sys.n$nodenumz), col=point_col,
        xlab="", ylab="Failures\n")
legend(x="topright", legend=paste("system", sys.num), bty="n")

return(sys.n)
}


time.format="%m/%d/%Y %H:%M"
day.start=as.integer(as.Date("04/06/1996 00:01", format=time.format))

fail.rec=read.csv(paste0(ESEUR_dir, "reliability/LA-UR-05-7318-failure-data-1996-2005.csv.xz"), as.is=TRUE)

# System 2, 16, 18, 19, 20 each have an order of magnitude more
# failure records than the other systems.

sys.2=total_node.failures(2)
sys.16=total_node.failures(16)
sys.18=total_node.failures(18)
sys.19=total_node.failures(19)
sys.20=total_node.failures(20)

