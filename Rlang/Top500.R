#
# Top500.R, 12 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# 12 Jan 16 Fixed messed up problem reported by Alex Conlin-Oakley

dir_str="/usr1/rbook/examples/Rlang/Top500/"
top_files=list.files(dir_str)
top_files=top_files[grep("^TOP500_.*.csv.xz", top_files)]

merge_csv=function(file_str)
{
all_csv <<- merge(all_csv, read.csv(paste(dir_str, file_str, sep="/"), as.is=TRUE), all=TRUE)
return(0)
}

all_csv=NULL
dummy=sapply(top_files, merge_csv)


mv_col=function(old_col, new_col)
{
new_csv=subset(all_csv, is.na(all_csv[, old_col]))
t=subset(all_csv, !is.na(all_csv[, old_col]))
t[, new_col]=t[, old_col]

new_csv=rbind(new_csv, t)

new_csv[, old_col]=NULL

return(new_csv)
}

all_csv=mv_col("Effeciency....", "Efficiency....")
all_csv=mv_col("Proc..Frequency", "Processor.Speed..MHz.")
all_csv=mv_col("RMax", "Rmax")
all_csv=mv_col("RPeak", "Rpeak")

all_csv=unique(all_csv)

