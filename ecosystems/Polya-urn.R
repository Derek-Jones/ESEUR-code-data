#
# Polya-urn.R, 21 Aug 19
# Data from:
# Example
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Polya-urn example population_converge

source("ESEUR_config.r")


Polya_once=function()
{
exist_col=sample(urn, 1)
urn <<- c(urn, exist_col) # Add a ball of the same color
}


# Return percentage of the most common ball
subpop_perc=function(df)
{
wb=table(df)
perc=ifelse(wb[1] > wb[2], wb[1], -wb[2])/length(df)

return(perc)
}


# A Polya urn process
Polya_urn_process=function()
{
urn <<- c("w", "b") # A global variable :-O

t=replicate(max_iterate, Polya_once())

# table(urn)

pop_perc=unlist(lapply(t, subpop_perc))
lines(pop_perc, col=point_col)
}

max_iterate=500

plot(0, type="n",
	xlim=c(1, max_iterate), ylim=c(-1, 1),
	xlab="Iteration", ylab="Most common ball (fraction)\n")

t=replicate(20, Polya_urn_process())


