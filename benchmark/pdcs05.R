#
# pdcs05.R,  5 Jan 16
#
# Data from:
# Various configurations of Amdahl Corp's Sun SPARCcenter 2000
# processing SPEC SDM benchmark.  Tested Jan 1995
# See www.spec.org/sdm91
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

brew_col=rainbow(3)

all_cpu=read.csv(paste0(ESEUR_dir, "benchmark/pdcs05.csv.xz"), as.is=TRUE)

cpu8=subset(all_cpu, CPU==8)
cpu8$norm_throughput=cpu8$throughput/cpu8$throughput[1]
xbounds=seq(1, 151, by=5)

plot(cpu8$workload, cpu8$norm_throughput,
	xlim=range(xbounds), ylim=c(1, 20),
	xlab="Concurrent Workload", ylab="Throughput (jobs per unit time)\n")

a_mod=nls(norm_throughput ~ workload/(1+alpha*(workload-1)), data=cpu8,
			start=list(alpha=0.5), trace=TRUE)

lines(xbounds, predict(a_mod, newdata=data.frame(workload=xbounds)), col=brew_col[1])


ab_mod=nls(norm_throughput ~ workload/(1+alpha*(workload-1)+alpha*beta*workload*(workload-1)), data=cpu8,
			start=list(alpha=0.5, beta=0.1), trace=TRUE)

lines(xbounds, predict(ab_mod, newdata=data.frame(workload=xbounds)), col=brew_col[2])


# The following package might not yet be available on CRAN.
# It can be downloaded at: www.perfdynamics.com/Tools
library(pdq)

Dmax    = 1/max(cpu8$throughput) # hours
think   = 1/cpu8$throughput[1]-Dmax # hours

# The following function is adapted from the file R/pdq/demo/elephant.R
# in the pdq R distribution.
get_throughput=function(num_clients)
{
Init("")

CreateClosed("BenchWork", TERM, num_clients, think)
CreateNode("BenchSUT", CEN, FCFS)

SetDemand("BenchSUT", "BenchWork", Dmax)

SetWUnit("Scripts")
SetTUnit("Hour")

Solve(EXACT)

t=GetThruput(TERM, "BenchWork")

return(t)
}

all_thru=sapply(xbounds, get_throughput)

lines(xbounds, all_thru/all_thru[1], col=brew_col[3])

legend(x="bottomright",legend=c("Amdahl", "Quadratic Amdahl", "Queueing"), bty="n", fill=brew_col, cex=1.4)

