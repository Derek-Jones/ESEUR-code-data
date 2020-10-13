#
# hal-02543794.R, 13 Jul 20
# Data from:
# Software Provenance Tracking at the Scale of Public Source Code
# Guillaume Rousseau and Roberto {Di Cosmo} and Stefano Zacchiroli
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG commits_evolution files_number

source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))


pal_col=rainbow(3)

# month=0 is Jan 1970
hal=read.csv(paste0(ESEUR_dir, "introduction/hal-02543794.csv.xz"), as.is=TRUE)


hal$year=trunc(hal$mon/12)

plot(hal$month, hal$blobs, log="y", pch=18, col=pal_col[1],
	xaxs="i", xaxt="n",
	xlim=c(0, 12*60),
	xlab="Date", ylab="Occurences\n\n")
axis(1, at=12*10*(0:6), label=c("1970", "1980", "1990", "2000", "2010", "2020", "2030"))

points(hal$month, hal$commits, pch=18, col=pal_col[3])

legend(x="topleft", legend=c("Raw files", "Commits"), bty="n", fill=pal_col[c(1, 3)], cex=1.2)

x_range=(20*12):(47*12)

blob_mod=glm(log(blobs) ~ month, data=hal, subset=x_range)
# summary(blob_mod)

pred=predict(blob_mod)
lines(x_range, exp(pred), col=pal_col[2], lwd=1.3)

com_mod=glm(log(commits) ~ month, data=hal, subset=x_range)
# summary(com_mod)

pred=predict(com_mod)
lines(x_range, exp(pred), col=pal_col[2], lwd=1.3)

