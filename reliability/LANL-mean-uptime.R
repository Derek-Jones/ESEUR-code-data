#
# LANL-mean-uptime.R, 25 Nov 12
# Data from:
# Los Alamos National Lab (LANL)
# http://www.lanl.gov/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

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

uptimes=ddply(t, "nodenumz",
                function(df) get_node_uptimes(df))

return(uptimes)
}


profile.sys=function(sys.num)
{
sys.n=get_system_uptimes(sys.num)

sys.n=sys.n[sys.n$Uptime > 0, ]

return(c(sys.num,
         length(unique(sys.n$nodenumz)),
         length(sys.n$Uptime),
         as.integer(median(sys.n$Uptime/3600)),
         as.integer(mean(sys.n$Uptime/3600))))
}


time.format="%m/%d/%Y %H:%M"
day.start=as.integer(as.Date("04/06/1996 00:01", format=time.format))

fail.rec=read.csv(paste0(ESEUR_dir, "reliability/LA-UR-05-7318-failure-data-1996-2005.csv.xz"), as.is=TRUE)


# System 2, 16, 18, 19, 20 each have an order of magnitude more
# failure records than the other systems.
sys.2=profile.sys(2)
sys.16=profile.sys(16)
sys.18=profile.sys(18)
sys.19=profile.sys(19)
sys.20=profile.sys(20)

library("ascii")


print(ascii(rbind(c("System", "Nodes", "Failures", "Mean", "Median"),
                  sys.2,
                  sys.16,
                  sys.18,
                  sys.19,
                  sys.20)))

