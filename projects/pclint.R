#
# pclint.R,  6 Apr 18
# Data from:
# Software That Checks Software: The Impact of PC-lint
# James Gimpel
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG C tool sales documentation product


source("ESEUR_config.r")


pal_col=rainbow(4)


pclint=read.csv(paste0(ESEUR_dir, "projects/pclint.csv.xz"), as.is=TRUE)
pclint$Date=as.Date(pclint$Date, format="%d/%m/%Y")


# plot( ~ Lines+Messages+Manual.Kwords+I(Options^2), data=pclint)

plot(pclint$Date, pclint$Messages, col=pal_col[1],
	ylim=c(5, 1100),
	xlab="Date", ylab="")

points(pclint$Date, pclint$Manual.Kwords, col=pal_col[2])
points(pclint$Date, pclint$Options, col=pal_col[3])
points(pclint$Date, pclint$Lines/1e3, col=pal_col[4])

legend(x="topleft", legend=c("Messages", "Manual Kwords", "Options", "Source KLOC"), bty="n", fill=pal_col, cex=1.2)

# This model fits really well :-)
# pc_mod=glm(Lines ~ Messages+Manual.Kwords:I(Options^2), data=pclint)
# 
# summary(pc_mod)


