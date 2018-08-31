#
# memoization.R, 12 Aug 18
# Data from:
# Intercepting Functions for Memoization: {A} Case Study Using Transcendental Functions
# Arjun Suresh and Bharath Narasimha Swamy and Erven Rohou and Andr{\'e} Seznec
#
# Example from:
# Evidence-based Software Engineering: based on the available data
# Derek M. Jones
#
# TAG runtime argument bessel


source("ESEUR_config.r")


j0=read.csv(paste0(ESEUR_dir, "sourcecode/memoization.csv.xz"), as.is=TRUE)

acf(diff(j0$argument), lag=100)

