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

plot(1, 1, type="n", log="y",
	xlab="Modifications", ylab="Functions\n",
	xlim=xbounds, ylim=ybounds)
pal_col=rainbow(5)
dummy=sapply(1:5, plot_mods)

legend(x="topright",legend=c("1 author", "2 authors", "3 authors", "4 authors", "5 authors"),
				bty="n", fill=pal_col, cex=1.3)


ma_mod=glm(V1 ~ I(log(num_authors)^0.4)*num_mods,
		data=total_mods, family=poisson)

pred1=predict(ma_mod, data.frame(num_authors=1, num_mods=1:15),
		type="response")
points(pred1, col=pal_col[1])
pred3=predict(ma_mod, data.frame(num_authors=3, num_mods=1:15),
		type="response")
points(pred3, col=pal_col[3])
pred5=predict(ma_mod, data.frame(num_authors=5, num_mods=1:15),
		type="response")
points(pred5, col=pal_col[5])

# a1=subset(total_mods, num_authors == 3)
# ma_mod=nls(V1 ~ a*exp(c*num_mods),
# 		data=a1, trace=TRUE,
# 		start=list(a=3000, c=-0.3))



