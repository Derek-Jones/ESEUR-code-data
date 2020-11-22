#
# german-libre-office.R,  3 May 20
#
# Data from:
# https://people.gnome.org/~michael/data/2015-08-01-5.5-data.ods
# Michael Meeks
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG comment_German source-code_German


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

pal_col=rainbow(2)


lb=read.csv(paste0(ESEUR_dir, "ecosystems/german-libre-office.csv.xz"), as.is=TRUE)
lb$date=as.Date(lb$date, format="%d %b %Y")

plot(lb$date, lb$lines, log="y", col=pal_col[2],
	ylim=c(3000, max(lb$lines)),
	xlab="Release date", ylab="German comments\n\n")
axis(3, at=lb$date, labels=lb$version)
mtext("Version", padj=-1.8, cex=0.7)

gc_mod=glm(lines ~ as.numeric(date), data=lb, family=poisson)
pred=predict(gc_mod, type="response")
lines(lb$date, pred, col=pal_col[1])

# plot(lb$lines, log="y", col=point_col,
# 	xaxt="n",
# 	ylim=c(3000, max(lb$lines)),
# 	xlab="Version", ylab="German comments\n")
# axis(1, at=1:nrow(lb), labels=lb$version)


