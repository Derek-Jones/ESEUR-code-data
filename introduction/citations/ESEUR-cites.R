#
# ESEUR-cites.R, 26 Jun 20
# Data from:
# This books BibTex file
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG citations

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(2)


# NA entries, there is no data
# 'available' entries are cited works whose data is not used.
Ed=read.csv(paste0(ESEUR_dir, "introduction/citations/ESEUR-cites.csv.xz"), as.is=TRUE, sep=";")

# table(Ed$data)

Ed$year=as.numeric(Ed$year)

c_year=count(Ed$year)
d_year=count(subset(Ed, !is.na(data))$year)

plot(c_year, log="y", col=pal_col[2],
	xaxs="i",
	xlim=c(1920, 2021),
	xlab="Year", ylab="Work cited\n")

points(d_year, col=pal_col[1])

legend(x="topleft", legend=c("Research", "Data"), bty="n", fill=rev(pal_col), cex=1.2)


c_mod=glm(log(freq) ~ x, data=c_year, subset=(x > 1940) & (x < 2017))
# summary(c_mod)

years=1940:2017
pred=predict(c_mod, newdata=data.frame(x=years))

lines(years, exp(pred), col=pal_col[2])

d_mod=glm(log(freq) ~ x, data=d_year, subset=(x > 1940) & (x < 2017))
# summary(d_mod)

pred=predict(d_mod, newdata=data.frame(x=years))

lines(years, exp(pred), col=pal_col[1])

# lines(loess.smooth(d_year$x, d_year$freq, span=0.3), col=pal_col[3])
# legend(x="topleft", legend=c("Research", "Data"), bty="n", fill=rev(pal_col[-3]), cex=1.4)

