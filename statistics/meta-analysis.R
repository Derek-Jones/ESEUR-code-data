#
# meta-analysis.R, 11 Sep 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example meta-analysis

source("ESEUR_config.r")


pooled_mean=function(df)
{
return(sum(df$s_n*df$s_mean)/sum(df$s_mean))
}


pooled_sd=function(df)
{
return(sqrt(sum(df$s_sd^2*(df$s_n-1))/sum(df$s_n-1)))
}



studies=data.frame(s_n=c(5, 10, 20),
		   s_mean=c(30, 31, 32),
		   s_sd=c(5, 4, 3))

pooled_mean(studies)
pooled_sd(studies)


