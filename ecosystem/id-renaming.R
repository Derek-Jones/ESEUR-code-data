#
# id-renaming.R, 15 Jul 16
#
# Data from:
# An exploratory study of identifier renamings
# Laleh M. Eshkevari and Venera Arnaoudova and Massimiliano {Di Penta} and Rocco Oliveto and Yann-Ga{\"e}l Gu{\'e}h{\'e}neuc and Giuliano Antoniol
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


id_changes=read.csv(paste0(ESEUR_dir, "ecosystem/eclipse-id-dates.csv.xz"), as.is=TRUE)
version_date=read.csv(paste0(ESEUR_dir, "ecosystem/eclipse-ver-date.csv.xz"), as.is=TRUE)

id_changes$date=as.Date(paste0(id_changes$date, "-01"), format="%Y-%m-%d")
version_date$date=as.Date(version_date$date, format="%d %b %Y")

plot(id_changes, type="b", col=point_col,
	xlab="Date", ylab="Identifiers changed\n")

text(version_date$date, 200, version_date$version, srt=90, col="green")

