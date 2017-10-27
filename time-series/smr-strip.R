#
# smr-strip.R, 22 Aug 16
#
# Data from:
# Studying the laws of software evolution in a long-lived {FLOSS} project
# Jes{\'u}s M. Gonz{\'a}lez-Barahona and Gregorio Robles and Israel Herraiz and Felipe Ortega
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lattice")
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

cfl$week=floor_date(cfl$date, "week")
cfl_week=ddply(cfl, .(week),
		function(df) data.frame(num_commits=length(unique(df$commit)),
                                        lines_added=sum(df$added),
					lines_deleted=sum(df$removed)))

# Placement of vertical strips is sensitive to the range of
# values on the y-axis, which may have to be compressed (e.q., sqrt(...).
t=xyplot(lines_added ~ week | equal.count(week, 4, overlap=0.1), cfl_week,
		type="l", aspect="xy", strip=FALSE,
		xlab="", ylab="Weekly total",
		scales=list(x=list(relation="sliced", axs="i", cex=0.6),
			    y=list(alternating=FALSE, log=TRUE, cex=0.7)))
plot(t)

