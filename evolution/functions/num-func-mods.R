#
# num-func-mods.R, 22 Dec 15
#
# Data from:
# Modification and developer metrics at the function level: Metrics for the study of the evolution of a software project
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


funcs=read.csv(paste0(ESEUR_dir, "evolution/functions/ev_funcmod.tsv.xz"), as.is=TRUE, sep="\t")
#revdate=read.csv(paste0(ESEUR_dir, "evolution/functions/ev_rev_date.csv.xz"), as.is=TRUE)

# Assign date-time for a given revid
#funcs$date=revdate$date_time[funcs$revid %in% revdate$revid]


count_mods=function(df)
{
# Only count additions and modifications
df=subset(df, typemod != "D")
num_mods=nrow(df)
num_authors=length(unique(df$author))

return(cbind(num_mods, num_authors))
}


mod_count=ddply(funcs, .(filename, func_name), count_mods)
total_mods=ddply(mod_count, .(num_mods, num_authors), nrow)


plot_mods=function(X)
{
t=subset(total_mods, num_authors == X)
lines(t$num_mods, t$V1, col=pal_col[X])
}


xbounds=c(1, 15)
ybounds=c(1, max(total_mods$V1))

plot(1, 1, log="y",
	xlab="Modifications", ylab="Functions\n",
	xlim=xbounds, ylim=ybounds)
pal_col=rainbow(5)
dummy=sapply(1:5, plot_mods)

legend(x="topright",legend=c("1 author", "2 authors", "3 authors", "4 authors", "5 authors"),
				bty="n", fill=pal_col, cex=1.3)


