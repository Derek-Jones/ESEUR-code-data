#
# FreeAssoc.R, 28 May 20
# Data from:
# The University of {South Florida} Word Association, Rhyme and Word Fragment Norms
# Douglas L. Nelson and Cathy L. McEvoy and Thomas A. Schreiber
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAGS word_association experiment_human memory_association

source("ESEUR_config.r")


library("plyr")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

# Words only given by one subject don't appear in the data.
# But the total number of subjects is given.
percent_one_use=function(df)
{
total=sum(df$X.P)

one_use=100*(df$X.G[1]-total)/df$X.G[1]

return(one_use)
}


percent_usage=function(df)
{
usage=rep(0, 1000)

# The probability that 2:10 subjects will choose the same word.
# In the data, many words are only ever choosen by two people,
# assume that this number scales with sample size (the contribution
# from these cases is tiny anyway).
L10=100*sapply(2:10, function(X) sum((df$X.P/df$X.G)^X))

# Approximate the probability for each percentage likelihood.
usage[round(1000*(2:10)/df$X.G)]=L10

# Using 1,000 bins improves resolution, need to reduce it
# to 100 bins (for a percentage).
u100=sapply(0:99, function(X) sum(usage[(1:10)+X*10]))

return(u100)
}

# CUE: word subjects' see
# TARGET: Response word given
# X.G: Number of subjects seeing CUE
# X.P: Number of subjects responding with TARGET
FA=read.csv(paste0(ESEUR_dir, "sourcecode/FreeAssoc.csv.xz"), as.is=TRUE)


t=daply(FA, .(CUE), percent_usage)

mean_use=colMeans(t)
plot(mean_use, log="y", col=point_col,
	xaxs="i",
	xlim=c(1, 12),
	xlab="Subjects (percentage)", ylab="Same word (probability)\n\n")

# one_use=ddply(FA, .(CUE), percent_one_use)
# mean(one_use$V1)
# sd(one_use$V1)

