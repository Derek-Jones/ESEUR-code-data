#
# AD0766061.R, 24 Jun 17
# Data from:
# Report to The President and the Secretary of Defense on the Department of Defense
# Blue Ribbon Defense Panel
# AD0766061, July 1970
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(3)


mk_plot=function(df)
{
points(df$Job.Time, df$Monthly.Rent..., col=pal_col[df$Job.Type])
}


bench=read.csv(paste0(ESEUR_dir, "ecosystems/AD0766061.csv.xz"), as.is=TRUE)

# Job.Type
# ... performing one of three generalized computer applications.
# These applications include sorting 10,000 records,
# posting 10,000 transactions to a master file on tape, and
# posting 10,000 transactions to a master file on disc.
#
# The monthly lease cost is divided by 40,000 (the approximate
# number of minutes in a month) giving the cost per minute of
# the computer and maintenance.
#
# Lots of small errors in:
# 100*Computer.Cost... == Cost.Minute.cents.*Job.Time
#
# One calculation is off by 1 cent, another by 1 dollar:
# Total.Job.Cost... == Computer.Cost...+Labor.cost...
#
# The cost for personnel, supplies, space, power, air conditioning,
# and physical security is based on the size of the computer system
# as follows:
#  Less than $10,000 per month 20cents per minute
#  $10,001 to $20,000 per month 25cents per minute
#  $20,001 to $30,000 per month 30cents per minute
#  $30,001 to $50,000 per month 35cents per minute
#  $50,001 to $99,000 per month 40cents per minute

plot(bench$Job.Time, bench$Monthly.Rent..., type="n", log="x")

d_ply(bench, .(Job.Type), mk_plot)


