#
# firefox.R,  8 Jan 16
#
# Data from:
# Does Hardware Configuration and Processor Load Impact Software Fault Observability?
# Raza Abbas Syed, Brian Robinson and Laurie Williams
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


ff=read.csv(paste0(ESEUR_dir, "faults/hardware-config/firefox.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)
plot_layout(1, 2)

fit_fails=function(fail_count, ff_data, rhs, is_quasi)
{
# Build failure and non-failure vector
y=cbind(fail_count, 10-fail_count)

if (is_quasi)
   model=glm(formula(rhs), data=ff_data, family=quasibinomial)
else
   model=glm(formula(rhs), data=ff_data, family=binomial)

summary(model)
}

# Fit all predictor variables.
# Look for some interaction between the predictors first
fit_fails(ff$f_124750, ff, "y ~ cpu_speed*memory*disk_size", FALSE)
fit_fails(ff$f_124750, ff, "y ~ cpu_speed+memory+disk_size", FALSE)
# Now fit the one that we know might be significant
fit_fails(ff$f_124750, ff, "y ~ cpu_speed", FALSE)

fit_fails(ff$f_380417, ff, "y ~ cpu_speed+memory+disk_size", FALSE)
fit_fails(ff$f_380417, ff, "y ~ memory", FALSE)
# residual deviance is greater than the residual degrees of freedom
# Need to adjust for  overdispersion.
fit_fails(ff$f_380417, ff, "y ~ memory", TRUE)

fit_fails(ff$f_396863, ff, "y ~ cpu_speed+memory+disk_size", FALSE)

fit_fails(ff$f_410075, ff, "y ~ cpu_speed+memory+disk_size", FALSE)

fit_fails(ff$f_494116, ff, "y ~ cpu_speed+memory+disk_size", FALSE)

fit_fails(ff$f_264562, ff, "y ~ cpu_speed+memory+disk_size", FALSE)
fit_fails(ff$f_264562, ff, "y ~ cpu_speed", FALSE)

fit_fails(ff$f_332330, ff, "y ~ cpu_speed+memory+disk_size", FALSE)
fit_fails(ff$f_332330, ff, "y ~ cpu_speed", FALSE)

# What is the power of the tests?

library("pwr")

power.test=function(base_prob, p_diff, num_runs = 10, req_pow = NULL)
{
t = pwr.2p.test(h = 2*(asin(sqrt(base_prob+p_diff))-asin(sqrt(base_prob))),
                n = num_runs,
                sig.level = 0.05,
                power = req_pow)

return(t)
}

# The test is symmetric about 0.5

power.test(0.0, 0.3) # 494116 & 264562
power.test(0.7, 0.3) # 380417
power.test(0.3, 0.2)
power.test(0.3, 0.1)

# How many runs to have 90% probability of detection?
power.test(0.0, 0.3, NULL, 0.9)
power.test(0.0, 0.2, NULL, 0.9)
power.test(0.0, 0.1, NULL, 0.9)

# Repeat for a higher base rate
power.test(0.5, 0.3, NULL, 0.9)
power.test(0.5, 0.2, NULL, 0.9)
power.test(0.5, 0.1, NULL, 0.9)

base_p=c(0.5, 2.5, 5.0)

plot(1, type="n",
	xlim=range((1:45)/100), ylim=c(0, 0.9),
        xlab="Proportion difference", ylab="Power\n")
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
       title="Base p", fill=pal_col, cex=1.3)

plot(1, type="n", log="y",
	xlim=range((1:45)/100), ylim=c(10, 1000),
        xlab="Proportion difference", ylab="Number of Runs\n")
for (ip in 1:3)
   {
   pow=sapply(1:45, function(X)
			 power.test(base_p[ip]/10, X/100, NULL, 0.8)$n)
   lines((1:45)/100, pow, ,ylim=c(10, 1000), col=pal_col[ip])
   }
title("Runs needed", cex.main=1.1)
legend("bottomleft", legend=as.character(base_p/10), bty="n",
       title="Base p", fill=pal_col, cex=1.3)

 
