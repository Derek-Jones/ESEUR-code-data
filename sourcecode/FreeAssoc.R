#
# FreeAssoc.R, 28 May 18
# Data from:
# The University of {South Florida} Word Association, Rhyme and Word Fragment Norms
# Douglas L. Nelson and Cathy L. McEvoy and Thomas A. Schreiber
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAGS words experiment human memory

source("ESEUR_config.r")


library("plyr")


# Words only given by one subject don't appear in the data.
# But the total number of subjects is given.
percent_one_use=function(df)
{
total=sum(df$X.P)

one_use=(df$X.G[1]-total)/df$X.G[1]

return(one_use)
}


percent_usage=function(df)
{
usage=rep(0, 1000)

total=sum(df$X.P)

# Approximate the probability for each percentage likelihood.
bins=count(trunc(1e3*df$X.P/df$X.G))
usage[bins$x]=bins$x*bins$freq/1e3

# Using 1,000 bins improves resolution, need to reduce it
# to 100 bins (for a percentage).
u100=sapply(0:99, function(X) sum(usage[(1:10)+X*10]))

return(u100)
}


FA=read.csv(paste0(ESEUR_dir, "sourcecode/FreeAssoc.csv.xz"), as.is=TRUE)


t=daply(FA, .(CUE), percent_usage)

mean_use=colMeans(t)
plot(mean_use, log="xy", col=point_col,
	xaxs="i", yaxs="i",
	xlim=c(0.9, 100),
	xlab="Subjects (percentage)", ylab="Probability\n")

# one_use=ddply(FA, .(CUE), percent_one_use)
# mean(one_use$V1)
# sd(one_use$V1)

