#
# id-renaming.R, 28 Aug 20
#
# Data from:
# An exploratory study of identifier renamings
# Laleh M. Eshkevari and Venera Arnaoudova and Massimiliano {Di Penta} and Rocco Oliveto and Yann-Ga{\"e}l Gu{\'e}h{\'e}neuc and Giuliano Antoniol
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG identifier_renaming

source("ESEUR_config.r")


pal_col=rainbow(2)


id_changes=read.csv(paste0(ESEUR_dir, "ecosystems/eclipse-id-dates.csv.xz"), as.is=TRUE)
version_date=read.csv(paste0(ESEUR_dir, "ecosystems/eclipse-ver-date.csv.xz"), as.is=TRUE)

# Assume end-of-month
id_changes$date=as.Date(paste0(id_changes$date, "-30"), format="%Y-%m-%d")
version_date$date=as.Date(version_date$date, format="%d %b %Y")

plot(id_changes, type="b", col=pal_col[1],
	xaxs="i", yaxs="i",
	ylim=c(0, 310),
	xlab="Date", ylab="Identifiers changed\n")

text(version_date$date, 200, version_date$version, srt=90, col=pal_col[2])

# Are id changes more likely to occur just before a release?
# library("lubridate")
# 
# id_changes$month=round_date(id_changes$date, "month")
# version_date$month=round_date(version_date$date, "month")
# 
# t=merge(id_changes, version_date, by="month", all=TRUE)
# 
