#
# hyojun.R,  5 Jan 16
#
# Data from:
# INFORMED STORAGE MANAGEMENT FOR MOBILE PLATFORM
# kindly supplied by Hyojun Kim
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")
library("reshape2")


bench_path=paste0(ESEUR_dir, "benchmark/hyojun/")


# Read the data from each benchmark and merge into one table
merge_benchmark=function(file_str)
{
t=read.csv(paste0(bench_path, file_str), as.is=TRUE)

t=melt(t, c("Vendor", "Benchmark"), value.name="Perf")

# Not interested in order in which runs occur
t$variable=NULL

return(t)
}

# Map performance into range 0..1
equalise_scale=function(df)
{
# df$eq_Perf=df$Perf/mean(df$Perf)
df$eq_Perf=df$Perf/max(df$Perf)
return(df)
}

bfiles=list.files(path=bench_path, pattern="*.csv.xz")
all_bench=adply(bfiles, 1, merge_benchmark)

all_bench=ddply(all_bench, .(Benchmark), equalise_scale)

# A great fit, but useless
# f_mod=glm(Perf ~ Vendor:Benchmark, data=all_bench)

fv_mod=glm(eq_Perf ~ Vendor, data=all_bench)
summary(fv_mod)


