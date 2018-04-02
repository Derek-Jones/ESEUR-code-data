#
# a206293.R, 16 Dec 17
# Data from:
# An Experimental Investigation into Software Reliability
# Amrit L. Goel
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# Cross checking of values
chk_cnt=function(row)
{
total=0
sapply(f_num, function(X)
		{
		f=strsplit(row[X], " ")[[1]]
		cnts=strsplit(row[X+1], " ")[[1]]
		total <<- total+length(f)
		if (length(f) != cnts[1]) print(c(1, cnts[1], X))
		if (total != cnts[2]) print(c(2, cnts[2], X))
		})
}


a206=read.csv(paste0(ESEUR_dir, "reliability/a206293.csv.xz"), as.is=TRUE)

f_num=seq(1, 107, by=2)

dummy=chk_cnt(a206$FL1)
dummy=chk_cnt(a206$FL2)
dummy=chk_cnt(a206$AL1)
dummy=chk_cnt(a206$AL2)
dummy=chk_cnt(a206$AL3)


