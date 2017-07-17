#
# mobile-market.R,  6 Jul 17
#
# Data from:
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


library("lubridate")
library("plyr")


pal_col=rainbow(6)


plot_ms=function(ms, col_ind)
{
lines(all_sales$Year, 100*ms/all_sales$total_units, col=pal_col[col_ind])
}

sum_quarters=function(df)
{
return(data.frame(Android=sum(df$Android),
                        iOS=sum(df$iOS),
                        Windows=sum(df$Windows),
                        Blackberry=sum(df$BlackBerry),
                        Symbian=sum(df$Symbian),
                        Others=sum(df$Other)))
}

sum_units=function(df)
{
return(df$Android+ df$iOS+ df$Windows+ df$Blackberry+ df$Symbian+ df$Others)
}


OS_ms=read.csv(paste0(ESEUR_dir, "hardware/OS-marketshare.csv.xz"), as.is=TRUE)
OS_ms$Others=OS_ms$Others+ OS_ms$PalmOS+ OS_ms$Linux

OS_06=subset(OS_ms, Year < 2007)

phone_sales=read.csv(paste0(ESEUR_dir, "hardware/phone-sales.csv.xz"), as.is=TRUE)              
phone_sales$Year=year(as.Date(phone_sales$Date))
phones_year=ddply(phone_sales, .(Year), sum_quarters)

phones_year=subset(phones_year, Year < 2017)


all_sales=data.frame(
		Year=c(OS_06$Year, phones_year$Year),
		Android=c(1000*OS_06$Android, phones_year$Android),
		Blackberry=c(1000*OS_06$Blackberry, phones_year$Blackberry),
		iOS=c(1000*OS_06$iPhone, phones_year$iOS),
		Others=c(1000*OS_06$Others, phones_year$Others),
		Symbian=c(1000*OS_06$Symbian, phones_year$Symbian),
		Windows=c(1000*OS_06$WinMobile, phones_year$Windows))
all_sales$total_units=daply(all_sales, .(Year), sum_units)


plot(1, type="n",
	xlim=c(2000, 2017), ylim=c(1, 90),
	xlab="Year", ylab="Percentage total units shipped\n")

plot_ms(all_sales$Android, 1)
plot_ms(all_sales$Blackberry, 2)
plot_ms(all_sales$iOS, 3)
plot_ms(all_sales$Others, 4)
plot_ms(all_sales$Symbian, 5)
plot_ms(all_sales$Windows, 6)
# plot_ms(c(1000*OS_06$Linux, phones_year$Linux), 4)
# plot_ms(c(1000*OS_06$PalmOS, phones_year$PalmOS), 7)

OS_str=c("Android",
		"Blackberry",
		"iOS",
#		"Linux",
		"Others",
		"Symbian",
		"Windows")

legend(x="top", legend=OS_str, bty="n", fill=pal_col, cex=1.2)

