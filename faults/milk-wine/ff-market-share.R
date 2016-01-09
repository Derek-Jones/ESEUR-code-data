#
# ff-market-share.R,  8 Jan 16
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

par(fin=c(4.5, 3.5))

study_start=as.Date("9-November-2004", format="%d-%B-%Y")
study_end=as.Date("1-October-2010", format="%d-%B-%Y")
last_estimate=as.Date("30-April-2007", format="%d-%B-%Y")


# browser market share
browser_ms=read.csv(paste0(ESEUR_dir, "faults/milk-wine/w3stats_browser.csv.xz"), as.is=TRUE)
browser_ms$date=as.Date(browser_ms$date, format="%m/%d/%Y")-study_start
xbounds=c(0, max(browser_ms$date))
max_ms=max(browser_ms$market_share)
ybounds=c(0, max_ms)

plot_market_share=function(ver_str, color)
{
t=subset(browser_ms, browser == ver_str)
lines(t$date, t$market_share, col=color, type="b")
y=max(t$market_share)
x=t$date[which(y == t$market_share)]
text(x, y, ver_str, pos=3, cex=1.3)
}

brew_col=rainbow(6)

plot(1, type="n",
	xlab="Days since version 1.0 released", ylab="Browser percentage market share\n",
	xlim=xbounds, ylim=ybounds)
plot_market_share("v1.0", brew_col[1])
plot_market_share("v1.5", brew_col[2])
plot_market_share("v2.0", brew_col[3])
plot_market_share("v3.0", brew_col[4])
plot_market_share("v3.5", brew_col[5])
plot_market_share("v3.6", brew_col[6])

last_estimate=as.numeric(last_estimate-study_start)
lines(cbind(rep(last_estimate, 2), ybounds), col="red")

