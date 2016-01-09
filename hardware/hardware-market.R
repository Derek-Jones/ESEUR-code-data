#
# hardware-market.R,  2 Dec 15
#
# Data from:
# http://jeremyreimer.com/m-item.lsp?i=137
# Posted by: Jeremy Reimer on Fri Dec 7 11:06:14 2012.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

brew_col=rainbow(9)

hard_ms=read.csv(paste0(ESEUR_dir, "hardware/computer-marketshare.csv.xz"), as.is=TRUE)
OS_ms=read.csv(paste0(ESEUR_dir, "hardware/OS-marketshare.csv.xz"), as.is=TRUE)

y_bound=c(10, max(hard_ms$Smartphones, na.rm=TRUE))

plot_ms=function(years, ms, col_ind)
{
lines(years, ms, col=brew_col[col_ind])
}

plot(1, type="n", log="y",
	xlim=c(1975, 2012), ylim=y_bound,
	xlab="Year", ylab="Units shipped (thousands)\n")

plot_ms(hard_ms$Year, hard_ms$IBM.PC.clones, 1)
plot_ms(hard_ms$Year, hard_ms$Amiga, 2)
plot_ms(hard_ms$Year, hard_ms$Apple.II, 3)
plot_ms(hard_ms$Year, hard_ms$Atari.400.800, 4)
plot_ms(hard_ms$Year, hard_ms$Atari.ST, 5)
plot_ms(hard_ms$Year, hard_ms$Commodore.64, 6)
plot_ms(hard_ms$Year, hard_ms$Macintosh, 7)
plot_ms(hard_ms$Year, hard_ms$Other, 8)
plot_ms(hard_ms$Year, hard_ms$Smartphones, 9)

plot_ms(OS_ms$Year, 1000*OS_ms$Android, 2)
plot_ms(OS_ms$Year, 1000*OS_ms$Blackberry, 3)
plot_ms(OS_ms$Year, 1000*OS_ms$iPhone, 4)
plot_ms(OS_ms$Year, 1000*OS_ms$Linux, 5)
plot_ms(OS_ms$Year, 1000*OS_ms$Others, 6)
#plot_ms(OS_ms$Year, 1000*OS_ms$PalmOS, 7)
plot_ms(OS_ms$Year, 1000*OS_ms$Symbian, 7)
plot_ms(OS_ms$Year, 1000*OS_ms$WinMobile, 8)


