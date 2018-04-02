#
# covrig.R, 17 Feb 18
#
# Data from:
# COVRIG: A Framework for the Analysis of Code, Test, and Coverage Evolution in Real Software
# Paul Marinescu and Petr Hosek and Cristian Cadar
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


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


all_progs=function(df)
{
points(df$time, df$cov_ratio, col=df$col_str)

# points(df$time, df$br_cov_ratio, col=df$col_str, pch="*")
}

prog_names=unique(prog$program)

pal_col=rainbow(length(prog_names))

prog$col_str=mapvalues(prog$program, prog_names, pal_col)

plot(1, type="n",
	xlim=range(prog$time, na.rm=TRUE), ylim=c(0, 82),
	xlab="Year", ylab="Statement coverage\n")
d_ply(prog, .(program), all_progs)

legend(x="bottomleft", legend=prog_names, bty="n", fill=pal_col, cex=1.2)

