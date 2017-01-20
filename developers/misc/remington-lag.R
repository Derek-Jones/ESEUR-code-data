#
# remington-lag.R, 16 Dec 16
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


# SubjectID Item TotalItems Lag Response Time CatLag Category CategoryCount
cli=read.csv(paste0(ESEUR_dir, "developers/remington-clilag.tsv"), as.is=TRUE, sep=" ")
gui=read.csv(paste0(ESEUR_dir, "developers/remington-guilag.tsv"), as.is=TRUE, sep=" ")

cli=subset(cli, Lag > 1)
gui=subset(gui, Lag > 1)

name_cli=subset(cli, Category == "Names")
name_gui=subset(gui, Category == "Names")

plot(name_cli$Lag, name_cli$Time, col=point_col,
	xlim=c(1, 40), ylim=c(800, 5000),
	xlab="Lag", ylab="Reponse time")

lines(loess.smooth(name_cli$Lag, name_cli$Time, span=0.15), col=loess_col)

plot(name_gui$Lag, name_gui$Time, col=point_col,
	xlim=c(1, 40), ylim=c(800, 5000),
	xlab="Lag", ylab="Reponse time")

lines(loess.smooth(name_gui$Lag, name_gui$Time, span=0.15), col=loess_col)

