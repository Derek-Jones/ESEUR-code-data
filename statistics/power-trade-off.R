#
# power-trade-off.R,  6 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


brew_col=rainbow_hcl(3)

plot_layout(1, 2)
par(mar=c(5, 1, 4, 1)+0.1)

pal_col=rainbow(3)
fill_col=rainbow_hcl(2)

norm_mean=4
norm_sd=1

xpoints=seq(0, norm_mean+norm_sd*4, by=0.01)
ypoints=dnorm(xpoints, mean=norm_mean, sd=norm_sd)

qn=qnorm(0.95, 0, norm_sd)

max_y=max(ypoints)

plot_overlap=function(mean_diff)
{
# One-tailed significance test
plot(xpoints, ypoints, type="l", col=pal_col[1], fg="grey", col.axis="grey", yaxt="n",
	bty="n", yaxt="n",
	xlim=c(3, 8),
	xlab="", ylab="")
q=norm_mean+qn
lines(c(q, q), c(0, max_y), col=pal_col[3])

upper_y1=subset(ypoints, xpoints >= norm_mean+qn)
upper_x1=subset(xpoints, xpoints >= norm_mean+qn)


x2points=xpoints+mean_diff # offset of second sample from first
y2points=ypoints

lines(x2points, y2points, col=pal_col[2])

upper_y2=subset(y2points, x2points >= norm_mean+qn)
upper_x2=subset(x2points, x2points >= norm_mean+qn)
polygon(c(upper_x2,  norm_mean+qn), c(upper_y2, 0), col=fill_col[2], border=NA)
polygon(c(upper_x1,  norm_mean+qn), c(upper_y1, 0), col=fill_col[1], border=NA)


text(q, max_y, "Decision criterion", cex=1.4)

text(q, max_y/16, expression(alpha), cex=1.6, pos=4, offset=0.4)
text(q, max_y/(1+2/mean_diff), expression(1-beta), cex=1.6, pos=4, offset=0.4+mean_diff/2)
}


plot_overlap(2)
plot_overlap(0.5)

