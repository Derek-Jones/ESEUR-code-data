#
# knight1985.R,  5 Jul 19
# Data from:
# A Functional and Structural Measurement of Technology
# Kenneth E. Knight
# 
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark hardware performance 1960 1970

source("ESEUR_config.r")


fit_year=function(df)
{
y_mod=glm(log(op.sec) ~ log(dollar.sec), data=df)
pred=predict(y_mod)
lines(df$dollar.sec, exp(pred), col=pal_col[df$year-y_mm[1]+1])
}


kn=read.csv(paste0(ESEUR_dir, "ecosystems/knight1985.csv"), as.is=TRUE)
kn$year=as.integer(substring(kn$Date, nchar(kn$Date)-1))
kn$Date=as.Date(paste0("01/", kn$Date), format="%d/%m/%y")

# The values given are in operations per second, and seconds per dollar.
# Plotting these values against each other creates a quadratic in seconds!
kn$dollar.sec=1/kn$sec.dollar

y_mm=range(kn$year)

pal_col=rainbow(y_mm[2]-y_mm[1]+1)

plot(kn$dollar.sec, kn$op.sec, log="xy", col=pal_col[kn$year-y_mm[1]+1],
	xlab="Dollars per second", ylab="Operations per second\n")


fit_year(subset(kn, year == 63))
fit_year(subset(kn, year == 65))
fit_year(subset(kn, year == 67))
fit_year(subset(kn, year == 69))
fit_year(subset(kn, year == 71))
fit_year(subset(kn, year == 73))
fit_year(subset(kn, year == 75))
fit_year(subset(kn, year == 77))
fit_year(subset(kn, year == 79))

