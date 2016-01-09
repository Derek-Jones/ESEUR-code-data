#
# C-type-comb.R, 28 Aug 15
#
# Data from:
# Developer characterization of data structure fields decisions
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# num members,type seq,occurrences,num grouped
# 4,1 1 2,239,185
type_comb=read.csv(paste0(ESEUR_dir, "src_measure/member-order/C-type-comb.csv.xz"), as.is=TRUE)

# Probability of a sequence matching type_seq occurring at random
# given all permutations of types denoted by type_seq
grouped_prob=function(type_seq)
{
num_type=as.integer(unlist(strsplit(type_seq, split=" ")))

return(factorial(length(num_type))/
		(factorial(sum(num_type))/prod(factorial(num_type))))
}

type_comb$rand_percent=sapply(1:nrow(type_comb),
                           function(X) grouped_prob(type_comb$type.seq[X]))
type_comb$actual_percent=type_comb$num.grouped/type_comb$occurrences

type_comb$seq_prob=pbinom(type_comb$num.grouped, type_comb$occurrences,
                            type_comb$rand_percent, lower.tail=FALSE)

pal_col=rainbow(3)

comb_4_8=subset(type_comb, type_comb$num.members <= 8)

plot(comb_4_8$actual_percent*100, comb_4_8$rand_percent,
	col=pal_col[1],
	xlab="Measured percent", ylab="Random selection probability\n",
	xlim=c(0, 100), ylim=c(0.0, 0.5))

abline(0, 1/100, col=pal_col[3])

rand_y=seq(0, 0.5, by=0.005)
rand_conf=qbinom(0.999, 100, rand_y)

lines(rand_conf, rand_y, col=pal_col[2])


