#
# gccopts.R,  7 Aug 19
# Data from:
# Extracted from release pages at: https://gcc.gnu.org/onlinedocs
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG gcc_releases options evolution

source("ESEUR_config.r")


library("plyr")


num_opts=function(df)
{
return(data.frame(total_opt=nrow(df), Date=df$Date))
}


# group_opts=function(group_ind)
# {
#    version_line=function(ver_num)
#    {
#    ver_opts=subset(C_opts, grepl(paste0("^", ver_num), version))
#    lines(ver_opts$Date, ver_opts$total_opt, col=pal_col[group_ind])
#    }
# 
# C_opts=ddply(subset(gcc, group == plot_groups[group_ind]), .(version), num_opts)
# dummy=sapply(2:9, version_line)
# }

group_opts=function(group_ind)
{
C_opts=ddply(subset(gcc, group == plot_groups[group_ind]), .(version), num_opts)
lines(C_opts$Date, C_opts$total_opt, col=pal_col[group_ind], type="p")
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

plot_groups=c("Optimization", "Warning",
		"C++ Language", "C Language",
		"Linker")
pal_col=rainbow(length(plot_groups))

gcc_rel=read.csv(paste0(ESEUR_dir, "ecosystems/gcc-releases.csv.xz"), as.is=TRUE)
# gcc_rel$Date=as.Date(gcc_rel$Date, format="%B %d %Y")

gcc=read.csv(paste0(ESEUR_dir, "ecosystems/gccopts.csv.xz"), as.is=TRUE)

gcc$Date=mapvalues(gcc$version, gcc_rel$Release, gcc_rel$Date)
gcc$Date=as.Date(gcc$Date, format="%B %d %Y")

u_version=unique(gcc$version)

# all_opts=ddply(gcc, .(version), num_opts)

plot(gcc$Date[1], 1, log="y",
	xaxs="i",
	xlim=range(gcc$Date), ylim=c(10, 210),
	xlab="Date", ylab="Options\n")

dummy=sapply(1:length(plot_groups), group_opts)

legend(x="left", legend=plot_groups, bty="n", fill=pal_col, cex=1.2)


# # How many options have been removed from the non-processor groups?
# np_gcc=subset(gcc, group %in% np_groups)
# latest=subset(np_gcc, version == gcc_rel$Release[1])
# not_latest=subset(np_gcc, version != gcc_rel$Release[1])
# u_nl_option=unique(not_latest$option)
# 
# length(which(!(u_nl_option %in% latest$option)))
# length(which( (u_nl_option %in% latest$option)))
# length(unique(np_gcc$option))

