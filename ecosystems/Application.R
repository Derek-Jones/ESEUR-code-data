#
# Application.R, 16 Oct 19
# Data from:
# Application Flows
# Steven J. Davis and Brenda Samaniego {de la Parra}
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG jobs Windows_jobs Linux_jobs C_jobs SQL_jobs Python_jobs


source("ESEUR_config.r")


pal_col=rainbow(5)


app=read.csv(paste0(ESEUR_dir, "ecosystems/Application.csv.xz"), as.is=TRUE)

app$Date=as.Date(paste0("15-", app$Date), format="%d-%b-%y")

plot(app$Date, app$C, type="n",
	yaxs="i",
	ylim=c(0, 2.2),
	xlab="Date", ylab="Slackness\n")

lines(app$Date, app$PYTHON, col=pal_col[5])
lines(app$Date, app$LINUX, col=pal_col[4])
lines(app$Date, app$C, col=pal_col[3])
lines(app$Date, app$WINDOWS, col=pal_col[2])
lines(app$Date, app$SQL, col=pal_col[1])

legend(x="topleft", legend=c("SQL", "Windows", "C", "Linux", "Python"), bty="n", fill=pal_col, cex=1.2)


