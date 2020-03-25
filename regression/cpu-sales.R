#
# cpu-sales.R, 16 Mar 20
#
# Data from:
# Embedded Processors
# Jim Turley
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG processor_embedded processor_sales evolution_sales


source("ESEUR_config.r")


pal_col=rainbow(3)

proc_sales=read.csv(paste0(ESEUR_dir, "introduction/turley_02.csv.xz"), as.is=TRUE)

proc_sales$date=as.Date(proc_sales$date, format="%d/%m/%Y")
proc_sales$days=as.numeric(proc_sales$date)
proc_sales$Mbit.4=proc_sales$bit.4/1e3

# Picked out of thin air and tweaked
y_1998=as.Date("01-04-1998", format="%d-%m-%Y")

#p4=glm(bit.4 ~ date, data=proc_sales)
p4=glm(Mbit.4 ~ date*(date < y_1998)+date*(date >= y_1998), data=proc_sales)
# summary(p4)

plot(proc_sales$date, proc_sales$Mbit.4, type="l", col=pal_col[2],
	xlab="Date", ylab="Units sold (million)\n")
lines(proc_sales$date, predict(p4), col=pal_col[1])


rad_per_day=(2*pi)/365
proc_sales$rad_days=rad_per_day*proc_sales$days

#season_p4=glm(Mbit.4 ~ date+
season_p4=glm(Mbit.4 ~ date*(date < y_1998)+date*(date >= y_1998)+
			I(sin(rad_days))+I(cos(rad_days)),
                                                             data=proc_sales)
# summary(season_p4)
lines(proc_sales$date, predict(season_p4), col=pal_col[3])

legend(x="bottom", legend=c("Two straight-lines", "Data", "Sine wave+straight lines"), bty="n", fill=pal_col, cex=1.2)

