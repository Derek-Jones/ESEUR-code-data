#
# feat-per-day-7dig.R, 14 Feb 16
#
# Various analysis of http://www.7digital.com feature data
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


source(paste0(ESEUR_dir, "projects/agile-work/feat-common-7dig.R"))


# How many feature implementations are started on each day?
t=sum_starts(p$Dev.Started)
t=count(t[-weekends])
t$average=t$freq/sum(t$freq)


library("ascii")

res=rbind(t$x, signif(t$average, digits=2))

print(ascii(res[ ,1:10]))

