#
# 2002-02672.R,  7 Mar 20
# Data from:
# How do Quantifiers Affect the Quality of Requirements?
# Katharina Winter and Henning Femmer and Andreas Vogelsang
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human requirements_experiment language_quantifier

source("ESEUR_config.r")


library("plyr")
library("vioplot")

# # Bootstrap checking for significance of difference in means
#
# diff_mean=function(df)
# {
#    mean_diff=function(responses, num_aff, num_neg)
#    {
#    resp_len=length(responses)
#    aff_mean=mean(responses[sample(resp_len, size=num_aff, replace=TRUE)])
#    neg_mean=mean(responses[sample(resp_len, size=num_neg, replace=TRUE)])
#    return(neg_mean-aff_mean)
#    }
# 
# 
# aff=subset(df, syntax == "affirmative")
# neg=subset(df, syntax == "negative")
# act_diff=mean(neg$Answer.Time.ms)-mean(aff$Answer.Time.ms)
# 
# an_diff=replicate(4999, mean_diff(df$Answer.Time.ms,
# 					nrow(aff), nrow(neg)))
# 
# # How many bootstrap samples are greater than or equal to the
# # difference actually seen?
# return(length(which(act_diff <= an_diff)))
# }
# 
# 
#
# # Are answers to affirmative requirements more likely to be correct?
# an_correct=function(df)
# {
#    mean_diff=function(responses, num_aff, num_neg)
#    {
#    resp_len=length(responses)
#    aff_mean=mean(responses[sample(resp_len, size=num_aff, replace=TRUE)])
#    neg_mean=mean(responses[sample(resp_len, size=num_neg, replace=TRUE)])
#    return(aff_mean-neg_mean) # expect this to be posiitve
#    }
# 
# 
# aff=subset(df, syntax == "affirmative")
# neg=subset(df, syntax == "negative")
# act_diff=mean(aff$Correctness)-mean(neg$Correctness) # difference seen
# 
# an_diff=replicate(4999, mean_diff(df$Correctness,
#	 				nrow(aff), nrow(neg)))
# 
# # How many bootstrap samples are greater than or equal to the
# # difference actually seen?
# return(length(which(act_diff <= an_diff)))
# }
# 

afq=read.csv(paste0(ESEUR_dir, "reliability/2002-02672.csv.xz"), as.is=TRUE, sep=";")

afq$Answer.Time.ms=afq$Answer.Time.ms/1e3
# Remove some outliers
afq=subset(afq, (Answer.Time.ms > 2) & (Answer.Time.ms < 100))

# 
# d=ddply(afq, .(scope), diff_mean)
# d
#
#       scope   V1
# 1       All    0
# 2   All but 4994
# 3  At least   28
# 4   At most 2288
# 5 Exactly n    0
# 6 Less than  189
# 7 More than  372
# 8      None 4960
# 9       One    0

# 
# aff=subset(afq, syntax == "affirmative")
# neg=subset(afq, syntax == "negative")
# 
# mean(aff$Correctness)
# mean(neg$Correctness)
# 
# d=ddply(afq, .(scope), an_correct)
# d
#       scope   V1
# 1       All   12
# 2   All but 4801
# 3  At least  137
# 4   At most 2677
# 5 Exactly n   39
# 6 Less than   19
# 7 More than 4999
# 8      None 1943
# 9       One 1248

# Use 'syn' so there is no confusion with use of 'syntax' in bootstrap
afq$syn=mapvalues(afq$syntax, c("affirmative", "negative"), c("aff", "neg"))

num_scope=length(unique(afq$scope))
brew_col=rainbow(num_scope*2)
colMed_str=rep(c("white", "black"), num_scope)

vioplot(Answer.Time.ms ~ syn+scope, data=afq,
        horizontal=TRUE, cex.axis=1.0, cex=1, # cex needed for cex.axis to work
        col=brew_col, border=brew_col, colMed=colMed_str, lineCol="grey",
        # line=FALSE,
	# plotCenter="line",
	xaxs="i", xlog=TRUE,
        xlab="Response time (seconds)", ylab="")

