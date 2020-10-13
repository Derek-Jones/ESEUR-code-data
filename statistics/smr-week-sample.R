#
# smr-week-sample.R, 25 Apr 20
#
# Data from:
# Studying the laws of software evolution in a long-lived {FLOSS} project
# Jes{\'u}s M. Gonz{\'a}lez-Barahona and Gregorio Robles and Israel Herraiz and Felipe Ortega
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C_library glibc_LOC LOC_evolution commits weekly yearly glic


source("ESEUR_config.r")

library("lubridate")
library("plyr")


plot_layout(6, 4, max_height=30)
par(mar=MAR_default-c(0.8, 1.7, 0.7, 0.7))

scm=read.csv(paste0(ESEUR_dir, "time-series/smr1615/scmlog.csv.xz"),
				 as.is=TRUE, quote="\'")
# Reduce memory overhead
scm$rev=NULL
scm$message=NULL
scm$date=as.Date(scm$date, format="%Y-%m-%d")

# Dates taken from paper's R code which came with the data
start_date=as.Date("1991-01-01", format="%Y-%m-%d")
end_date=as.Date("2012-01-01", format="%Y-%m-%d")

cfl=read.csv(paste0(ESEUR_dir, "time-series/smr1615/commits_files_lines.csv.xz"),
				 as.is=TRUE, quote="\'")

# scm$id is ordered by commit id
cfl$date=scm$date[cfl$commit]

cfl=subset(cfl, (date >= start_date) & (date <= end_date))

cfl$year=year(cfl$date)

# d_ply(cfl, .(year), function(df) plot(table(month(df$date)), ylab=""))

# Dates start with Thursday as zero, so need to shift up to make Monday zero
plot(table(trunc(as.numeric(3+cfl$date) %% 7)), col=point_col, cex=1.3,
		cex.lab=1.4, xlab="Total", ylab="")

d_ply(cfl, .(year), function(df) plot(table(trunc(as.numeric(3+df$date) %% 7)),
					 col=point_col, cex=1.3, cex.lab=1.4,
					 xlab=df$year[1], ylab=""))


