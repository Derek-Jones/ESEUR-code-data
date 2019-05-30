#
# proj-cost-ben.R, 21 Mar 19
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

# From Dunn, likely to include costs unrelated to source code changes
d_m_ratio=4.9

S_exp=function(s, t=5, r=0.05)
{
S=s/(1+r)
return((1-S)/(S*(1-S^t)))
}

b_i_min=function(d_m, S_val)
{
return(1+d_m*S_exp(S_val, t_range, r_val))
}


t_range=seq(1, 10, by=0.5)

plot(0, type="n",
	xlim=range(t_range), ylim=c(2.5, 20.0),
	xlab="Payback length (years)", ylab="Benefit/investment ratio\n")

lines(t_range, b_i_min(5, Google_s), col=pal_col[1])
lines(t_range, b_i_min(5, Mainframe_s), col=pal_col[2])
gm=b_i_min(5, (Google_s+Mainframe_s)/2)
text(5, gm[9], paste0("d/m=", 5), col=point_col)

# r_val=0.10
lines(t_range, b_i_min(10, Google_s), col=pal_col[1])
lines(t_range, b_i_min(10, Mainframe_s), col=pal_col[2])
gm=b_i_min(10, (Google_s+Mainframe_s)/2)
text(5, gm[9], paste0("d/m=", 10), col=point_col)

lines(t_range, b_i_min(20, Google_s), col=pal_col[1])
lines(t_range, b_i_min(20, Mainframe_s), col=pal_col[2])
gm=b_i_min(20, (Google_s+Mainframe_s)/2)
text(5, gm[9], paste0("d/m=", 20), col=point_col)

legend(x="topright", legend=c("Google", "Mainframe"), bty="n", fill=pal_col, cex=1.2)


