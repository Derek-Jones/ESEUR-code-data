#
# QualityAdjustedlaptop.R, 25 May 19
# Data from:
# What We Are Paying for: A Quality Adjusted Price Index for Laptop Microprocessors
# Sophie Sun
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_price cpu_laptop product_introduction


source("ESEUR_config.r")


library("plyr")


fit_price_perf=function(df)
{
x_vals=seq(50, 2000, by=20)
t_mod=glm(log(wPrime32) ~ log(Intro.Price), data=df)
pred=predict(t_mod, data.frame(Intro.Price=x_vals))
lines(x_vals, exp(pred), col=pal_col[df$Introduction-2002])
}


i_lapcpu=read.csv(paste0(ESEUR_dir, "economics/QualityAdjustedlaptop.csv.xz"), as.is=TRUE)


pal_col=rainbow(length(unique(i_lapcpu$Introduction)))

plot(i_lapcpu$Intro.Price, i_lapcpu$wPrime32, type="n", log="xy",
	xlab="Price", ylab="wPrime32 (time)\n")

d_ply(i_lapcpu, .(Introduction), function(df)
					points(df$Intro.Price, df$wPrime32,
						col=pal_col[df$Introduction-2002]))

fit_price_perf(subset(i_lapcpu, Introduction == 2004))
fit_price_perf(subset(i_lapcpu, Introduction == 2006))
fit_price_perf(subset(i_lapcpu, Introduction == 2009))
fit_price_perf(subset(i_lapcpu, Introduction == 2012))

legend(x="bottomleft", legend=2003:2013, bty="n", fill=pal_col, cex=1.1)


# table(i_lapcpu$Intro.Price)
# 
# plot(i_lapcpu$Introduction, i_lapcpu$Intro.Price)
# 
# # Adjust for inflation
# i_lapcpu$adj_price=round(i_lapcpu$Intro.Price*(1+0.05)^(i_lapcpu$Introduction-2003))

