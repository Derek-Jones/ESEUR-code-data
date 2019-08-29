#
# 1710-05570a.R, 25 Jul 19
# Data from:
# How {PHP} Releases Are Adopted in the Wild?
# Jukka Ruohonen and Ville Lepp{\"a}nen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG PHP_version website evolution

source("ESEUR_config.r")


library("plyr")
library("semver")


pal_col=rainbow(2)

web_by_month=function(df)
{
# Count websites using given version, return ordered by version number
tab=count(df)
tab$v_ord=mapvalues(as.character(tab$x), u_ver, 1:length(u_ver))
ts=tab[order(tab$v_ord), ]
return(ts)
}


php=read.csv(paste0(ESEUR_dir, "ecosystems/1710-05570a.csv.xz"), as.is=TRUE)

# Order by version number
u_ver=unique(as.vector(as.matrix(php)))
p_ver=parse_version(u_ver)
u_ver=u_ver[order(p_ver)]

feb17=web_by_month(php$feb.2017)
plot(feb17$v_ord, feb17$freq, log="y", col=pal_col[1],
	xaxs="i", yaxs="i", xaxt="n",
	xlab="PHP version", ylab="Websites\n")

minor_start=c(4, 31, 35, 39, 57, 89, 136, 176, 208)
axis(1, at=minor_start, labels=u_ver[minor_start])

feb16=web_by_month(php$feb.2016)
points(feb16$v_ord, feb16$freq, col=pal_col[2])

legend(x="topleft", legend=c("Feb 2017", "Feb 2016"), bty="n", fill=pal_col, cex=1.2)

# t=table(ph14$dec.2016)
# q=t[order(parse_version(dimnames(t)[[1]]))]
# q

