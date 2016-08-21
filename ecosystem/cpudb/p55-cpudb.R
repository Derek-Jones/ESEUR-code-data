#
# p55-cpudb.R, 21 Feb 16
#
# Data from:
# CPU DB: Recording Microprocessor History
# Andrew Danowitz and Kyle Kelley and James Mao and John P. Stevenson and Mark Horowitz
# Modified version of source downloaded  4 July 2014 from:
#  http://cpudb.stanford.edu/download
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)


# Plot the points and fit a smooth curve
points_and_smooth=function(x_vals, y_vals, col_num, pch)
{
points(x_vals, y_vals, col=pal_col[col_num], bg=2, pch=pch, cex=0.7)

# lines(supsmu(x_vals, y_vals, span=0.1))
# return(NULL)
# 
# t=!is.na(x_vals)
# x_vals=x_vals[t]
# y_vals=y_vals[t]
# t=!is.na(y_vals)
# x_vals=x_vals[t]
# y_vals=y_vals[t]
# 
# t=order(x_vals)
# 
# lines(x_vals[t], runmed(y_vals[t], k=25))
# 
# return(NULL)
# 
# lines(smooth.spline(x_vals, y_vals, spar=0.7), col="black")
}

# read in CSV tables
processor=read.csv(paste0(ESEUR_dir, "ecosystem/cpudb/processor.csv.xz"), as.is=TRUE)
specint2k6=read.csv(paste0(ESEUR_dir, "ecosystem/cpudb/spec_int2006.csv.xz"), as.is=TRUE)
specint2k0=read.csv(paste0(ESEUR_dir, "ecosystem/cpudb/spec_int2000.csv.xz"), as.is=TRUE)
specint95=read.csv(paste0(ESEUR_dir, "ecosystem/cpudb/spec_int1995.csv.xz"), as.is=TRUE)
specint92=read.csv(paste0(ESEUR_dir, "ecosystem/cpudb/spec_int1992.csv.xz"), as.is=TRUE)

# merge spec scores
all=merge(processor, specint2k6, by="processor_id",
             suffixes=c(".proc", ".spec_int2k6"), all=TRUE)
all=merge(all, specint2k0, by="processor_id",
             suffixes=c(".spec_int2k6", ".spec_int2k0"), all=TRUE)
all=merge(all, specint95, by="processor_id",
             suffixes=c(".spec_int2k0", ".spec_int95"), all=TRUE)
all=merge(all, specint92, by="processor_id",
             suffixes=c(".spec_int95", ".spec_int92"), all=TRUE)

# fix missing date entries 
all[all[["date"]]=="","date"]=NA
dates=as.POSIXct(all[["date"]])

# account for potential turbo-boost clock
noturbo=is.na(all[["max_clock"]])
all[noturbo,"max_clock"]=all[noturbo, "clock"]

# determine scaling factors for spec92->spec95,
# spec95->spec2k0, and spec2k0->spec2k6
spec92to95=mean(all[["basemean.spec_int95"]]/all[["basemean.spec_int92"]], na.rm=TRUE)
spec95to2k0=mean(all[["basemean.spec_int2k0"]]/all[["basemean.spec_int95"]], na.rm=TRUE)
spec2k0to2k6=mean(all[["basemean.spec_int2k6"]]/all[["basemean.spec_int2k0"]], na.rm=TRUE)

no95=is.na(all[["basemean.spec_int95"]])
no2k0=is.na(all[["basemean.spec_int2k0"]])
no2k6=is.na(all[["basemean.spec_int2k6"]])
all[no95, "basemean.spec_int95"]=spec92to95 * all[no95, "basemean.spec_int92"]
all[no2k0,"basemean.spec_int2k0"]=spec95to2k0 * all[no2k0, "basemean.spec_int95"]
all[no2k6, "basemean.spec_int2k6"]=spec2k0to2k6 * all[no2k6, "basemean.spec_int2k0"]

# performance
all[["perfnorm"]]=all[["basemean.spec_int2k6"]]/all[["tdp"]]

# find the scaling factors
scaleclk  =min(all[["max_clock"]], na.rm=TRUE)
scaletrans=min(all[["transistors"]], na.rm=TRUE)
scaletdp  =min(all[["tdp"]], na.rm=TRUE)
scaleperf =min(all[["basemean.spec_int2k6"]], na.rm=TRUE)
scaleperfnorm =min(all[["perfnorm"]], na.rm=TRUE)

# make the plot
plot(dates, all[["transistors"]]/scaletrans, log="y", col=pal_col[1], bg=1, pch=22,
	xlab="Date of introduction", ylab="Relative frequency increase\n")
points_and_smooth(dates, all[["transistors"]]/scaletrans, 1, 22)
points_and_smooth(dates, all[["max_clock"]]/scaleclk, 2, 20)
points_and_smooth(dates, all[["tdp"]]/scaletdp, 3, 24)

# points_and_smooth(dates, all[["basemean.spec_int2k6"]]/scaleperf, 4, 20)
# points(dates, all[["perfnorm"]]/scaleperfnorm, col=5, bg=5, pch=20, cex=0.7)

legend("topleft",
       c("Transistors", "Clock", "Power"),
       bty="n", fill=pal_col, cex=1.2)


