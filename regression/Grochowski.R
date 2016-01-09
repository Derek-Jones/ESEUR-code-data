#
# Grochowski.R, 15 Nov 14
# Data from:
# Future Technology Challenges For NAND Flash and HDD Products
# Edward Grochowski and Robert E. Fontana, Jr.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


# library("gnm")

all_den=read.csv(paste0(ESEUR_dir, "regression/20120821_S102A_Grochowski.csv.xz"), as.is=TRUE)

pal_col=rainbow(3)


plot(all_den, log="y", col="gray",
	xlab="Production Date", ylab="Areal Density (gigabits/m^2)\n")

all_den$log_ad=log(all_den$areal_density)

MRhead=subset(all_den, date < 1997)
GMRhead=subset(all_den, date >= 1997 & date < 2001)
AFCmedia=subset(all_den, date >= 2001 & date < 2010)
latest=subset(all_den, date >= 2010)

plot_subset=function(product_run, date_range, col_num=1)
{
# m3=gnm(areal_density ~ 1+Mult(1, Inv(Const(1)+Exp(Mult(1+offset(-date), Inv(1))))),
# 	data=product_run, family=gaussian("log"),
# 	start=c(inter=0.5, a=5, b=2000, c=1))

# m3=nls(log_ad ~ SSlogis(date, a, b, c), data=product_run, algorithm="port")
m3=nls(log_ad ~ SSfpl(date, a, b, c, d), data=product_run,
 		control= nls.control(warnOnly=TRUE))

y=predict(m3, newdata=data.frame(date=date_range), type="response")
lines(date_range, exp(y), col=pal_col[col_num])

# y=predict(m3, type="response")
# lines(product_run$date, y, col=pal_col[col_num])
# return(m3)
}

# The following generates: ...singular gradient...
# plot_subset(MRhead, seq(1990, 1999, by=0.2), 1)
t=plot_subset(GMRhead, seq(1996, 2002, by=0.2), 2)
plot_subset(AFCmedia, seq(2000, 2011, by=0.2), 3)

text(MRhead$date[1], MRhead$areal_density[1], "1st MR head", pos=4, cex=1.3)
text(GMRhead$date[1], GMRhead$areal_density[1], "1st GMR head", pos=4, cex=1.3)
text(AFCmedia$date[1], AFCmedia$areal_density[1], "1st AFC media", pos=4, cex=1.3)


# getInitial(log_ad ~ SSfpl(date, a, b, c, d), data=MRhead)
# getInitial(log_ad ~ SSfpl(date, 0.5, 3.2, 1999, 0.7), data=MRhead)
# t=nls(log_ad ~ SSlogis(date, a, b, c), data=MRhead, algorithm="port")


