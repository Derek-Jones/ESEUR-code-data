#
# eigentaste.R,  4 Apr 20
# Data from:
# Eigentaste: {A} Constant Time Collaborative Filtering Algorithm
# Ken Goldberg and Theresa Roeder and Dhruv Gupta and Chris Perkins
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human jokes


source("ESEUR_config.r")


library("gnm")


pal_col=rainbow(2)


# This is the JesterDataset3
jr=read.csv(paste0(ESEUR_dir, "probability/eigentaste.csv.xz"), as.is=TRUE)

# There are some odd looking counts after 127.
# They are ignored.
plot(jr, log="y", col=pal_col[2],
	xaxs="i",
	xlim=c(7.9, 127), ylim=c(20, 1e4),
	xlab="Jokes rated", ylab="Subjects\n")

# Get rid of the spikes at 8 and 128
jr10=subset(jr, (rated > 8) & (rated < 128))

# Initial values are a long way from the converged solution,
# but closer values produce pecular fits
acc_mod=gnm(freq ~ instances(Mult(1, Exp(rated)), 2)-1,
                data=jr10, verbose=FALSE,
                start=c(1e6, -0.6, 2500.3, -0.1))
# summary(acc_mod)

exp_coef=as.numeric(coef(acc_mod))

# lines(jr10$rated, exp_coef[1]*exp(exp_coef[2]*jr10$rated), col=pal_col[2])
# lines(jr10$rated, exp_coef[3]*exp(exp_coef[4]*jr10$rated), col=pal_col[3])
t=predict(acc_mod)
lines(jr10$rated, t, col=pal_col[1])


# library("pracma")
#
# # A different fit, constant offset makes a difference
# me_mod=mexpfit(jr10$rated, jr10$freq, p0=c(-0.9, -0.1))
# print(me_mod)

# The following code was used to extract the needed data from the original
# Jester csv files (after they were extracted from the xls files)
#
# library("plyr")
# library("reshape2")
# 
# 
# get_counts=function(jnum)
# {
# #j=read.csv(paste0("jester-data-", jnum, ".csv"), header=FALSE)
# j=read.csv("FINAL jester 2006-15.csv", header=FALSE)
# 
# j$V1=NULL
# j$ID=1:nrow(j)
# 
# jl=melt(j, id.vars="ID", variable.name="joke", value.name="rating")
# 
# jc=subset(jl, rating != 99)
# jcs=jc[order(jc$ID), ]
# 
# num_id=count(count(jcs$ID)$freq)
# 
# write.csv(num_id, file=paste0("/usr1/ESEUR/jcs", jnum, ".csv"), row.names=FALSE)
# }
# 
# 
# get_counts(1)
# get_counts(2)
# get_counts(3)
# get_counts(4)
# 
# 
