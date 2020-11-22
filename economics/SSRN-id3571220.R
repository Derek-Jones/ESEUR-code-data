#
# SSRN-id3571220.R, 11 Aug 20
# Data from:
# Xueheng Li and Lucas Molleman and Dennie {van Dolder}
# Conditional punishment: descriptive social norms drive negative reciprocity
# Xueheng Li and Lucas Molleman and Dennie {van Dolder}
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human social_norm social_punishing free-riding_punishing

source("ESEUR_config.r")


library(plyr)


pal_col=rainbow(4)


punish_line=function(df)
{
lines(c(5, 10*(2:9), 95),
		c(mean(df$others1), mean(df$others2), mean(df$others3),
		mean(df$others4), mean(df$others5), mean(df$others6),
		mean(df$others7), mean(df$others8), mean(df$others9),
		mean(df$others10)),
		col=pal_col[df$punish_type], type="b")
}


# stageone: Cooperators, Defectors
# A subset of the uncleaned data available on papers data page.
ex=read.csv(paste0(ESEUR_dir, "economics/SSRN-id3571220.csv.xz"), as.is=TRUE)


# identify observations with all decisions data in the variable of 'complete'
finished=subset(ex, !(is.na(others0) | is.na(others1) | is.na(others2) |
		is.na(others3) | is.na(others4) | is.na(others5) |
		is.na(others6) | is.na(others7) | is.na(others8) |
		is.na(others9) | is.na(others10) |
		is.na(stageone)))

# punish_type: No punishment, Independent Punishment, Norm Enforcement,
#              Decreasing Punishment, Non-monotonic
finished$punish_type=NA

# classify participants into different punishment types based on
# their punishment strategies in Stage 2 of the game.
t=with(finished, which((others0 == 0) &
		(others1 == 0) & (others2 == 0) &
		(others3 == 0) & (others4 == 0) & (others5 == 0) &
		(others6 == 0) & (others7 == 0) & (others8 == 0) &
		(others9 == 0) & (others10 == 0)))

finished$punish_type[t]=0 # no punishment

t=with(finished, which(is.na(punish_type) &
				       (others1 == others0) &
		(others2 == others0) & (others3 == others0) &
		(others4 == others0) & (others5 == others0) &
		(others6 == others0) & (others7 == others0) &
		(others8 == others0) & (others9 == others0) &
		(others10 == others0)))

finished$punish_type[t]=1 # constant punishment

t=with(finished, which(is.na(punish_type) &
				       (others0 <= others1) &
		(others1 <= others2) & (others2 <= others3) &
		(others3 <= others4) & (others4 <= others5) &
		(others5 <= others6) & (others6 <= others7) &
		(others7 <= others8) & (others8 <= others9) &
		(others9 <= others10)))

finished$punish_type[t]=2 # monotonic increasing punishment

t=with(finished, which(is.na(punish_type) &
				       (others1 <= others0) &
		(others2 <= others1) & (others3 <= others2) &
		(others4 <= others3) & (others5 <= others4) &
		(others6 <= others5) & (others7 <= others6) &
		(others8 <= others7) & (others9 <= others8) &
		(others10 <= others9)))

finished$punish_type[t]=3 # monotonic decreasing punishment
finished$punish_type[is.na(finished$punish_type)]=4 # all other patterns of punishment


# experiment: CC Treatment, CP Treatment
ex1=subset(finished, experiment == 1)
ex2=subset(finished, experiment == 2)


no_pun1=table(ex1$punish_type)[1]
no_pun2=table(ex2$punish_type)[1]

# no_pun1/nrow(ex1)
# no_pun2/nrow(ex2)
# 
# table(ex1$punish_type)/(nrow(ex1)-no_pun1)
# table(ex2$punish_type)/(nrow(ex2)-no_pun2)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(0, 100), ylim=c(0, 6.5),
	xlab="Cooperator norms (percentage)", ylab="Punishment points")

legend(x="bottomleft", legend=c("Fixed punishment", "Increasing", "Decreasing", "Other patterns"), bty="n", fill=pal_col, cex=1.2)

d_ply(ex1, .(punish_type), punish_line)


