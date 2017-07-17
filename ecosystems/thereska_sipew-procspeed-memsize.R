#
# thereska_sipew-procspeed-memsize.R,  8 Dec 14
#
# Data from:
# Practical Performance Models for Complex, Popular Applications
# Eno Thereska and Bjoern Doebel and Alice X. Zheng and Peter Nobel
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


# ProcSpeed,MemorySize,Session_Count
memcpu=read.csv(paste0(ESEUR_dir, "ecosystems/thereska_sipew-procspeed-memsize.csv.xz"), as.is=TRUE)
memcpu$logMemSize=as.integer(18*log(memcpu$MemorySize))

pal_col=rainbow(12)

# pairs(Session_Count ~ ProcSpeed + MemorySize, data=memcpu)
# pairs(log(Session_Count) ~ ProcSpeed + logMemSize, data=memcpu)

# cnt_mat=matrix(data=0, nrow=max(memcpu$ProcSpeed*10), ncol=max(memcpu$logMemSize))
# 
# cnt_mat[cbind(memcpu$ProcSpeed*10, memcpu$logMemSize)]=log(memcpu$Session_Count)
# 
# contour(z=cnt_mat)


Um=unique(memcpu$MemorySize)
M_map=mapvalues(memcpu$MemorySize, from=Um, to=rank(Um))

Us=unique(memcpu$ProcSpeed)
S_map=mapvalues(memcpu$ProcSpeed, from=Us, to=rank(Us))

cnt_mat=matrix(data=0, nrow=length(Us), ncol=length(Um))

cnt_mat[cbind(S_map, M_map)]=log(memcpu$Session_Count)

contour(x=seq(min(Us)/max(Us), 1, length.out=length(Us)),
	y=seq(min(Um)/max(Um), 1, length.out=length(Um)),
	z=cnt_mat, col=pal_col, nlevels=10,
	axes=FALSE,
	xlim=c(min(Us)/max(Us), 1), ylim=c(min(Um)/max(Um), 1),
	xlab="Processor speed (GHz)", ylab="Memory size (Mbyte)\n")

axis(1, at=sort(Us)/max(Us), labels=sort(Us))
axis(2, at=sort(Um)/max(Um), labels=sort(Um))

