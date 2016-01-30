#
# glibc_evo.R,  6 Nov 14
#
# Data from:
# Studying the laws of software evolution in a long-lived FLOSS project
# Jesus M. Gonzalez-Barahona and Gregorio Robles and Israel Herraiz and Felipe Ortega
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# id,branch_id,date,loc,sloc,files
glibc=read.csv(paste0(ESEUR_dir, "ecosystem/glibc_evo.csv.xz"), as.is=TRUE)

glibc$date=as.POSIXct(glibc$date, format="%Y-%m-%d")
start_date=as.POSIXct("1990-01-01", format="%Y-%m-%d")
glibc$Number_days=as.integer(difftime(glibc$date,
                                         start_date,
                                         units="days"))

glibc_main=subset(glibc, branch_id == 1)
glibc_main=subset(glibc_main, Number_days > 0)
x_bounds=min(glibc_main$Number_days):max(glibc_main$Number_days)

# They are probably already sorted by date
glibc_main=glibc_main[order(glibc_main$Number_days), ]

plot(glibc_main$Number_days, glibc_main$sloc, col=point_col,
	xlab="Days since 1 Jan 1990", ylab="SLOC\n")

l_mod=nls(sloc ~ SSfpl(Number_days, a, b, c, d), data=glibc_main)
pred=predict(l_mod, list(Number_days=x_bounds))

lines(x_bounds, pred, col="red")

