#
# hpc-read-write.R, 22 Dec 15
#
# Data from:
# The daily I/O activity of HPSS
# <http://www.nersc.gov/nusers/systems/HPSS/> at NERSC.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(2)

plot_layout(1, 2)

rd_wr=read.csv(paste0(ESEUR_dir, "regression/hpc-read-write.csv.xz"), as.is=TRUE)

rd_wr$Date=as.Date(rd_wr$Date, format="%Y-%m-%d")

positive_Total=subset(rd_wr, Total.GB > 0)
date_range=as.numeric(min(positive_Total$Date):max(positive_Total$Date))

plot(rd_wr$Date, rd_wr$Total.GB, col=point_col,
	xlab="Date", ylab="Total gigabytes read/written per day\n")

reg_mod=glm(Total.GB ~ Date, data=positive_Total)

pred=predict(reg_mod)
lines(positive_Total$Date, pred, col=pal_col[1])

loess_mod=loess(Total.GB ~ as.numeric(Date), data=rd_wr, span=0.9)
loess_pred=predict(loess_mod, newdata=data.frame(Date=date_range))
lines(date_range, loess_pred, col=pal_col[2])


# arc=subset(rd_wr, Host == "Archive")
# plot(arc$Date, arc$Total.GB)
# 
# rw_mod=lm(Total.GB ~ Date, data=arc)

reg=subset(rd_wr, Host == "Regent")
plot(reg$Date, reg$Total.GB, col=point_col,
	xlab="Date", ylab="")

positive_Total=subset(reg, Total.GB > 0)

reg_mod=glm(Total.GB ~ Date, data=positive_Total)

pred=predict(reg_mod)
lines(positive_Total$Date, pred, col=pal_col[1])

loess_mod=loess(Total.GB ~ as.numeric(Date), data=positive_Total, span=0.9)
loess_pred=predict(loess_mod, newdata=data.frame(Date=date_range))
lines(date_range, loess_pred, col=pal_col[2])

