#
# dev-commit.R, 28 Oct 14
#
# Estimate standard deviation for number of contributors to
# a given version of Linux.
# Data from:
# github.com/gregkh/kernel-history
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

rel_sd=function(df)
{
start_date=min(df$first.date)
end_date=max(df$first.date)
num_devs=nrow(df)

#print(start_date); print(end_date); print(num_devs)

# How many contributions from first time developers
# within the last 5% of the development period?
# rel_var=(end_date-start_date+1)/20
# or last 14 days?
rel_var=14

num_dev=nrow(subset(df, first.date > end_date-rel_var))

# Standard deviation of a uniform distribution
dev_sd=num_dev/sqrt(12)

# print(dev_sd)

# Multiple by 2 because the release might have happened later
# than it did, ie we want a distribution around the actual date.
# Could be clever and figure out something more realistic than 2
dev_sd=2*dev_sd

return(c(num_devs, num_dev, dev_sd))
}


# author,count,first date,release
la=read.csv(paste0(ESEUR_dir, "regression/clean/dev-commit.csv.xz"), as.is=TRUE)

la$first.date=as.Date(la$first.date, format="%b-%d-%Y")

rel_sum=ddply(la, .(release), rel_sd)

mean(rel_sum$V3)

