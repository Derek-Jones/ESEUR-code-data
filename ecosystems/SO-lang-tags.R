#
# SO-lang-tags.R, 26 Aug 19
# Data from:
# Stack Overflow Trends...
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Stack-Overflow_tag language_tag

source("ESEUR_config.r")


library("plyr")


lang_line=function(df)
{
lines(df$year, df$percent*(100/df$V1), col=df$col_str)
}


SO=read.csv(paste0(ESEUR_dir, "ecosystems/SO-lang-tags.csv.xz"), as.is=TRUE)

# Not all questions have an associated language tag.
# Get total percentage of all language tags, so we can normalise
l_total=ddply(SO, .(year), function(df) sum(df$percent))
# plot(l_total)

SO=merge(SO, l_total, all=TRUE)

min_perc=3

m2=subset(SO, percent > min_perc)
u_m2=unique(c("c#", "javascript", "java", "python", m2$lang))
pal_col=rainbow(length(u_m2))
m2$col_str=mapvalues(m2$lang, u_m2, pal_col)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=range(SO$year), ylim=c(min_perc*1.6, 30),
	xlab="Year", ylab="Tags (normalised percentage)")

d_ply(m2, .(lang), lang_line)

legend(x="top", legend=u_m2, bty="n", fill=pal_col, cex=1.2)

