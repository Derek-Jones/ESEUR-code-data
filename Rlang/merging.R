#
# merging.R, 12 Jan 16
#
# Merging multiple csv files
# Data from the top500.org web site, November of every year
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

dir_str=paste0(ESEUR_dir, "Rlang/Top500/")
top_files=list.files(dir_str)
top_files=top_files[grep("^TOP500_.*.csv.xz", top_files)]

merge_csv=function(file_str)
{
all_csv <<- merge(all_csv, read.csv(paste(dir_str, file_str, sep="/")), all=TRUE)
return(0)
}

mv_col=function(old_col, new_col)
{
new_csv=subset(all_csv, is.na(all_csv[, old_col]))
t=subset(all_csv, !is.na(all_csv[, old_col]))
t[, new_col]=t[, old_col]

new_csv=rbind(new_csv, t)

new_csv[, old_col]=NULL

return(new_csv)
}


all_csv=0

dummy=sapply(top_files, function(X) merge_csv(X))

all_csv=mv_col("Effeciency....", "Efficiency....")
all_csv=mv_col("Proc..Frequency", "Processor.Speed..MHz.")
all_csv=mv_col("RMax", "Rmax")
all_csv=mv_col("RPeak", "Rpeak")

cpu_power=data.frame(Year=all_csv$Year,
		     Power=all_csv$Power,
		     Rmax=all_csv$Rmax,
		     Rpeak=all_csv$Rpeak,
		     Nmax=all_csv$Nmax,
		     Nhalf=all_csv$Nhalf,
		     Processor.Speed=all_csv$Processor.Speed..MHz.,
		     Segment=all_csv$Segment)

cpu_power=unique(cpu_power)

# What factors explain the following plot?
plot(cpu_power$Year, log(cpu_power$Power))


# all_csv$Rank=NULL
# all_csv$Previous.Rank=NULL
# all_csv$First.Rank=NULL
# all_csv$First.Appearance=NULL
# all_csv$Application.Area=NULL
# all_csv$Interconnect.Family=NULL
# all_csv$Interconnect=NULL
# all_csv$Accelerator.Co.Processor=NULL
# all_csv$Accelerator.Co.Processor.Cores=NULL
# all_csv$Processor.Generation=NULL
# all_csv$Computer=NULL
# all_csv$Name=NULL
# all_csv$Site=NULL


