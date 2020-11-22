#
# memoization.R,  2 Feb 20
# Data from:
# Intercepting Functions for Memoization: {A} Case Study Using Transcendental Functions
# Arjun Suresh and Bharath Narasimha Swamy and Erven Rohou and Andr{\'e} Seznec
#
# Example from:
# Evidence-based Software Engineering: based on the available data
# Derek M. Jones
#
# TAG runtime_time-series argument_value Bessel-function_use


source("ESEUR_config.r")


j0=read.csv(paste0(ESEUR_dir, "sourcecode/memoization.csv.xz"), as.is=TRUE)

acf(diff(j0$argument), lag=100, col=point_col,
	xlab="Lag (calls to j0)", ylab="ACF\n")

