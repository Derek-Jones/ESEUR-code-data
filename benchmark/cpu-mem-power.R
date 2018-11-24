#
# cpu-mem-power.R, 24 Nov 18
#
# Data from:
# Predictive Power Management for Multi-Core Processors
# William Lloyd Bircher
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark cpu memory power


source("ESEUR_config.r")

# Shrink to accommodate other plots in same margin of the book
plot_layout(2, 1, max_height=11)
par(mar=MAR_default-c(2.5, 0, 0, 0))

pal_col=rainbow_hcl(3)


# DIMM,core_4,core_1,benchmark
power=read.csv(paste0(ESEUR_dir, "benchmark/bircher_F44.csv.xz"), as.is=TRUE)
power$total=power$core_4+power$DIMM
power=power[order(power$total), ]

# The middle of total power is a fixed point on the barplots
# core & DIMM power straddles this middle line
middle=max(power$total)/2
power$lower=middle-power$total/2
power$upper=middle+power$total/2

num_power=1:nrow(power)

plot.new()
plot.window(xlim=c(0, nrow(power)), ylim=c(-7, middle*2))

rect(num_power-0.2, power$lower, num_power+0.2, power$lower+power$core_4, col="red")
rect(num_power-0.2, power$lower+power$core_4, num_power+0.2, power$upper, col="blue")

lines(c(0, nrow(power)), c(middle, middle), col="grey")

# offset=0.0 has a useful effect!
text(num_power, power$lower, paste0(power$benchmark, " "), pos=2, offset=0.0, srt=45, col="black", cex=1.1)

ticks=seq(0, middle*2, 5)
axis(2, at=ticks, labels=abs(ticks-middle), cex.axis=1.5)


power=read.csv(paste0(ESEUR_dir, "benchmark/bircher_F46.csv.xz"), as.is=TRUE)

# Improve look of legend
power$workload=sub("_", "\n", power$workload)

pal_col=rainbow_hcl(nrow(power))

barplot(as.matrix(power[, -1]), col=pal_col, srt=40, cex.axis=1.5,
	ylab="Power (watts)\n", cex.names=1.1,
	legend.text=power$workload,
        args.legend=list(x="topright", bty="n"))


