#
# 1706-01636a.R, 23 Dec 19
# Data from:
# Can Pairwise Testing Perform Comparably to Manually Handcrafted Testing Carried Out by Industrial Engineers?
# Peter Charbachi and Linus Eklund and Eduard Enoiu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human experiment_software testing coverage

source("ESEUR_config.r")


library("boot")


ex=read.csv(paste0(ESEUR_dir, "reliability/1706-01636a.csv.xz"), as.is=TRUE)

# Fit some regression models...

# Engineer time
et_mod=glm(Engineer.time ~ file_size*Inputs+file_size*Engineer.coverage+Engineer.test_sequence, data=ex)
summary(et_mod)

ea_mod=glm(Engineer.testamount ~ log(file_size)+Engineer.test_sequence, data=ex)
summary(ea_mod)

# PairWise time
pw_mod=glm(Pairwise.time ~ file_size*Pairwise.test_sequence, data=ex)
summary(pw_mod)

# Random time
rn_mod=glm(Random.time ~ file_size:(Random.coverage+Random.test_sequence)+Random.coverage:Random.test_sequence, data=ex)
summary(rn_mod)


# Use bootstrapping to check whether the means are likely to be different
ex_diff=function(df1, df2)
{
   mean_diff=function(res, indices)
   {
   t=res[indices]
   return(mean(t[1:num_ex])-mean(t[(num_ex+1):total_ex]))
   }

ex_boot=boot(c(df1, df2), mean_diff, R = 4999) # bootstrap

ex_mean_diff=mean(df1)-mean(df2) # Difference in sample means
# Two-sided test
E=length(ex_boot$t[abs(ex_boot$t) >= abs(ex_mean_diff)]) # == E

return((E+1)/(4999+1))
}

num_ex=nrow(ex)     # Size of each sample
total_ex=num_ex*2   # Total sample size

# Amount of coverage
ex_diff(ex$Engineer.coverage, ex$Pairwise.coverage)
ex_diff(ex$Engineer.coverage, ex$Random.coverage)

# Amount of time taken
ex_diff(ex$Engineer.time, ex$Pairwise.time)

