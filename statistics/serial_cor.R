#
# serial_cor.R,  2 Mar 19
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example correlation_serial


source("ESEUR_config.r")


# library("sandwich")

# Need to get this plot to fit in the margin, along with the plot before it
plot_layout(2, 1, max_height=12)
par(mar=MAR_default-c(0.8, 0, 0.0, 0))

pal_col=rainbow(12)


sample_var=function(var_cor, sample_size)
{
# cor_data=arima.sim(list(ar=var_cor), sample_size)
# Filter is about twice as fast
cor_data=filter(rnorm(sample_size), var_cor, method = "recursive")

return(lrvar(cor_data))
}


rep_sample_var=function(var_cor, sample_size)
{
# Reduce computational effort by making number of replications
# go down with sample size.
t=replicate(2e5/(sample_size^2), sample_var(var_cor, sample_size))

return(mean(t))
}


plot_cor=function(var_cor, col_str)
{
t=sapply(sample_sizes, function(X) rep_sample_var(var_cor, X))
lines(sample_sizes, t, col=col_str)
}


# Too small a start value generates errors
# sample_sizes=exp(seq(log(8), log(200), length.out=10))

# plot(1, type="n", log="xy",
# 	xlim=range(sample_sizes), ylim=c(2e-4, 0.5),
# 	xlab="Sample size", ylab="Standard error\n")

# cor_vals=c(0.1, 0.2, 0.3, 0.5, 0.7, 0.9)

## plot_cor(1e-5, pal_col[1])
# lines(sample_sizes, 1/sample_sizes, col=pal_col[1])
# plot_cor(0.1, pal_col[2])
# plot_cor(0.2, pal_col[3])
# plot_cor(0.3, pal_col[4])
# plot_cor(0.5, pal_col[5])
# plot_cor(0.7, pal_col[6])
# 
# legend(x="bottomleft", legend=rev(cor_vals), bty="n", fill=rev(pal_col), cex=1.2)


cor_vals=c(0.1, 0.2, 0.3, 0.5, 0.7, 0.9)

sample_sizes=exp(seq(log(5), log(200), length.out=20))


mean_var_adj=function(serial_cor, col_str)
{
# Equation from example 2.17 of "Time series analysis" by Cryer & Chan
gamma=1+2*(1-1/sample_sizes)*serial_cor
adjust_mean=sqrt((sample_sizes-1)/(sample_sizes/gamma -1))

lines(sample_sizes, adjust_mean, col=col_str)
}


plot(1, type="n", log="x",
	cex.axis=1.4, cex.lab=1.4,
	xlim=range(sample_sizes), ylim=c(0, 2.0),
	xlab="Sample size", ylab="Bias in standard deviation of mean\n")

mean_var_adj(0.1, pal_col[1])
mean_var_adj(0.2, pal_col[2])
mean_var_adj(0.3, pal_col[3])
mean_var_adj(0.5, pal_col[4])
mean_var_adj(0.7, pal_col[5])
mean_var_adj(0.9, pal_col[6])
mean_var_adj(-0.1, pal_col[7])
mean_var_adj(-0.2, pal_col[8])
mean_var_adj(-0.3, pal_col[9])
mean_var_adj(-0.5, pal_col[10])
# mean_var_adj(-0.7, pal_col[11])
# mean_var_adj(-0.9, pal_col[12])

legend(x="topright", legend=rev(cor_vals), bty="n", fill=rev(pal_col[1:6]), cex=1.4)
legend(x="bottomright", legend=-cor_vals[1:4], bty="n", fill=pal_col[7:10], cex=1.4)


variance_adj=function(serial_cor, col_str)
{
# Equation from example 2.18 of "Time series analysis" by Cryer & Chan
adjust_cor=sqrt(1-2/(sample_sizes-1)*(1-1/sample_sizes)*serial_cor)

lines(sample_sizes, adjust_cor, col=col_str)
}

plot(1, type="n", log="x",
	cex.axis=1.4, cex.lab=1.4,
	xlim=range(sample_sizes), ylim=c(8e-1, 1.2),
	xlab="Sample size", ylab="Bias in standard deviation of sample\n")

variance_adj(0.1, pal_col[1])
variance_adj(0.2, pal_col[2])
variance_adj(0.3, pal_col[3])
variance_adj(0.5, pal_col[4])
variance_adj(0.7, pal_col[5])
variance_adj(0.9, pal_col[6])
variance_adj(-0.1, pal_col[7])
variance_adj(-0.2, pal_col[8])
variance_adj(-0.3, pal_col[9])
variance_adj(-0.5, pal_col[10])
variance_adj(-0.7, pal_col[11])
variance_adj(-0.9, pal_col[12])

legend(x="bottomright", legend=cor_vals, bty="n", fill=pal_col[1:6], cex=1.2)
legend(x="topright", legend=rev(-cor_vals), bty="n", fill=rev(pal_col[7:12]), cex=1.2)

