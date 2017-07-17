#
# like-n-dis.R, 17 Apr 17
# Data from:
# The sources and Consequences of the Fluent Processing of numbers
# Dan King and Chris Janiszewski
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_wide()

plot_layout(3, 1, default_width=14)


lnd=read.csv(paste0(ESEUR_dir, "developers/like-n-dis.csv.xz"), as.is=TRUE)

plot(lnd$Number, lnd$Like, type="l",
	xlab="Like", ylab="Number")


spectrum(lnd$Like)
spectrum(lnd$Dislike)
spectrum(lnd$Neutral)

