#
# smr-ccf.R, 20 Feb 16
#
# Data from:
# Studying the laws of software evolution in a long-lived {FLOSS} project
# Jes{\'u}s M. Gonz{\'a}lez-Barahona and Gregorio Robles and Israel Herraiz and Felipe Ortega
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lubridate")
library("plyr")

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

# cfl_day=ddply(cfl, .(date),
# 		function(df) data.frame(num_changes=nrow(df)))
# 
# There are days with no commits, so this does not work as such
# cfl_week=aaply(seq(1, nrow(cfl_day), by=7), 1,
# 			function(X) sum(cfl_day$num_changes[X:(X+6)]))

cfl$week=floor_date(cfl$date, "week")
cfl_week=ddply(cfl, .(week),
		function(df) data.frame(num_commits=length(unique(df$commit)),
                                        lines_added=sum(df$added),
					lines_deleted=sum(df$removed)))

# plot(cfl_week$week, cfl_week$num_commits, type="l")
# plot(cfl_week$week, cfl_week$lines_added+1e-2, type="l", log="y")

# auto.arima(cfl_week$lines_added)
# auto.arima(cfl_week$lines_deleted)

ccf(cfl_week$lines_added, cfl_week$lines_deleted,
	xlab="Weeks")


