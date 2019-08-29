#
# Debian-Sources.R,  4 Aug 19
# Data from:
# Statistics | Debian Sources
# The Debsources developers
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Debian_releases languages_sloc SLOC


source("ESEUR_config.r")


library("plyr")
library("reshape2")


plot_lang=function(df)
{
lines(df$sloc, col=df$col_str)
}


ds=read.csv(paste0(ESEUR_dir, "ecosystems/Debian-Sources.csv.xz"), as.is=TRUE)

ds=subset(ds, Language != "xml")

# t=data.frame(loc_max=apply(ds[, -1], 1, max), lang=ds$Language)
# t[order(t$loc_max), ]

lr=melt(ds, id.vars="Language", variable.name="Release", value.name="sloc")
lr$Release=as.character(lr$Release)

u_lang=unique(c("ansic", "cpp", "java", "python", "sh", ds$Language))
pal_col=rainbow(length(u_lang))
lr$col_str=mapvalues(lr$Language, u_lang, pal_col)

plot(1, type="n", log="y",
	xaxs="i",
	xlim=c(1, ncol(ds)-1), ylim=c(1e5, max(lr$sloc)),
	xlab="Release", ylab="SLOC\n")

d_ply(lr, .(Language), plot_lang)

legend(x="topleft", legend=c("C", "C++", "Java", "Python", "sh"), bty="n", fill=pal_col[1:5], cex=1.2)

