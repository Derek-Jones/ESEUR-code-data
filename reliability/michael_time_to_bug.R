#
# michael_time_to_bug.R, 28 Oct 15
#
# Data from:
#
# Program Analyses for Automatic and Precise Error Detection
# Michael Pradel
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("plyr")


plot_times=function(df)
{
t=sort(df$user_mode)
lines(t, col=pal_col[col_count])
col_count <<- col_count+1
}



# wallclock,user_mode,kernel_mode,class
time_bug=read.csv(paste0(ESEUR_dir, "reliability/michael_time_to_bug.csv.xz"), as.is=TRUE)

pal_col=rainbow(length(unique(time_bug$class)))

col_count=1
plot(1, type="n", log="y",
	xlim=c(1, 10), ylim=range(time_bug$user_mode),
	xlab="Runs", ylab="Seconds\n")

d_ply(time_bug, .(class), plot_times)


