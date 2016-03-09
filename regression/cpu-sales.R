#
# cpu-sales.R,  7 Mar 16
#
# Data from:
#
# Jim Turley
# Embedded Processors
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_wide()
pal_col=rainbow(3)

proc_sales=read.csv(paste0(ESEUR_dir, "introduction/turley_02.csv.xz"), as.is=TRUE)

proc_sales$date=as.Date(proc_sales$date, format="%d/%m/%Y")
proc_sales$days=as.numeric(proc_sales$date)

# Picked out of thin air and tweaked
y_1998=as.Date("01-04-1998", format="%d-%m-%Y")

#p4=glm(bit.4 ~ date, data=proc_sales)
p4=glm(bit.4 ~ date*(date < y_1998)+date*(date >= y_1998), data=proc_sales)
# summary(p4)

plot(proc_sales$date, proc_sales$bit.4, type="l", col=pal_col[2],
	xlab="Date", ylab="Sales (in thousands)\n")
lines(proc_sales$date, predict(p4), col=pal_col[1])


rad_per_day=(2*pi)/365
proc_sales$rad_days=rad_per_day*proc_sales$days

#season_p4=glm(bit.4 ~ date+
season_p4=glm(bit.4 ~ date*(date < y_1998)+date*(date >= y_1998)+
			I(sin(rad_days))+I(cos(rad_days)),
                                                             data=proc_sales)
# summary(season_p4)
lines(proc_sales$date, predict(season_p4), col=pal_col[3])

legend(x="topleft", legend=c("Two straight-lines", "Data", "Sine wave+straight lines"), bty="n", fill=pal_col, cex=1.3)

