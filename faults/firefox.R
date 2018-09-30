#
# firefox.R, 10 Sep 18
#
# Data from:
# Does Hardware Configuration and Processor Load Impact Software Fault Observability?
# Raza Abbas Syed, Brian Robinson and Laurie Williams
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG faults statistical-power


source("ESEUR_config.r")


library("pwr")


plot_layout(2, 1)
pal_col=rainbow(3)


ff=read.csv(paste0(ESEUR_dir, "faults/firefox.csv.xz"), as.is=TRUE)

fit_fails=function(fail_count, ff_data, is_quasi)
{
# Build failure and non-failure vector
y=cbind(fail_count, 10-fail_count)

# Fit all explanatory variables, looking for some interaction between them
b_mod=glm(y ~ (cpu_speed+memory+disk_size)^3, data=ff_data,
			family=ifelse(is_quasi, quasibinomial, binomial))

t=stepAIC(b_mod, trace=0)

return(t)
}

# ft=cbind(ff$f_124750, 10-ff$f_124750)
# ft_mod=glm(ft ~ (cpu_speed+memory+disk_size)^3, data=ff, family=binomial)

# t=fit_fails(ff$f_124750, ff, FALSE)

# residual deviance is greater than the residual degrees of freedom
# Need to adjust for  overdispersion.
# t=fit_fails(ff$f_380417, ff, TRUE)

# t=fit_fails(ff$f_396863, ff, FALSE)

# t=fit_fails(ff$f_410075, ff, FALSE)

# t=fit_fails(ff$f_494116, ff, FALSE)

# t=fit_fails(ff$f_264562, ff, FALSE)

# t=fit_fails(ff$f_332330, ff, FALSE)

# What is the power of the tests?

power.test=function(base_prob, p_diff, num_runs = 10, req_pow = NULL)
{
t = pwr.2p.test(h = ES.h(base_prob+p_diff, base_prob),
                n = num_runs,
                sig.level = 0.05,
                power = req_pow)

return(t)
}

# The test is symmetric about 0.5

# power.test(0.0, 0.3) # 494116 & 264562
# power.test(0.7, 0.3) # 380417
# power.test(0.3, 0.2)
# power.test(0.3, 0.1)

# How many runs to have 90% probability of detection?
# power.test(0.0, 0.3, NULL, 0.9)
# power.test(0.0, 0.2, NULL, 0.9)
# power.test(0.0, 0.1, NULL, 0.9)

# Repeat for a higher base rate
# power.test(0.5, 0.3, NULL, 0.9)
# power.test(0.5, 0.2, NULL, 0.9)
# power.test(0.5, 0.1, NULL, 0.9)

base_p=c(0.5, 2.5, 5.0)

plot(1, type="n",
	xaxs="i", yaxs="i",
	xlim=range((1:45)/100), ylim=c(0, 0.9),
        xlab="Difference", ylab="Power\n")
for (ip in 1:3)
   {
   pow=sapply(1:45, function(X)
			power.test(base_p[ip]/10, X/100, 10)$power)
   lines((1:45)/100, pow, col=pal_col[ip])
   pow=sapply(1:45, function(X)
			power.test(base_p[ip]/10, X/100, 50)$power)
   lines((1:45)/100, pow, col=pal_col[ip])
   }
text(0.20, 0.7, "50")
text(0.25, 0.3, "10")
title("Power of experiment", cex.main=1.1)
legend("bottomright", legend=as.character(base_p/10), bty="n",
       title="Before", fill=pal_col, cex=1.3)

plot(1, type="n", log="y",
	xaxs="i", yaxs="i",
	xlim=range((1:45)/100), ylim=c(10, 1000),
        xlab="Difference", ylab="Runs\n")
for (ip in 1:3)
   {
   pow=sapply(1:45, function(X)
			 power.test(base_p[ip]/10, X/100, NULL, 0.8)$n)
   lines((1:45)/100, pow, ,ylim=c(10, 1000), col=pal_col[ip])
   }
title("Runs needed", cex.main=1.1)
legend("bottomleft", legend=as.character(base_p/10), bty="n",
       title="Before", fill=pal_col, cex=1.3)

 
