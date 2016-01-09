#
# printer_diff_time.R, 22 Dec 15
#
# Data from:
# Correlated dynamics in human printing behavior
# Uli Harder and Maya Paczuski
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)

# Return time interval of arrival times for print jobs
# having a given size
get_size_time_diff = function(job_size)
{
big_pr=subset(pr_time_size, pr_time_size$size > job_size)
return (diff(big_pr$time))
}

plot_hist = function(time_diff, do_count, col_num)
{
num_bins=13
bin_width=c(0, exp(log(max(time_diff))/num_bins)^(1:num_bins))
p=hist(time_diff, breaks=bin_width, plot=FALSE)

p$breaks[1]=1e-4 # require a non-zero value in a log-log plot

if (do_count)
   lines((p$breaks[1:num_bins]*p$breaks[2:(num_bins+1)])^0.5, # geometric mean
         p$count,
         type="b", col=pal_col[col_num])
else
   lines((p$breaks[1:num_bins]*p$breaks[2:(num_bins+1)])^0.5, # geometric mean
         p$density,
         type="b", col=pal_col[col_num])

}

plot_t_diff = function(job_size, do_count, col_num)
{
t_diff = get_size_time_diff(job_size)
plot_hist(t_diff, do_count, col_num)
}


pr_time_size=read.csv(paste0(ESEUR_dir, "time-series/misc/scale-free-printing.txt.xz"), sep=" ", header=FALSE)
colnames(pr_time_size)=c("time", "size")

# plot(1, type="n", log="xy",
#          xlim=c(1e-2, 1e6), ylim=c(1e-10, 1e-1),
#          xlab="Time interval (seconds)", ylab="Count density\n")

plot(1, type="n", log="xy",
         xlim=c(1e-2, 1e6), ylim=c(1, 1e+5),
         xlab="Time interval (seconds)", ylab="Counts\n")

plot_t_diff(1e2, TRUE, 1)
plot_t_diff(1e4, TRUE, 2)
plot_t_diff(1e6, TRUE, 3)
plot_t_diff(1e7, TRUE, 4)


# pr_hr=table((pr_time %/% 360)+1)
# pr_day=table((pr_time %/% (24*360))+1)
# 
# ind=as.integer(names(pr_hr))
# pr_cnt=rep(0, max(ind))
# pr_cnt[ind]=pr_hr
# 
# acf(diff(pr_cnt), lag=170)
# plot(pr_cnt, type="h")
# 
# acf(diff(pr_day))
# plot(pr_day, type="h")

