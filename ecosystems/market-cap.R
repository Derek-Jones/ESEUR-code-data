#
# market-cap.R, 15 Jul 16
#
# Data from:
# Daily chart for April 21 2015 on The Economist webpage
# Economist {Data team}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

plot_layout(2, 1)
pal_col=rainbow(3)

total_valu=function(df)
{
if (nrow(df) != 281)
   print(df)
# t=data.frame(year=df$x[3:140], ticker=df$ticker[3:140],
t=data.frame(year=1980+df$x[3:140]*(35/475), ticker=df$ticker[3:140],
		       market_cap=df$y[280:143]-df$y[3:140])

return(t)
}


plot_lines=function(df)
{
lines(df$year, df$market_cap)
}


plot_ticker=function(tick_str, col_str)
{
tick_mc=subset(mc, ticker == tick_str)

lines(tick_mc$year, tick_mc$market_cap, col=col_str)

return(tick_mc)
}

plot_percent=function(tick_str, col_str)
{
tick_mc=subset(mc, ticker == tick_str)

lines(tick_mc$year, 100*tick_mc$market_cap/tick_mc$tech_market_cap, col=col_str)
}

sum_market_cap=function(df)
{
return(sum(df$market_cap))
}

m_cap=read.csv(paste0(ESEUR_dir, "ecosystems/real-market-cap.csv.xz"), as.is=TRUE)

# ibm=subset(m_cap, ticker == "IBM")
# ibm_1=subset(ibm, round == 1)
# ibm_2=subset(ibm, round == 2)

# plot(ibm_1$x, max(ibm_1$y)-ibm_1$y, col="red")
#lines(ibm_2$x, max(ibm_2$y)-ibm_2$y, col="blue")
# lines(ibm_2$x[1:140], max(ibm_2$y)-ibm_2$y[1:140], col="green")
# lines(ibm_2$x[280:141]+6.76, max(ibm_2$y)-ibm_2$y[280:141], col="red")
# lines(ibm_2$x[278:141], max(ibm_2$y)-ibm_2$y[280:143], col="black")

# Ignore the Year/January only data
valu_bounds=subset(m_cap, round == 2)

mc=ddply(valu_bounds, .(ticker), total_valu)

plot(0, type="n",
	xlim=c(1980, 2015), ylim=c(0, 70),
	xlab="Date", ylab="Market cap\n")

# d_ply(mc, .(ticker), plot_lines)

aapl=plot_ticker("AAPL", pal_col[1])
ibm=plot_ticker("IBM", pal_col[2])
MSFT=plot_ticker("MSFT", pal_col[3])

tmc=ddply(mc, .(year), sum_market_cap)
mc$tech_market_cap=tmc$V1

plot(0, type="n",
	xlim=c(1980, 2015), ylim=c(0, 80),
	xlab="Date", ylab="Tech market capital share (%)\n")

aapl=plot_percent("AAPL", pal_col[1])
ibm=plot_percent("IBM", pal_col[2])
MSFT=plot_percent("MSFT", pal_col[3])

legend(x="topright", legend=rev(c("Apple", "IBM", "Microsoft")), bty="n", fill=rev(pal_col), cex=1.1)

