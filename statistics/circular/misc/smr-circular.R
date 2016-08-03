#
# smr-circular.R,  2 Jun 16
#
# Data from:
# Studying the laws of software evolution in a long-lived {FLOSS} project
# Jes{\'u}s M. Gonz{\'a}lez-Barahona and Gregorio Robles and Israel Herraiz and Felipe Ortega
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("circular")
library("lubridate")
library("plyr")

scm=read.csv(paste0(ESEUR_dir, "time-series/smr1615/scmlog.csv.xz"),
				 as.is=TRUE, quote="\'")
# Reduce memory overhead
scm$rev=NULL
scm$message=NULL
scm$date=as.Date(scm$date, format="%Y-%m-%d")

mon_angle=seq(0, 359, 360/12)

# Dates taken from paper's R code which came with the data
start_date=as.Date("1991-01-01", format="%Y-%m-%d")
end_date=as.Date("2012-01-01", format="%Y-%m-%d")

cfl=read.csv(paste0(ESEUR_dir, "time-series/smr1615/commits_files_lines.csv.xz"),
				 as.is=TRUE, quote="\'")

# scm$id is ordered by commit id
cfl$date=scm$date[cfl$commit]

cfl=subset(cfl, (date >= start_date) & (date <= end_date))
cfl$angle=(as.numeric(cfl$date-start_date) %% 365)*360/365

added=subset(cfl, added != 0)
removed=subset(cfl, removed != 0)

A_y=circular(added$angle, units="degrees", rotation="clock")
rose.diag(A_y, bins=75, shrink=1.2, prop=5, axes=FALSE, col="red")
lines(density(A_y, bw=30))

R_y=circular(removed$angle, units="degrees", rotation="clock")
rose.diag(R_y, bins=75, shrink=1.2, prop=5, axes=FALSE, col="red")
lines(density(R_y, bw=30))

axis.circular(at=circular(mon_angle, units="degrees", rotation="clock"))

cfl$year=year(cfl$date)


cfl_total=ddply(cfl, .(date),
		function(df) data.frame(total_commits=length(unique(df$commit)),
                                        total_added=sum(df$added),
					total_removed=sum(df$removed)))
cfl_total$angle=(as.numeric(cfl_total$date-start_date) %% 365)*360/365
added_total=subset(cfl_total, total_added != 0)
removed_total=subset(cfl_total, total_removed != 0)

# Placement of vertical strips is sensitive to the range of

smoothScatter(added_total$angle, log(added_total$total_added), colramp=colorRampPalette(c("blue", "orange", "red"), space = "Lab"))
smoothScatter(trunc(added_total$angle %% 7), log(added_total$total_added), colramp=colorRampPalette(c("blue", "orange", "red"), space = "Lab"))

smoothScatter(trunc(cfl_total$angle %% 7), log(cfl_total$total_commit), colramp=colorRampPalette(c("blue", "orange", "red"), space = "Lab"))

d_ply(cfl, .(year), function(df)
			{
R_y=circular(df$angle, units="degrees", rotation="clock")
rose.diag(R_y, bins=75, shrink=1.2, prop=5, axes=FALSE, col="red")
			})

