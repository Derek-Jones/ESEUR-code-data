#
# method_seq_len.R, 11 Mar 15
#
# Data from:
# Empirical Evidence of Large-Scale Diversity in {API} Usage of Object-Oriented Software
# Diego Mendez and Benoit Baudry and Martin Monperrus
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

sum_meth_perc=function(df)
{
total_seqs=sum(df$uses)
df$use_perc=df$uses/total_seqs

t=ddply(df, .(num_methods), function(df) sum(df$use_perc))

return(t)
}


# method_seq,uses,num_methods,total_seqs
msc=read.csv(paste0(ESEUR_dir, "ecosystems/api-usage/method_seq_100_10_cnt.csv.xz"), as.is=TRUE)

t=ddply(msc, .(uniq_id), sum_meth_perc)

plot(t$num_methods, t$V1, log="xy", col=point_col,
	xlab="Number of method calls", ylab="Percentage of sequences\n")


lines(loess.smooth(t$num_methods, t$V1, span=0.3), col="green")


