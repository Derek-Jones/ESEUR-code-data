#
# response-power.R,  6 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(1, 2)


power_test=function(num_runs=NULL, m_diff=NULL, d_sd=NULL, sig.level=0.05, req_pow = NULL)
{
t=power.t.test(n = num_runs, delta = m_diff, sd = d_sd, sig.level = sig.level,
                 power = req_pow,
                 type = "one.sample",
                 alternative = "one.sided")

return(t)
}


plot_power=function(mean_ind)
{
t_pow=sapply(10:100, function(X) power_test(X, mean_range[mean_ind], 1)$power)
lines(10:100, t_pow, col=pal_col[mean_ind])
text(10, t_pow[10], mean_range[mean_ind], pos=4, cex=1.2)
}


mean_range=seq(0.1, 0.9, by=0.2)
pal_col=rainbow(length(mean_range))
 

plot(0, type="n",
	xlim=c(10, 100), ylim=c(0, 1),
        xlab="Number of measurements", ylab="Power\n")
q=sapply(1:length(mean_range), function(X) plot_power(X))


sig_range=c(0.01, 0.05, 0.1, 0.15, 0.2)

sig_test=function(m_diff=NULL, d_sd=NULL, sig.level=NULL, req_pow = NULL)
{
t=power.t.test(n = 30, delta = m_diff, sd = d_sd, sig.level = sig.level,
                 power = req_pow,
                 type = "one.sample",
                 alternative = "one.sided")

return(t)
}


plot_sig=function(mean_ind)
{
t_pow=sapply(sig_range, function(X) sig_test(mean_range[mean_ind], 1, X)$power)
lines(sig_range, t_pow, col=pal_col[mean_ind])
text(0.01, t_pow[1], mean_range[mean_ind], pos=4, cex=1.3)
}


mean_range=seq(0.1, 0.9, by=0.2)
pal_col=rainbow(length(mean_range))
 

plot(0, type="n",
	xlim=range(sig_range), ylim=c(0, 1),
        xlab="Significance", ylab="")
q=sapply(1:length(mean_range), function(X) plot_sig(X))


