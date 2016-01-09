#
# agreement.R,  8 Jul 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library(irr)


# Convert a continuity table into a list of values
contin_to_list=function(contin)
{
t_df=as.data.frame(as.table(contin))
t=adply(t_df, 1, function(df) df[rep(1, times=df$Freq[1]), ])
t$Freq=NULL
return(t)
}


   agree=matrix(c(10,  0,
                   0, 10), ncol=2)
disagree=matrix(c( 0, 10,
                  10,  0), ncol=2)

chisq_test(as.table(agree))
chisq_test(as.table(disagree))

# Two sets of agreement with raters having the same number
# of agreements, but the disagreement being skewed in one set
a1=matrix(c(40, 15,
            20, 25), ncol=2)
a2=matrix(c(40, 35,
             0, 25), ncol=2)

kappa2(contin_to_list(a1))
kappa2(contin_to_list(a2))

# Very high agreement between raters can cause the Cohen's kappa
# and Scott's pi to have a negative value.
# ??? coefficient is a more reliable value in this case.
highagree=matrix(c(118, 5,
                     2, 0), ncol=2)
kappa2(contin_to_list(highagree))


# Data from Schach et al <book Schach_03> "Table 7. The cross-rater
# reliability analysis for the first 20 versions of the Linux kernel at
# the change-log level."

cross_rater=matrix(
   c( 2,        0,          0,         0 ,
      0,       82,         16,         0 ,
      0,        5,         99,         2 ,
      0,        0,          0,         9), ncol=4)

kappa2(contin_to_list(cross_rater))

# Data from ???, cannot find reference to paper this came from...
# Contingency matrix for evolution clones found in JBOSS by token and ATS matching
# jboss=t(matrix(c(
#   24,  25,   2,   1,   2, 
#   35,  52,   2,   1,   4, 
#    2,   7,   0,   0,   0, 
#    0,   0,   0,   0,   1, 
#    3,   0,   0,   0,   0), ncol=5))
# 


