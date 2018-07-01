#
# method_seq_len.R, 12 Jun 18
#
# Data from:
# Empirical Evidence of Large-Scale Diversity in {API} Usage of Object-Oriented Software
# Diego Mendez and Benoit Baudry and Martin Monperrus
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG Java method call-sequence source-usage


source("ESEUR_config.r")


pal_col=rainbow(2)


# method_seq,uses,num_methods,total_seqs
msc=read.csv(paste0(ESEUR_dir, "sourcecode/api-usage/method_seq_100_10_cnt.csv.xz"), as.is=TRUE)


# plot(msc$num_methods, msc$uses, log="xy", col=point_co,
# 	xlab="Sequence length (methods)", ylab="Uses")
# 
# loess_mod=loess(log(uses) ~ log(num_methods), span=0.2, data=msc)
# loess_pred=predict(loess_mod)
# lines(msc$num_methods, exp(loess_pred), col=loess_col)

u_cnt=count(msc$uses)
plot(u_cnt, log="xy", col=pal_col[1],
	xaxs="i",
	xlim=c(0.9, 5e3),
	xlab="Uses/Length", ylab="Sequences\n")

m_cnt=count(msc$num_methods)
points(m_cnt, col=pal_col[2])


legend(x="topright", legend=c("Uses of sequence", "Length of sequence"), bty="n", fill=pal_col, cex=1.2)


