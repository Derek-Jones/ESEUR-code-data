#
# cohens-d.R,  6 Jan 16
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example


source("ESEUR_config.r")


plot_layout(1, 4)
par(mar=c(5, 1, 4, 1)+0.1)

pal_col=rainbow(2)


norm_mean=2.5
norm_sd=1


plot_cohen=function(m_diff, sd_val)
{
xpoints=seq(0, norm_mean+norm_sd*2.5, by=0.01)
ypoints=dnorm(xpoints, mean=norm_mean, sd=norm_sd)

x2points=seq(0, norm_mean+m_diff+(norm_sd+sd_val)*2.5, by=0.01)
y2points=dnorm(x2points, mean=norm_mean+m_diff, sd=norm_sd+sd_val)

x_bounds=range(xpoints, x2points)
max_y=max(ypoints, y2points)

plot(xpoints, ypoints, type="l", col=pal_col[1], fg="grey", col.axis="grey", yaxt="n",
	bty="n", yaxt="n",
	xlim=x_bounds, ylim=c(0, max_y),
	xlab="", ylab="")
lines(x2points, y2points, col=pal_col[2], fg="grey", col.axis="grey")

# Pool the standard deviations
d_val=m_diff/sqrt((norm_sd^2+(norm_sd+sd_val)^2)/2)

text(norm_mean, max_y*0.2, paste0("d=", d_val), cex=1.3)
}

# Find the sd that produces a specified Cohen's d for a given mean difference
matching_sd=function(m_diff, d_val) return(sqrt(2*(m_diff/d_val)^2-1)-1)

plot_cohen(0.5, 0)
plot_cohen(1.0, 0)

plot_cohen(0.45, matching_sd(0.45, 0.5))
plot_cohen(1.2, matching_sd(1.2, 1.0))

