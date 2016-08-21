#
# covrig.R,  8 Jan 16
#
# Data from:
# COVRIG: A Framework for the Analysis of Code, Test, and Coverage Evolution in Real Software
# Paul Marinescu and Petr Hosek and Cristian Cadar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# par(fin=c(4.5, 3.5))

library("plyr")


bench=read.csv(paste0(ESEUR_dir, "reliability/covrig.csv.xz"), as.is=TRUE)

bench=subset(bench, x3 != "compileError")

secs_per_year=60*60*24*365.25
bench$time=as.numeric(bench$time)/secs_per_year+1970
bench$cov_ratio=100*bench$coverage/bench$eloc
bench$br_cov_ratio=100*bench$brcov/bench$br

# Emailed the authors about problems with the data.
# Was told that they have moved onto other things.
prog=subset(bench, program != "Binutils")

# library("lattice")
# xyplot(cov_ratio ~ time | program, data=prog,
#	col=point_col, pch=point_pch, type="b",
# 	xlab="Year", ylab="Coverage")

xrange=range(prog$time, na.rm=TRUE)

all_progs=function(df)
{
points(df$time, df$cov_ratio,
	col=pal_col[col_num], pch=2)
points(df$time, df$br_cov_ratio,
	col=pal_col[col_num], pch="*")
col_num <<- col_num+1
}


pal_col=rainbow(length(unique(prog$program)))

plot(1, type="n",
	xlim=xrange, ylim=c(0, 82),
	xlab="Year", ylab="Statement coverage\n")
col_num=1
d_ply(prog, .(program), all_progs)

legend(x="bottomleft", legend=unique(prog$program),
			bty="n", fill=pal_col, cex=1.2)

