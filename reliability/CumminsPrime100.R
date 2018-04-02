#
# CumminsPrime100.R, 29 Mar 18
# Data from:
# The interpretation and use of numerically-quantified expressions
# Christopher Raymond Cummins
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)


cummins=read.csv(paste0(ESEUR_dir, "reliability/CumminsModifiedNumeral.csv.xz"), as.is=TRUE)
quest=read.csv(paste0(ESEUR_dir, "reliability/CumminsQuest.csv.xz"), as.is=TRUE)

ans=merge(cummins, quest)

ans$s_num=as.integer(substring(ans$Subject, 3))
ans$s_num=ans$s_num-min(ans$s_num)+1

ans_few=subset(ans, Quantifier == "Fewer")
ans_few$Estimate=ans_few$Prime-ans_few$Best

ans_more=subset(ans, Quantifier == "More")
ans_more$Estimate=ans_more$Prime+ans_more$Best

few_more=rbind(ans_few, ans_more)


few_range=function(df)
{
sapply(1:nrow(df), function(X)
			{
			lines(c(df$Prime[X]-df$High[X],
					df$Prime[X]-df$Low[X]), rep(X, 2),
					col=pal_col[1])
			points(df$Prime[X]-df$Best[X], X,
					col=pal_col[2], pch="o")
			})
}


more_range=function(df)
{
sapply(1:nrow(df), function(X)
			{
			lines(c(df$Prime[X]+df$Low[X],
					df$Prime[X]+df$High[X]), rep(X, 2),
					col=pal_col[3])
			points(df$Prime[X]+df$Best[X], X,
					col=pal_col[2], pch="o")
			})
}


plot(0, type="n",
	yaxs="i",
	xlim=c(0, 200), ylim=c(0, length(unique(cummins$Subject))),
	xlab="Between values", ylab="")

dummy=few_range(subset(ans_few, Prime == 100))
dummy=more_range(subset(ans_more, Prime == 100))

