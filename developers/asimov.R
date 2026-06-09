#
# asimov.R,  9 Jun 26
# Data from:
# The Learning Curve for Writing Books: {Evidence} From {Professor} {Asimov}
# Stellan Ohlsson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
#  6 Mar 19 Initial release
#
#  9 Jun 26 Updated
# Switched x/y variables in fitted models to agree with plot axis
# Changed x-axis from months to years
#
# TAG learning_writing-books


source("ESEUR_config.r")


pal_col=rainbow(2)


ia=read.csv(paste0(ESEUR_dir, "developers/asimov.csv.xz"), as.is=TRUE)
ia$years=ia$months/12

plot(ia$years, ia$books, log="xy", col=point_col,
	xlab="Elapsed time (years)", ylab="Books published\n")

iap_mod=glm(log(books) ~ log(years), data=ia)
summary(ia_mod)

pred=predict(iap_mod)
lines(ia$years, exp(pred), col=pal_col[1])

ia_mod=glm(books ~ years+I(years^2), data=ia)
summary(ia_mod)

pred=predict(ia_mod)
lines(ia$years, pred, col=pal_col[2])

