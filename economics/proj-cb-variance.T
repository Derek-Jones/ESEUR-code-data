#
# proj-cb_variance.R, 21 Mar 19
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example investment payback

source("ESEUR_config.r")


pal_col=rainbow(2)

r_val=0.05

# Values from economics/proj-lifespan.R
Google_s=0.79
Mainframe_s=0.87


S_exp=function(s, t=5, r=0.05)
{
S=s/(1+r)
return((1-S)/(S*(1-S^t)))
}

b_i_min=function(d_m, S_val)
{
return(1+d_m*S_exp(S_val, t_range, r_val))
}


b_i_variance=function(b_i_val, a_sign)
{
t=b_i_val-1 # extract the 'm' component
return(1+t+a_sign*1.96*t*0.2*sqrt(t_range))
}


t_range=seq(1, 10, by=0.5)

plot(0, type="n",
	xlim=range(t_range), ylim=c(0.5, 20.0),
	xlab="Payback length (years)", ylab="Benefit/investment ratio\n")

b_i=b_i_min(10, Google_s)
lines(t_range, b_i, col=pal_col[1])
lines(t_range, b_i_variance(b_i, -1), col=pal_col[2])
lines(t_range, b_i_variance(b_i, 1), col=pal_col[2])



