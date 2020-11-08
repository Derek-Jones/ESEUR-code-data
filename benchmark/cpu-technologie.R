#
# cpu-technologie.R,  8 Nov 20
#
# Data from:
# Andrew Danowitz and Kyle Kelley and James Mao and John P. Stevenson and Mark Horowitz
# CPU DB: Recording Microprocessor History
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Silicon device_atoms cpu_transistors frequency_evolution CPU_characteristics device_fabrication


source("ESEUR_config.r")


pal_col=rainbow(2)

cpu=read.csv(paste0(ESEUR_dir, "benchmark/cpu-technologie.csv.xz"), as.is=TRUE)

# 0.54307nm is the lattice size for Silicon atoms.
# The lattice has a diamond cubic structure, so individuals atoms
# are closer to each other than this.
cpu$Si_atoms=cpu$feature_size*1000/0.54307
plot(cpu$year, cpu$Si_atoms, log="y", col=pal_col[2],
	xlim=c(1980, 2015),
	xlab="Year", ylab="Feature size (in Silicon atoms)\n")

fs_mod=glm(log(Si_atoms) ~ year, data=cpu, subset=(year >=1990))
summary(fs_mod)

years=1990:2010

pred=predict(fs_mod, new=data.frame(year=years))
lines(years, exp(pred), col=pal_col[1])

