#
# github-cust.R, 24 Apr 20
# Data from:
# https://classic.scraperwiki.com/scrapers/github_users_each_year/
# Francis Irving
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Github_customers customer_growth


source("ESEUR_config.r")


pal_col=rainbow(4)

mk_cust_mod=function(days, alg_str="default")
{
cust_mod=nls(total_Musers ~ m*(1-exp((p+q)*time))/(1+q/p*exp((p+q)*time)),
		data=cust, subset=1:days,
		algorithm=alg_str, # need for limited data convergence
#		control=list(minFactor=1e-5),
		start=list(m=2.1, p=-1e-3, q=-5e-2))

return(cust_mod)
}


cust=read.csv(paste0(ESEUR_dir, "economics/github-cust.csv.xz"), as.is=TRUE)

cust$when=as.Date(paste0(cust$when, "-01"), format="%Y-%m-%d")
cust$time=1:nrow(cust)
cust$total_Musers=cust$total_users/1e6

# F(t)=\frac{1-e^{-(p+q)t}}{1+\frac{q}{p}e^{-(p+q)t}}

# plot(cust$when, cust$total_Musers, col=point_col,
plot(cust$time, cust$total_Musers, log="y", col=point_col,
	xaxs="i",
	xlim=c(0, 65), ylim=c(0.01, 4),
	xlab="Months", ylab="Total customers (million)\n")

c_24=mk_cust_mod(24, alg_str="port")
pred=predict(c_24, newdata=data.frame(time=1:100))
lines(pred, col=pal_col[1])

c_36=mk_cust_mod(36)
pred=predict(c_36, newdata=data.frame(time=1:100))
lines(pred, col=pal_col[2])

c_48=mk_cust_mod(48)
pred=predict(c_48, newdata=data.frame(time=1:100))
lines(pred, col=pal_col[3])

c_all=mk_cust_mod(nrow(cust))
pred=predict(c_all, newdata=data.frame(time=1:100))
lines(pred, col=pal_col[4])

legend(x="topleft", legend=c("58 months", "48 months", "436months", "24 months"), bty="n", fill=rev(pal_col), cex=1.2)

