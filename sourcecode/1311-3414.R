#
# 1311-3414.R,  7 Jun 20
# Data from:
# Mining Software Repair Models for Reasoning on the Search Space of Automated Program Fixing
# Matias Martinez and Martin Monperrus
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java source_evolution code_added code_deleted code_modified

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)


sum_freq=function(df)
{
return(sum(df$frequency))
}


# BFP - bug fix patch
# SC - source change, e.g., 1-SC one AST source change
# LC - ???

db=read.csv(paste0(ESEUR_dir, "sourcecode/1311-3414.csv.xz"), as.is=TRUE)

db_all=subset(db, (name == "all") & !is.na(entity))

all_CTsum=ddply(db_all, .(CT), sum_freq)
all_ENsum=ddply(db_all, .(entity), sum_freq)
all_sum=ddply(db_all, .(CT, entity), sum_freq)

ord_all=all_sum[order(all_sum$V1, decreasing=TRUE), ]

p_all=ord_all$V1/sum(ord_all$V1)*100

plot(p_all[1:100], log="y", col=pal_col[2],
	xaxs="i", yaxs="i",
	xlim=c(0, 100),
	xlab="Change rank", ylab="Change occurrence (probability)\n")


x1_30=1:30

f30_mod=glm(log(p_all[x1_30]) ~ x1_30)
summary(f30_mod)
pred=predict(f30_mod)

lines(x1_30, exp(pred), col=pal_col[1])

x31_59=31:59

f60_mod=glm(log(p_all[x31_59]) ~ x31_59)
summary(f60_mod)
pred=predict(f60_mod)

lines(x31_59, exp(pred), col=pal_col[1])

x60_79=60:79

f80_mod=glm(log(p_all[x60_79]) ~ x60_79)
summary(f80_mod)
pred=predict(f80_mod)

lines(x60_79, exp(pred), col=pal_col[1])

x80_99=80:99

f100_mod=glm(log(p_all[x80_99]) ~ x80_99)
summary(f100_mod)
pred=predict(f100_mod)

lines(x80_99, exp(pred), col=pal_col[1])

