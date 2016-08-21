#
# hardware-market.R, 18 Aug 16
#
# Data from:
# http://jeremyreimer.com/m-item.lsp?i=137
# Posted by: Jeremy Reimer on Fri Dec 7 11:06:14 2012.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

pal_col=rainbow(9)

hard_ms=read.csv(paste0(ESEUR_dir, "hardware/computer-marketshare.csv.xz"), as.is=TRUE)
OS_ms=read.csv(paste0(ESEUR_dir, "hardware/OS-marketshare.csv.xz"), as.is=TRUE)

y_bound=c(10, max(hard_ms$Smartphones, na.rm=TRUE))

plot_ms=function(years, ms, col_ind)
{
lines(years, ms, col=pal_col[col_ind])
}

plot(1, type="n", log="y",
	xlim=c(1975, 2012), ylim=y_bound,
	xlab="Year", ylab="Units shipped (thousands)\n")

hard_str=c("IBM.PC.clones",
		"Amiga",
		"Apple.II",
		"Atari.400.800",
		"Atari.ST",
		"Commodore.64",
		"Macintosh",
		"Other",
		"Smartphones")

plot_ms(hard_ms$Year, hard_ms$IBM.PC.clones, 1)
plot_ms(hard_ms$Year, hard_ms$Amiga, 2)
plot_ms(hard_ms$Year, hard_ms$Apple.II, 3)
plot_ms(hard_ms$Year, hard_ms$Atari.400.800, 4)
plot_ms(hard_ms$Year, hard_ms$Atari.ST, 5)
plot_ms(hard_ms$Year, hard_ms$Commodore.64, 6)
plot_ms(hard_ms$Year, hard_ms$Macintosh, 7)
plot_ms(hard_ms$Year, hard_ms$Other, 8)
plot_ms(hard_ms$Year, hard_ms$Smartphones, 9)

legend(x="topleft", legend=hard_str, bty="n", fill=pal_col, cex=1.2)

OS_str=c("Android",
		"Blackberry",
		"iPhone",
		"Linux",
		"Others",
		"Symbian",
		"WinMobile")

plot_ms(OS_ms$Year, 1000*OS_ms$Android, 1)
plot_ms(OS_ms$Year, 1000*OS_ms$Blackberry, 2)
plot_ms(OS_ms$Year, 1000*OS_ms$iPhone, 3)
plot_ms(OS_ms$Year, 1000*OS_ms$Linux, 4)
plot_ms(OS_ms$Year, 1000*OS_ms$Others, 5)
#plot_ms(OS_ms$Year, 1000*OS_ms$PalmOS, 7)
plot_ms(OS_ms$Year, 1000*OS_ms$Symbian, 6)
plot_ms(OS_ms$Year, 1000*OS_ms$WinMobile, 7)

legend(x="bottomright", legend=OS_str, bty="n", fill=pal_col, cex=1.2)


