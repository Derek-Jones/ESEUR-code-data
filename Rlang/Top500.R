#
# Top500.R, 21 Aug 19
# Data
# Top 500 The List
# https://www.top500.org/
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# 12 Jan 16 Fixed messed up problem reported by Alex Conlin-Oakley
#
# TAG supercomputer hardware benchmark


source("ESEUR_config.r")


merge_csv=function(file_str)
{
all_csv <<- merge(all_csv, read.csv(paste(dir_str, file_str, sep="/"), as.is=TRUE), all=TRUE)
return(0)
}

# Merge values from old_col to new_col.
# new_col is assumed to have NA values in some rows
mv_col=function(old_col, new_col)
{
new_csv=all_csv
new_is_na=is.na(new_csv[, new_col])
new_csv[new_is_na, new_col]=new_csv[new_is_na, old_col]

new_csv[, old_col]=NULL

return(new_csv)
}


dir_str=paste0(ESEUR_dir, "Rlang/Top500/")
top_files=list.files(dir_str)
top_files=top_files[grep("^TOP500_.*.csv.xz", top_files)]

all_csv=NULL
dummy=sapply(top_files, merge_csv)


all_csv=mv_col("Effeciency....", "Efficiency....")
all_csv=mv_col("Proc..Frequency", "Processor.Speed..MHz.")
all_csv=mv_col("RMax", "Rmax")
all_csv=mv_col("RPeak", "Rpeak")

all_csv=unique(all_csv)

