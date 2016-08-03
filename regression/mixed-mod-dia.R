#
# mixed-mod-dia.R, 17 Jul 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(3, 1)

num_lines=6
pal_col=rainbow(num_lines)

base_plot=function()
{
plot(-1, -1, lab=c(1, 1, 2),
	xlab="", ylab="",
	xlim=c(0, 1), ylim=c(0, 1))
}


lines_parallel=function(col_num)
{
yslope=0.2
ybase=rnorm(1, mean=0.4, sd=0.2)
yline=c(ybase, ybase+yslope)

lines(c(0, 1), yline, col=pal_col[col_num])
}


lines_star=function(col_num)
{
yslope=rnorm(1, sd=0.5)
yline=c(0.2, 0.5+yslope)

lines(c(0, 1), yline, col=pal_col[col_num])
}


lines_everywhich=function(col_num)
{
ybase=rnorm(1, mean=0.5, sd=0.3)
yslope=rnorm(1, mean=0.3, sd=0.2)
yline=c(ybase*(1-yslope), ybase*(1+yslope))

lines(c(0, 1), yline, col=pal_col[col_num])
}


base_plot()
dummy=sapply(1:num_lines, function(X) lines_parallel(X))
base_plot()
dummy=sapply(1:num_lines, function(X) lines_star(X))
base_plot()
dummy=sapply(1:num_lines, function(X) lines_everywhich(X))


