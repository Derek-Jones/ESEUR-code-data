#
# li2018_app_number.R, 13 Jan 20
# Data from:
# MoonlightBox}: {Mining} {Android} {API} Histories for Uncovering Release-time Inconsistencies
# Li Li and Tegawend\'{e} F. Bissyand\'{e} and Jacques Klein
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


pal_col=rainbow(2)


li=read.csv(paste0(ESEUR_dir, "economics/li2018_app_number.csv.xz"), as.is=TRUE)

plot(li$Releases, li$Apps, log="xy", col=pal_col[2],
	xaxs="i",
	xlab="Releases", ylab="Apps")

li_mod=glm(log(Apps) ~ log(Releases), data=li, subset=(Releases<21))
summary(li_mod)

pred=predict(li_mod)
lines(li$Releases[1:20], exp(pred), col=pal_col[1])

