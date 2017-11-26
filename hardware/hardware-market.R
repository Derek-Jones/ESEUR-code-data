#
# hardware-market.R, 21 Nov 17
#
# Data from:
# Mainframe & mini sales
# The Postwar Evolution of Computer Prices
# Robert J. Gordon
# plus, a correction from Einstein and Franklin table 1
# The 1992 Annual Computer Industry Almanac (page 502) has
# much larger numbers for Mini units and ???
#
# http://jeremyreimer.com/m-item.lsp?i=137
# Posted by: Jeremy Reimer on Fri Dec 7 11:06:14 2012.
#
# Worldwide Smartphone Sales
# Gartner, via https://en.wikipedia.org/wiki/Mobile_operating_system
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library(lubridate)
library(plyr)

pal_col=rainbow(5)


sum_quarters=function(df)
{
return(data.frame(smartphones=sum(df$Total.smartphones),
			phones=sum(df$Total.phones)))
}


plot_ms=function(years, ms, col_ind)
{
lines(years, ms, col=pal_col[col_ind])
}

mmm_sales=read.csv(paste0(ESEUR_dir, "hardware/w2227.csv.xz"), as.is=TRUE)

hard_ms=read.csv(paste0(ESEUR_dir, "hardware/computer-marketshare.csv.xz"), as.is=TRUE)
phone_sales=read.csv(paste0(ESEUR_dir, "hardware/phone-sales.csv.xz"), as.is=TRUE)
phone_sales$Year=year(as.Date(phone_sales$Date))
phones_year=ddply(phone_sales, .(Year), sum_quarters)

phones_year=subset(phones_year, Year < 2017)

y_bound=c(0.1, max(phones_year$smartphones, na.rm=TRUE))

plot(mmm_sales$year, mmm_sales$MF_units/1e3, type="l", log="y", col=pal_col[1],
	xlim=c(1955, 2016), ylim=y_bound,
	xlab="Year", ylab="Units shipped (thousands)\n")
lines(mmm_sales$year, mmm_sales$mini_units/1e3, col=pal_col[2])
# text(1962, 20, "Mainframes", cex=1.3)
# text(1975, 50, "Minicomputers", cex=1.3)


plot_ms(hard_ms$Year, hard_ms$IBM.PC.clones, 3)
# plot_ms(hard_ms$Year, hard_ms$Amiga, 2)
# plot_ms(hard_ms$Year, hard_ms$Apple.II, 3)
# plot_ms(hard_ms$Year, hard_ms$Atari.400.800, 4)
# plot_ms(hard_ms$Year, hard_ms$Atari.ST, 4)
# plot_ms(hard_ms$Year, hard_ms$Commodore.64, 5)
plot_ms(hard_ms$Year, hard_ms$Macintosh, 4)
# plot_ms(hard_ms$Year, hard_ms$Other, 7)
# plot_ms(hard_ms$Year, hard_ms$Tablets, 1)
# plot_ms(hard_ms$Year, hard_ms$Smartphones, 8)


plot_ms(phones_year$Year, phones_year$smartphones, 5)
# plot_ms(phones_year$Year, phones_year$phones-phones_year$smartphones, 6)

legend(x="bottomright", legend=c("Mainframes", "Minicomputers", "PCs", "Macintosh", "Smartphones"), bty="n", fill=pal_col, cex=1.2)

