#
# GSR1976-2016.R, 28 Feb 17
# Data from:
# Semiconductor monthly sales volume: 1975-2016
# {World Semiconductor Trade Statistics}
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("reshape2")

pal_col=rainbow(5)

WSTS=read.csv(paste0(ESEUR_dir, "introduction/GSR1976-2016.csv.xz"), as.is=TRUE)

year_reg=melt(WSTS, id.vars=c("Year", "Region"), variable.name="Month")

year_reg$Date=as.Date(paste0(year_reg$Year, "-", year_reg$Month, "-01"),
			format="%Y-%B-%d")
year_reg=year_reg[order(year_reg$Date), ]

world=subset(year_reg, Region == "Worldwide")
Europe=subset(year_reg, Region == "Europe")
Americas=subset(year_reg, Region == "Americas")
Japan=subset(year_reg, Region == "Japan")
Asia_Pac=subset(year_reg, Region == "Asia Pacific")
China=subset(year_reg, Region == "China")

plot(world$Date, world$value/1e6, type="l", col=pal_col[1], log="y",
	xlab="Year", ylab="Monthly sales (billion dollars)\n")
lines(Asia_Pac$Date, Asia_Pac$value/1e6, col=pal_col[2])
lines(Americas$Date, Americas$value/1e6, col=pal_col[3])
lines(Japan$Date, Japan$value/1e6, col=pal_col[4])
lines(Europe$Date, Europe$value/1e6, col=pal_col[5])
#lines(China$Date, China$value/1e6, col=pal_col[6])


legend(x="bottomright", legend=c("World", "Asia Pacific", "Americas", "Japan", "Europe"), bty="n", fill=pal_col, cex=1.2)

