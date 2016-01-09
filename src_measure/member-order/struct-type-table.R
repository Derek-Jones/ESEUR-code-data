#
# struct-type-table.R,  4 Jan 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("ascii")

# num members,type seq,occurrences,num grouped
# 4,1 1 2,239,185
type_comb=read.csv(paste0(ESEUR_dir, "src_measure/member-order/C-type-comb.csv.xz"),
			as.is=TRUE)

# Probability of a sequence matching type_seq occurring at random
# given all permutations of types denoted by type_seq
grouped_prob=function(type_seq)
{
num_type=as.integer(unlist(strsplit(type_seq, split=" ")))

return(factorial(length(num_type))/(factorial(sum(num_type))/
                                           prod(factorial(num_type))))
}

type_comb$rand_prob=sapply(1:nrow(type_comb),
                           function(X) grouped_prob(as.vector(type_comb$type.seq[X])))
type_comb$actual_prob=type_comb$num.grouped/type_comb$occurrences

# -1 because lower.tail=FALSE tests X > x (rather than X >= x)
type_comb$seq_prob=pbinom(type_comb$num.grouped-1, type_comb$occurrences,
                            type_comb$rand_prob, lower.tail=FALSE)

book_table=with(type_comb, data.frame(num.members, type.seq, occurrences,
                                      num.grouped, rand_prob, seq_prob))

names(book_table)=c("Total members", "Type sequence", "structs seen",
			"Grouped occurrences", "Random probability",
			"Occurrence probability")

print(ascii(head(book_table), include.rownames=FALSE,
                format=c("d", "s", "d", "d", "f", "e")))

