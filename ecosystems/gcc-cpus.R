#
# gcc-cpus.R,  9 Aug 19
# Data from:
# Extracted from release pages at: https://gcc.gnu.org/onlinedocs
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG gcc_releases cpu_code-generation survival

source("ESEUR_config.r")


library("plyr")
library("survival")


pal_col=rainbow(2)


cpu_groups=function(df)
{
groups=unique(df$group)
cpus=groups[!(groups %in% np_groups)]

return(data.frame(cpus, Date=df$Date[1]))
}


non_cpu_options=function(df)
{
non_cpu_opt=subset(df, group %in% np_groups)$option

return(data.frame(non_cpu_opt, Date=df$Date[1]))
}


cpu_lifetime=function(df)
{
max_date=max(df$Date)
days=max_date-min(df$Date)+1

return(data.frame(days, censored=(max_date != end_date)))
}


opt_lifetime=function(df)
{
max_date=max(df$Date)
days=max_date-min(df$Date)+1

return(data.frame(days, censored=(max_date != end_date)))
}


# Non-processor specific groups
np_groups=c("Overall",
	"C Language",
	"C++ Language",
	"Objective-C Language",
	"Objective-C and Objective-C++ Language",
	"Language Independent",
	"Warning",
	"C-only Warning",
	"C and Objective-C-only Warning",
	"Debugging",
	"Optimization",
	"Preprocessor",
	"Assembler",
	"Linker",
	"Directory",
	"Target",
	"Code Generation",
	"Diagnostic Message Formatting",
	"Program Instrumentation",
	"Developer")

gcc_rel=read.csv(paste0(ESEUR_dir, "ecosystems/gcc-releases.csv.xz"), as.is=TRUE)
# gcc_rel$Date=as.Date(gcc_rel$Date, format="%B %d %Y")

gcc=read.csv(paste0(ESEUR_dir, "ecosystems/gccopts.csv.xz"), as.is=TRUE)

gcc$Date=mapvalues(gcc$version, gcc_rel$Release, gcc_rel$Date)
gcc$Date=as.Date(gcc$Date, format="%B %d %Y")

end_date=max(gcc$Date)

all_cpus=ddply(gcc, .(version), cpu_groups)
life_cpus=ddply(all_cpus, .(cpus), cpu_lifetime)

cpu_surv=survfit(Surv(life_cpus$days, life_cpus$censored) ~ 1)

plot(cpu_surv, col=pal_col[2],
	yaxs="i",
	ylim=c(0.4, 1),
	xlab="Days", ylab="Survival\n")


all_non_cpus=ddply(gcc, .(version), non_cpu_options)
life_opts=ddply(all_non_cpus, .(non_cpu_opt), opt_lifetime)

opt_surv=survfit(Surv(life_opts$days, life_opts$censored) ~ 1)

lines(opt_surv, col=pal_col[1])

legend(x="bottomleft", legend=c("Options", "CPU"), bty="n", fill=pal_col, cex=1.2)

# # How many cpus have been removed?
# latest=subset(all_cpus, version == gcc_rel$Release[1])
# not_latest=subset(all_cpus, version != gcc_rel$Release[1])
# u_nl_option=unique(not_latest$cpus)
# 
# length(which(!(u_nl_option %in% latest$cpus)))
# length(which( (u_nl_option %in% latest$cpus)))
# length(unique(all_cpus$cpus))


