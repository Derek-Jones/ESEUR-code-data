#
# cpu-technologie.R, 25 Mar 16
#
# Data from:
#
# Andrew Danowitz and Kyle Kelley and James Mao and John P. Stevenson and Mark Horowitz
# CPU DB: Recording Microprocessor History
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG cpu_transistors frequency_evolution CPU_characteristics device_fabrication


source("ESEUR_config.r")


cpu=read.csv(paste0(ESEUR_dir, "benchmark/cpu-technologie.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)

# 0.54307nm is the lattice size for Silicon atoms.
# The lattice has a diamond cubic structure, so individuals atoms
# are closer to each other than this.
plot(jitter(cpu$year), cpu$feature_size*1000/0.54307, log="y", col=point_col,
	xlim=c(1980, 2015),
	xlab="Year", ylab="Feature size (in Silicon atoms)\n")

