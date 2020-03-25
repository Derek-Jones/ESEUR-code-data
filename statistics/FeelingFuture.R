#
# FeelingFuture.R,  7 Mar 20
# Data from:
# Feeling the Future: {Experimental} Evidence for Anomalous Retroactive Influences on Cognition and Affect
# Daryl J. Bem
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human ESP

source("ESEUR_config.r")

# The average over each subject's 36 trials was made available
ff=read.csv(paste0(ESEUR_dir, "statistics/FeelingFuture.csv.xz"), as.is=TRUE)


# What does the bootstrap have to say?

median_perc=function(df)
{
samp=sample(length(df), replace=TRUE)
return(median(df[samp]))
}


erotic_med=median(ff$erotic)
neutral_med=median(ff$neutral)

eb=replicate(4999, median_perc(ff$erotic))

100*length(which(eb >= erotic_med))/(1+length(eb))
# 54.21 - nothing special

nb=replicate(4999, median_perc(ff$neutral))

100*length(which(nb <= neutral_med))/(1+length(nb))
# 61.54 - nothing special

# There are 51 subjects performing better than chance on erotic
length(which(ff$erotic > 0.5))

# Median erotic is 53.3, which is what the paper reports
median(ff$erotic)

# The paper uses a binomial test, and assumes one-sided.
# They must be doing a binomial test on data other than that made available.
# There is no way this is significant for the data provided.
binom.test(length(which(ff$erotic > 0.5)), 100, alternative="less")

