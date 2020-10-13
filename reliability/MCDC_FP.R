#
# MCDC_FP.R, 30 Sep 20
# Data from:
# Applicability of modified condition/decision coverage to software testing
# John Joseph Chilenski and Steven P. Miller
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example MC/DC testing


# When there are two functions per input value
c2=function(n)
{
lines(m, 1-(2^n-m-1)/2^n, type="b")
}

# When there are two functions per input value,
# i.e., always true and always false are included.
Pnm=function(n, m)
{
return(1-(2^(2^n-m)-1)/2^2^n)
}


p_disting=function(n)
{
lines(m, Pnm(n, m), type="b")
}

# Probability if there are m=n+1 tests, i.e., MC/DC requirement
mc_dc_false_prob=function(max_n)
{
lines(1:max_n, Pnm(1:max_n, 2:(max_n+1)), type="b")
}


m=1:10

# Various cases
plot(0, type="n",
	yaxs="i",
	xlim=c(1, 10), ylim=c(0, 1.02),
	xlab="Number of tests", ylab="Probability of false positive\n")

c2(3)
p_disting(2)
p_disting(3)
p_disting(7)


# Plot probability when there are m=n+1 tests, i.e., MC/DC requirement
plot(0, type="n",
	yaxs="i",
	xlim=c(1, 10), ylim=c(0.93, 1.01),
	xlab="Number of tests", ylab="Probability of false positive\n")

mc_dc_false_prob(9)



