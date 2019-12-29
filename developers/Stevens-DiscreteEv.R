#
# Stevens-DiscreteEv.R,  5 Dec 19
# Data from:
# Discrete Adjustment to a Changing Environment: {Experimental} Evidence
# Mel Win Khaw and Luminita Stevens and Michael Woodford
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human estimate_probability

source("ESEUR_config.r")


plot_layout(2, 1, max_height=12)

par(mar=MAR_default-c(0.8, 0, 0, 0))


pal_col=rainbow(2)

plot_est_act=function(df)
{
plot(df$estimate, type="l", col=pal_col[2],
	xaxs="i", yaxs="i",
	ylim=c(0, 1),
	xlab="Rings drawn", ylab="Probability\n")
lines(df$probability, col=pal_col[1])

legend(x="bottom", legend=c("Actual", "Estimate"), bty="n", fill=pal_col, cex=1.2)
}


sde=read.csv(paste0(ESEUR_dir, "developers/Stevens-DiscreteEv.csv.xz"), as.is=TRUE)

s10s8=subset(sde, (subject == 10) & (session == 8))

plot_est_act(s10s8)

plot_est_act(subset(sde, (subject == 7) & (session == 8)))

