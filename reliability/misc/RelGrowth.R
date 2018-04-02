#
# RelGrowth.R, 14 Dec 17
# Data from:
# Reliability Growth in Software Products
# Pankaj Jalote and Brendan Murphy
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


rg=read.csv(paste0(ESEUR_dir, "reliability/RelGrowth.csv"), as.is=TRUE)


# A negative correlation!  At least the lag -1 is expected.
ccf(rg$Total_failures, rg$Monthly_Sales, lag.max=4,
	ylab = "Cross-correlation\n")

# acf(rg$Total_failures)

