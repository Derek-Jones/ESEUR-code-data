#
# twitter-prog-lang.R, 14 Jul 20
# Data from:
# Which programming language should a company use? {A} {Twitter}-based analysis
# Giuseppe Destefanis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG programming-language_tweets


source("ESEUR_config.r")


library("lubridate")

pal_col=rainbow(6)

twit=read.csv(paste0(ESEUR_dir, "ecosystems/twitter-prog-lang.csv.xz"), as.is=TRUE)

start_date=ymd(20110101)+months(0:(nrow(twit)-1))

plot(start_date, twit$Java, type="l", log="y", col=pal_col[1],
	xaxs="i",
	ylim=c(75, 13000),
	xlab="Date", ylab="Tweets\n")

lines(start_date, twit$Php, col=pal_col[2])
lines(start_date, twit$C, col=pal_col[3])
lines(start_date, twit$Javascript, col=pal_col[4])
lines(start_date, twit$Python, col=pal_col[5])
lines(start_date, twit$Flash, col=pal_col[6])

legend(x="bottom", legend=c("Java", "PHP", "C/C++/C\U266F", "Javascript", "Python", "Flash"), bty="n", fill=pal_col, cex=1.2)

