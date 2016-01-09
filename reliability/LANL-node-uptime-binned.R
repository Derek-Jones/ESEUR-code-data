#
# LANL-node-uptime-binned.R,  8 Jan 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("fitdistrplus")
library("plyr")

plot_layout(2, 1)

# System,machine type,nodes,procstot,procsinnode,nodenum,nodenumz,node install,node prod,node decom,fru type,mem,cputype,memtype,num intercon,purpose,Prob Started,Prob Fixed,Down Time,Facilities,Hardware,Human Error,Network,Undetermined,Software,Same Event
# 2,cluster,49,6152,80,0,0,5-Apr,5-Jun,current,part,80,1,1,0,graphics.fe,6/21/2005 10:54,6/21/2005 11:00,6,,Graphics Accel Hdwr,,,,,No


# Get uptime in seconds by subtracting time Fixed from
# time the next problem Started.
get_node_uptimes=function(nodes)
{
# Make sure dates are ordered
t.order=order(as.numeric(strptime(nodes$Prob.Started, format=time.format)))
t=nodes[t.order, ]

uptime=as.numeric(strptime(t$Prob.Started[-1], format=time.format))-
       as.numeric(strptime(t$Prob.Fixed[1:(nrow(t)-1)], format=time.format))
#print(uptime[1:nrow(t)])
t=t[-1, ]
t$Uptime=uptime

return(t)
}


# Extract failure reports for each node, process them and
# build into a dataframe
get_system_uptimes=function(sys.num)
{
t=fail.rec[fail.rec$System == sys.num, ]

uptimes=ddply(t, "nodenumz", function(df) get_node_uptimes(df))

return(uptimes)
}


profile.sys=function(sys.num)
{
sys.n=get_system_uptimes(sys.num)

sys.n=sys.n[sys.n$Uptime > 0, ]

return(sys.n)
}


plot.data=function(sys.body, sys.num)
{
# Convert to hours
ct=sys.body$Uptime[sys.body$Uptime >= 0] %/% 3600
# Round to 10 hour intervals
ct=ct %/% 10
c=table(ct)

# add 0.1 to stop plot complaining about zero values
plot(as.vector(c)+0.1, col=point_col,
     xlim=c(1,1000), ylim=c(1,max(c)), log="xy",
     xlab="", ylab="Occurrences\n")
legend(x="topright", legend=paste("system", sys.num), bty="n", cex=1.3)

}


fit.data=function(sys.body, distr.str, col.str)
{
# Convert to hours
ct=sys.body$Uptime[sys.body$Uptime >= 0] %/% 3600
# Round to 10 hour intervals
ct=ct %/% 10
c=table(ct)

#descdist(ct, discrete=TRUE)

fd=fitdist(ct, distr=distr.str, method="mle")
#print(summary(fd))

if (distr.str == "nbinom")
   {
   size.ct=fd$estimate[1]
   mu.ct=fd$estimate[2]
   distr.vals=dnbinom(1:1000, size=size.ct,  mu=mu.ct)*length(ct)
   }
else
   {
   rate.ct=fd$estimate[1]
   distr.vals=dexp(1:1000, rate=rate.ct)*length(ct)
   }

lines(distr.vals, col=col.str)
}


time.format="%m/%d/%Y %H:%M"
day.start=as.integer(as.Date("04/06/1996 00:01", format=time.format))


fail.rec=read.csv(paste0(ESEUR_dir, "reliability/LA-UR-05-7318-failure-data-1996-2005.csv.xz"), as.is=TRUE)

# How many failure records for each system?
# table(fail.rec$System)


plot_and_fit=function(sys.body, sys.num)
{
plot.data(sys.body, sys.num)
fit.data(sys.body, "nbinom", "red")
#fit.data(sys.body, "exp", "blue")
#fit.data(sys.body, "pois", "blue")
}

# System 2, 16, 18, 19, 20 each have an order of magnitude more
# failure records than the other systems.
sys.2=profile.sys(2)
#sys.16=profile.sys(16)
sys.18=profile.sys(18)
#sys.19=profile.sys(19)
#sys.20=profile.sys(20)


plot_and_fit(sys.2, 2)
#plot_and_fit(sys.16, 16)
plot_and_fit(sys.18, 18)
#plot_and_fit(sys.19, 19)
#plot_and_fit(sys.20, 20)

