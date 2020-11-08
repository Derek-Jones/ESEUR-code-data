#
# ftalat.R, 28 Oct 20
# Data from:
# Evaluation of {CPU} Frequency Transition Latency
# Abdelhafid Mazouz and Alexandre Laurent and Beno\^{i}t Pradelle and William Jalby
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_hardware CPU_frequency CPU_DVFS

source("ESEUR_config.r")


library("plyr")


latency_line=function(df)
{
# Plots in original paper use median
t=ddply(df, .(to_freq), function(df) mean(df$latency))
lines(t$to_freq, t$V1, col=df$col_str[1])
}

ftal=read.csv(paste0(ESEUR_dir, "benchmark/ftalat.csv.xz"), as.is=TRUE)
ftal=subset(ftal, to_freq != from_freq)

# Make use 1.6 occurs first
u_f_freq=unique(c(1.6, ftal$from_freq))
pal_col=rainbow(length(u_f_freq))

ftal$col_str=mapvalues(ftal$from_freq, u_f_freq, pal_col)

plot(0,
	xaxs="i", yaxs="i",
	xlim=c(1.5, 3.31), ylim=c(20, 45),
	xlab="Target frequency", ylab="Latency (milliseconds)\n")

d_ply(ftal, .(from_freq), latency_line)

legend(x="topleft", legend=u_f_freq, bty="n", fill=pal_col, cex=1.2,
	inset=c(-0.03, -0.03))


# Used to reshape the original data.
#
# library("reshape2")
# 
# REP <- "input/alkan"
# Machine <- "IvyBridge"
# MaxFreq <- c(3.40, 3.30, 2.66)*10^9
# 
# FREQ <- c(1.6, 1.7, 1.9, 2.0, 2.1, 2.2, 2.4, 2.5, 2.6, 2.8, 2.9, 3.0, 3.1, 3.3, 3.4)*10^6
# 
# all=NULL
# k=1
# len <- length(FREQ)
# for(i in 1:len)	
# {
# 	freq <- FREQ[i] / 10^5
# 	freq <- paste(freq, "00000", sep="")
# 
# 	bench <- paste(REP,"/results_", freq, ".csv", sep="")
# 	input <- read.csv(bench, header=F, sep=" ")
# 	input <- as.matrix(input)
# 
# 	all=cbind(all, input)
# }
# 
# cycles <- 1/(MaxFreq[k])
# data <- data.frame(t(all * cycles * 10^6)) # report in microseconds
# 
# names(data)=as.character(FREQ)
# data$freq=rep(FREQ, each=31)
# 
# ldata=melt(data, id.vars="freq")
# 
# write.csv(ldata, file="/usr1/rbook/ftal.csv", row.names=FALSE)
# 
