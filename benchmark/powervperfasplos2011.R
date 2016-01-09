#
# powervperfasplos2011.R, 13 Aug 15
#
# Data from:
# Looking Back on the Language and Hardware Revolutions: {Measured} Power, Performance, and Scaling
# Hadi Esmaeilzadeh and Ting Cao and Xi Yang and Stephen M. Blackburn and Kathryn S. McKinley
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("plyr")


runtime=read.csv(paste0(ESEUR_dir, "benchmark/runtime-powerperf.csv.xz"), as.is=TRUE)

# Pick one Core/Thread configuration
C1T=subset(runtime, CMPxSMT == "2C1T")

# The SPEC benchmark programs
SPEC_ind=grepl("^X4", names(C1T))

# table(C1T$Frequency, C1T$Turbo.Boost)
# table(C1T$Frequency, C1T$Processor)
# table(C1T$Processor)

# Pick one processor
Core_2D_45=subset(C1T, Processor == "Core 2D (45)")


# Return arithmetic and geometric means
arith_geo_mean=function(freq)
{
F_1603=subset(Core_2D_45, Frequency == freq)

# Just the SPEC values
# SPEC_perf=t(subset(F_1603, select=SPEC_ind))

# Values from all benchmarks
SPEC_perf=t(F_1603[, -(1:4)])

return(c(mean(SPEC_perf), exp(mean(log(SPEC_perf)))))
}


perf_base=arith_geo_mean(1603)
perf_24=arith_geo_mean(2403)
perf_30=arith_geo_mean(3066)

# Calculate ratio of means
perf_base/perf_24
perf_base/perf_30


# Return mean of ratios
base_ratio=function(freq)
{
F_1603=subset(Core_2D_45, Frequency == 1603)
F_freq=subset(Core_2D_45, Frequency == freq)

# Just the SPEC values
# SPEC_perf=subset(F_1603, select=SPEC_ind)

# Values from all benchmarks
SPEC_F=t(F_1603[, -(1:4)])
SPEC_freq=t(F_freq[, -(1:4)])

return(mean(SPEC_F/SPEC_freq))
}


ratio_24=base_ratio(2403)
ratio_30=base_ratio(3066)

ratio_24
ratio_30


