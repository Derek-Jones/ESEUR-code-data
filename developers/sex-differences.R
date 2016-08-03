#
# sex-differences.R, 15 Jul 16
#
# Data from:
# Sex Differences in Cognitive Abilities Test Scores: A UK National Picture
# Steve Strand and Ian J. Deary and Pauline Smith
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("reshape2")

plot_layout(2, 1)

b_g_IQ=read.csv(paste0(ESEUR_dir, "developers/sex-differences.csv.xz"), as.is=TRUE)

b_g=melt(b_g_IQ, id.vars=c("test", "gender"),
		variable.name="stanine", value.name="count")

b_g$stanine=as.integer(substring(b_g$stanine, 2, 2))

brew_col=rainbow(2)

calc_percent=function(df)
{
total=sum(df$count)
return(data.frame(b_percent=df$count[1]/total, g_percent=df$count[2]/total))
}


plot_percent=function(df)
{
plot(100*df$b_percent,
	type="b", col=brew_col[1],
	ylim=c(40, 60),
	xlab=df$test[1], ylab="Gender percentage within stanine\n")

lines(100*df$g_percent, col=brew_col[2], type="b")

legend(x="top",legend=c("Boy", "Girl"), bty="n", fill=brew_col, cex=1.3)
}

b_g_percent=ddply(b_g, .(test, stanine), calc_percent)
d_ply(b_g_percent, .(test), plot_percent)

