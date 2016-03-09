#
# cpu-freq-over-time.R,  4 Jul 14
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
line_smoother=function(x_vals, y_vals)
{
# lines(supsmu(x_vals, y_vals, span=0.1))
# return(NULL)

# loess.smooth automatically handles NA
lines(loess.smooth(x_vals, y_vals, span=0.05), col=pal_col[1])

# smooth.spline and runmed don't handle NA
t=!is.na(x_vals)
x_vals=x_vals[t]
y_vals=y_vals[t]
t=!is.na(y_vals)
x_vals=x_vals[t]
y_vals=y_vals[t]

lines(smooth.spline(x_vals, y_vals, spar=0.7), col=pal_col[2])

t=order(x_vals)
lines(x_vals[t], runmed(y_vals[t], k=9), col=pal_col[3])
}

processor=read.csv(paste0(ESEUR_dir, "ecosystem/cpudb/processor.csv.xz"), as.is=TRUE)

all=processor

# fix missing date entries 
all[all[["date"]]=="","date"]=NA
dates=as.POSIXct(all[["date"]])

# account for potential turbo-boost clock
noturbo=is.na(all[["max_clock"]])
all[noturbo,"max_clock"]=all[noturbo, "clock"]

# scaling factor is minimum frequency
scaleclk  =min(all[["max_clock"]], na.rm=TRUE)

ratio_change=all[["max_clock"]]/scaleclk

plot(dates, ratio_change, log="y", col=point_col,
	xlab="Date of introduction", ylab="Relative frequency increase\n")
line_smoother(dates, ratio_change)

legend("topleft",
       c("loess.smooth", "smooth.spline", "runmed"),
       bty="n", fill=pal_col, cex=1.4)


