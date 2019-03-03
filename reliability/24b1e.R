#
# 24b1e.R, 14 Jan 19
# Data from:
# "James R. Lewis
# Evaluation of Procedures for Adjusting Problem-Discovery Rates Estimated From Small Samples
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human usability

source("ESEUR_config.r")

library("plyr")


pal_col=rainbow(4)


# How many problems were found by the people selected?
probs_found=function(df)
{
t=apply(df, 1, function(X) as.numeric(sum(X) != 0))

return(sum(t))
}


# Generate all poissible combinations of subjects, counting all problems
# found and plot the probability of finding a given number of problems.
plot_group=function(grp_size)
{
g=combn(num_subj, grp_size, function(X) probs_found(usis[ , X]))

totals=count(g)
lines(totals$x, totals$freq/length(g), col=pal_col[grp_size-1])
}

# Impact
# 1. Scenario failure. Participants failed to successfully complete a scenario
# if they either requested help to complete it or produced an incorrect output
# (excluding minor typographical errors).
# 2. Considerable recovery effort. The participant either worked on error
# recovery for more than a minute or repeated the error within a scenario.
# 3. Minor recovery effort. The participant experienced the problem only once
# within a scenario and required less than a minute to recover.
# 4. Inefficiency. The participant worked toward the scenario’s goal but deviated
# from the most efficient path.

usis=read.csv(paste0(ESEUR_dir, "reliability/24b1e.csv.xz"), as.is=TRUE)

usis$Prob=NULL
usis$Impact=NULL

# rs=rowSums(usis)
# table(rs)

num_subj=ncol(usis)

# p2=combn(num_subj, 2, function(X) probs_found(usis[ , X]))
# plot(table(p2))
# 
# p3=combn(num_subj, 3, function(X) probs_found(usis[ , X]))
# plot(table(p3))


plot(1, type="n", log="y",
	yaxs="i",
	xlim=c(15, 100), ylim=c(3e-4, 1e-1),
	xlab="Issues found", ylab="Probability\n")

plot_group(5)
plot_group(4)
plot_group(3)
plot_group(2)

legend(x="bottomright", legend=paste0("Reviewers=", 2:5), bty="n", fill=pal_col, cex=1.2)

