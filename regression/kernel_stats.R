#
# kernel_stats.R, 18 Jul 16
#
# Data from:
# github.com/gregkh/kernel-history
# Last updated Jun 2016
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# version,date released,days,commits,number files,number lines,lines added,lines removed,lines modified,number developers,number employers,changes per day,changes per hour,% growth files,% growth lines,lines added per day,lines removed per day,lines changed per day,lines added per hour
ks=read.csv(paste0(ESEUR_dir, "regression/kernel_stats.csv.xz"), as.is=TRUE)

# Only lines in previous release can be counted as modified
ks$percent_mod=100*c(NA, ks$lines.modified[-1]/ks$number.lines[-nrow(ks)])

#ks$percent_mod=ks$lines.modified/ks$number.lines

ks$date.released=as.Date(ks$date.released, format="%d/%m/%y")

#plot(ks$date.released, ks$number.developers)

brew_col=rainbow(3)

plot(ks$number.developers, ks$commits,
	xlab="Number of contributing developers",
	ylab="Number of commits\n")

k_mod=glm(commits ~ number.developers, data=ks)

k_pred=predict(k_mod, newdata=data.frame(number.developers=1:1600),
		type="response", se.fit=TRUE)

lines(k_pred$fit, col=brew_col[1])
lines(k_pred$fit+1.96*k_pred$se.fit, col=brew_col[2])
lines(k_pred$fit-1.96*k_pred$se.fit, col=brew_col[2])

