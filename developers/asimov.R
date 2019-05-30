#
# asimov.R,  6 Mar 19
# Data from:
# The Learning Curve for Writing Books: {Evidence} From {Professor} {Asimov}
# Stellan Ohlsson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG learning writing-books


source("ESEUR_config.r")


pal_col=rainbow(2)


ia=read.csv(paste0(ESEUR_dir, "developers/asimov.csv.xz"), as.is=TRUE)

plot(ia$books, ia$months, log="xy", col=point_col,
	xlab="Elapsed time (months)", ylab="Books published\n")

iap_mod=glm(log(months) ~ log(books), data=ia)
pred=predict(iap_mod)
lines(ia$books, exp(pred), col=pal_col[1])

ia_mod=glm(months ~ books+I(books^0.5), data=ia)
summary(ia_mod)

pred=predict(ia_mod)
lines(ia$books, pred, col=pal_col[2])

