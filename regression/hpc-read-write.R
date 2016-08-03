#
# hpc-read-write.R, 23 Jul 16
#
# Data from:
# The daily I/O activity of HPSS at NERSC
# http://www.nersc.gov/nusers/systems/HPSS/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("changepoint")


plot_layout(2, 1)
pal_col=rainbow(2)


rd_wr=read.csv(paste0(ESEUR_dir, "regression/hpc-read-write.csv.xz"), as.is=TRUE)

rd_wr$Date=as.Date(rd_wr$Date, format="%Y-%m-%d")

positive_Total=subset(rd_wr, Total.GB > 0)
date_range=as.numeric(min(positive_Total$Date):max(positive_Total$Date))


mean_change_at=cpt.mean(positive_Total$Writes.GB)
plot(mean_change_at)

var_change_at=cpt.var(positive_Total$Writes.GB)
plot(var_change_at)

mv_change_at=cpt.meanvar(positive_Total$Writes.GB)
plot(mv_change_at)


