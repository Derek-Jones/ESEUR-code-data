#
# mcdonald2005.R,  3 Oct 19
# Data from:
# The Impact of Project Planning Team Experience on Software Project Cost Estimates
# James Mcdonald
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimation_cost experiment_developer


source("ESEUR_config.r")


plot_fit=function(df, col_str)
{
sp_mod=glm(Cost_est ~ Experience, data=df)
pred=predict(sp_mod, newdata=data.frame(Experience=x_range))
lines(x_range, pred, col=col_str)
}

pal_col=rainbow(2)


mc=read.csv(paste0(ESEUR_dir, "projects/mcdonald2005.csv.xz"), as.is=TRUE)

plot(1, type="n",
	xlim=range(mc$Experience), ylim=range(mc$Cost_est),
	xlab="Team experience (mean years)", ylab="Estimate (million $)\n")

sp=subset(mc, similar_exp == 1)
nsp=subset(mc, similar_exp != 1)

points(sp$Experience, sp$Cost_est, col=pal_col[1])
points(nsp$Experience, nsp$Cost_est, col=pal_col[2])

legend(x="bottomright", legend=c("Similar project experience", "No similar projects"), bty="n", fill=pal_col, cex=1.2)

x_range=seq(1, 11, by=0.5)

plot_fit(sp, pal_col[1])
plot_fit(nsp, pal_col[2])


ec_mod=glm(Cost_est ~ (Experience+similar_exp)^2, data=mc)
summary(ec_mod)


