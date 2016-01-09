#
# proj-bidding.R,  3 Jun 14
#
# Data from:
# An Empirical Study of Software Project Bidding
# Magne Jørgensen and Gunnar J. Carelius
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


a_pre=read.csv(paste0(ESEUR_dir, "economics/project-bid/project-bidding.a_pre"), as.is=TRUE, strip.white=TRUE)
a_post=read.csv(paste0(ESEUR_dir, "economics/project-bid/project-bidding.a_post"), as.is=TRUE, strip.white=TRUE)
b=read.csv(paste0(ESEUR_dir, "economics/project-bid/project-bidding.b"), as.is=TRUE, strip.white=TRUE)

c_pre=read.csv(paste0(ESEUR_dir, "economics/project-bid/project-workhours.c_pre"), as.is=TRUE, strip.white=TRUE)
c_post=read.csv(paste0(ESEUR_dir, "economics/project-bid/project-workhours.c_post"), as.is=TRUE, strip.white=TRUE)
d=read.csv(paste0(ESEUR_dir, "economics/project-bid/project-workhours.d"), as.is=TRUE, strip.white=TRUE)

plot(sort(a_pre[,1]), col="red", ylab="Amounts bid", xlab="")
plot(sort(a_post[,1]), col="red", ylab="Amounts bid", xlab="")
plot(sort(b[,1]), col="red", ylab="Amounts bid", xlab="")

# Are the samples drawn from a population having a normal distribution?
shapiro.test(a_pre[,1])
shapiro.test(a_post[,1])
shapiro.test(b[,1])

# Do the samples have the same variance?
ansari.test(a_pre[,1], a_post[,1])
ansari.test(a_pre[,1], b[,1])
ansari.test(b[,1], a_post[,1])

# Two sets of bids from the same subjects
wilcox.test(a_pre[,1], a_post[,1], conf.int=TRUE, paired=TRUE)

# Two sets of bids from different subjects
wilcox.test(a_pre[,1], b[,1], conf.int=TRUE)       # First bids from A and B
wilcox.test(b[,1], a_post[,1], conf.int=TRUE)      # Only bid from B and second from A

# Compare second bids from Small/Large companies
wilcox.test(a_post[a_post[,2]=="Small",1], a_post[a_post[,2]=="Large",1], conf.int=TRUE)


# Estimates of work-hours

# Are the samples drawn from a population having a normal distribution?
shapiro.test(c_pre[,1])
shapiro.test(c_post[,1])
shapiro.test(d[,1])

# Do the samples have the same variance?
ansari.test(c_pre[,1], c_post[,1])
ansari.test(c_pre[,1], d[,1])
ansari.test(d[,1], c_post[,1])

wilcox.test(c_pre[,1], c_post[,1], conf.int=TRUE, paired=TRUE)  # Two estimates from C

wilcox.test(c_pre[,1], d[,1], conf.int=TRUE)       # First estimate from C and D
wilcox.test(d[,1], c_post[,1], conf.int=TRUE)      # Only estimate from D and second from C

# Data from: Variability and Reproducibility in Software
# Engineering: A Study of Four Companies that Developed the Same System
# By Bente C.D. Anda, Dag I.K. Sjøberg and Audris Mockus.
# Note: Bids are in Euro not Norwegian Krona here.

# Those bidders who also submitted an estimate of the number of days
estimate.days=c(14, 28, 18, 94, 77, 91, 30, 49, 45, 77, 42, 77, 63, 49)
bid.amount=c(2630, 4970, 8750, 11880, 12190, 18510, 20000, 33250, 26880,
               28700, 28950, 33880, 38360, 69060)
plot(estimate.days, bid.amount)

# Are sample subsets each drawn from a population having a normal distribution?
shapiro.test(estimate.days[estimate.days < 65])
shapiro.test(bid.amount[estimate.days < 65])
cor.test(estimate.days[estimate.days < 65], bid.amount[estimate.days < 65])

# Is the complete sample drawn from a population having a normal distribution?
shapiro.test(estimate.days)
t.test(estimate.days, conf.int=TRUE)
wilcox.test(estimate.days, conf.int=TRUE)
min(estimate.days)
max(estimate.days)

# Four bids accepted
devel_info=read.csv(paste0(ESEUR_dir, "economics/project-bid/project-develop.txt.xz"), as.is=TRUE, strip.white=TRUE)

wilcox.test(devel_info$scheduled.days, conf.int=TRUE)
# Actual days
wilcox.test(devel_info$actual.days, conf.int=TRUE)

plot(devel_info$agreed.price, devel_info$LOC)
plot(devel_info$actual.days, devel_info$LOC)

