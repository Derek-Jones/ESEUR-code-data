#
# not-uniform.R, 21 Apr 15
#
# Data from:
# The daily I/O activity of HPSS
# <http://www.nersc.gov/nusers/systems/HPSS/> at NERSC.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("circular")

source(paste0(ESEUR_dir, "statistics/circular/grp-data-boot.R"))


rd_wr=read.csv(paste0(ESEUR_dir, "regression/hpc-read-write.csv.xz"), as.is=TRUE)

rd_wr$Date=as.Date(rd_wr$Date, format="%Y-%m-%d")

positive_Total=subset(rd_wr, Total.GB > 0)

date_ord=order(rd_wr$Date)
rw_gb=rd_wr$Total.GB[order(rd_wr$Date)]
days=(as.integer(rd_wr$Date[order(rd_wr$Date)]) %% 7)*(360/7)

mon_angle=seq(0, 359, 360/7)
t=rep(days, rw_gb/50)

DoW=circular(t, units="degrees", rotation="clock")

plot(DoW, stack=TRUE, shrink=3, axes=FALSE, cex=0.01)
axis.circular(at=circular(mon_angle, units="degrees", rotation="clock"), labels=1:7)
lines(density(DoW, bw=30))

gb_week=as.vector(table(t))

boot_res=UGsqWeekTotalsBoot(gb_week, 10)

boot_res[[1]]

hist(boot_res[[2]], freq=FALSE)

FreeBSD commits per week...

