#
# iiswc2008-i686.R,  9 Mar 14
#
# Data from:
# Can Hardware Performance Counters be Trusted?
# Vincent M. Weaver and Sally A. McKee
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")

i686=read.csv(paste0(ESEUR_dir, "benchmark/iiswc2008-i686.csv.xz"), as.is=TRUE)

brew_col=rainbow(3)


mean_sd=function(df)
{
t=df[1, ]
t$run=NULL
t$instr=NULL
t$mean=mean(df$instr)
t$sd=sd(df$instr)
t$perc=100*t$mean/t$sd

return(t)
}


# Find mean, sd and their ratio over each unique run
tot=ddply(i686, .(cpu, prog, input), mean_sd)

# Plot sd/mean
plot(sort(tot$perc), log="y", col=point_col,
	ylab="mean/sd\n")

# pairs(~ perc + cpu+prog, data=tot)
sd_mod=glm(perc ~ cpu+prog, data=tot)

