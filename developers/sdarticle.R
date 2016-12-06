#
# sdarticle.R, 17 Nov 16
# Data from:
# Knowledge Organization and Skill Differences in Computer Programmers
# Katherine B. McKeithen and Judith S. Reitman and Henry H. Ruster and Stephen C. Hirtle
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

plot_layout(2, 1)
pal_col=rainbow(3)

plot_perf=function(df)
{
plot(df$trial, df$lines, type="n",
	ylim=range(lread$lines),
	xlab="Trial", ylab="Lines recalled")

d_ply(df, .(level), function(df) lines(df$trial, df$lines, col=df$col))

legend(x="topleft", legend=rev(col_order$level), bty="n", fill=rev(col_order$col), cex=1.2)
}

lread=read.csv(paste0(ESEUR_dir, "developers/sdarticle.csv.xz"), as.is=TRUE)
lread$col=pal_col[as.factor(lread$level)]

col_order=unique(data.frame(level=lread$level, col=lread$col))
col_order$col=as.character(col_order$col)

normal=subset(lread, organization == "normal")
scrambled=subset(lread, organization != "normal")

plot_perf(normal)
plot_perf(scrambled)

