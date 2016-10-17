#
# agreement.R, 12 Oct 16
# Data from:
# Determining the Distribution of Maintenance Categories: Survey versus Measurement
# Stephen R. Schach and Bo Jin and Liguo Yu and Gillian Z. Heller and Jeff Offutt
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("irr")
library("plyr")

# Convert a contingency table into a list of values
contin_to_list=function(contin)
{
t_df=as.data.frame(as.table(contin))
# Yukky way of replicating a dataframe
t=adply(t_df, 1, function(df) df[rep(1, times=df$Freq[1]), ])
t$Freq=NULL
return(t)
}

cross_rater=read.csv(paste0(ESEUR_dir, "group-compare/agreement.csv"), as.is=TRUE)
rownames(cross_rater)=colnames(cross_rater)

kappa2(contin_to_list(data.matrix(cross_rater)))


#   agree=matrix(c(10,  0,
#                   0, 10), ncol=2)
#disagree=matrix(c( 0, 10,
#                  10,  0), ncol=2)

# Two sets of agreement with raters having the same number
# of agreements, but the disagreement being skewed in one set
#a1=matrix(c(40, 15,
#            20, 25), ncol=2)
#a2=matrix(c(40, 35,
#             0, 25), ncol=2)
#
#kappa2(contin_to_list(a1))
#kappa2(contin_to_list(a2))

# Very high agreement between raters can cause the Cohen's kappa
# and Scott's pi to have a negative value.
# ??? coefficient is a more reliable value in this case.
#highagree=matrix(c(118, 5,
#                     2, 0), ncol=2)
#kappa2(contin_to_list(highagree))


# Data from: An Empirical Study on the Maintenance of Source Code Clones
# Suresh Thummalapenta and Luigi Cerulo and Lerina Aversano and Massimiliano Di Penta
# Contingency matrix for evolution clones found in JBOSS by token and ATS matching
# jboss=t(matrix(c(
#   24,  25,   2,   1,   2, 
#   35,  52,   2,   1,   4, 
#    2,   7,   0,   0,   0, 
#    0,   0,   0,   0,   1, 
#    3,   0,   0,   0,   0), ncol=5))
# 


