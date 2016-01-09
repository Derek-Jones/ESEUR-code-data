#
# commit-median.R, 24 Apr 15
#
# Data from:
# Do time of day and developer experience affect commit bugginess?
# Jon Eyolfson and Lin Tan and Patrick Lam
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("circular")


pal_col=rainbow(2)

# id repository_id raw_author_id sha1 merge utc_time local_time
commits=read.csv(paste0(ESEUR_dir, "time-series/commits/scc_commit.tsv.xz"), sep="\t", as.is=TRUE)

commits$sha1=NULL

# 2011-09-09 11:30:27
commits$utc_time=as.POSIXct(commits$utc_time, format="%Y-%m-%d %H:%M:%S")
commits$local_time=as.POSIXct(commits$local_time, format="%Y-%m-%d %H:%M:%S")

day_hrs=24
week_hrs=24*7
hr_deg=360/week_hrs

# 1-Jan-1970 is a Thursday
shift_weekend=3*day_hrs

week_commit=function(df)
{
local_time=as.numeric(df$local_time) %/% (60*60)

com_cir=circular(hr_deg*((local_time+shift_weekend) %% week_hrs),
			units="degrees")
}


# Linux
cir_linux=week_commit(subset(commits, repository_id == 1))
medianCircular(cir_linux)
trigonometric.moment(cir_linux, p=1)
trigonometric.moment(cir_linux, p=2)

# FreeBSD
cir_FreeBSD=week_commit(subset(commits, repository_id == 5))
trigonometric.moment(cir_FreeBSD, p=1)
trigonometric.moment(cir_FreeBSD, p=2)


