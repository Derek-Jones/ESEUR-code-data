#
# DoolingChristiaansen77.R, 12 Jul 18
# Data from:
# Episodic and Semantic Aspects of Memory for Prose
# D. James Dooling and Robert E. Christiaansen
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG experiment recall prose


source("ESEUR_config.r")


library("plyr")


plot_layout(2, 1)
pal_col=rainbow(4)


plot_foil=function(df)
{
lines(df$Thematic, df$False_Pos, type="b", col=df$col_str)
}


plot_period=function(period_str)
{
DCweek=subset(DC, Period == period_str)

plot(0, type="n",
        xlim=c(1, 4), ylim=range(DC$False_Pos),
        xaxt="n",
        xlab="", ylab="False positive (percent)\n")
axis(1, at=1:4, label=c("Neutral", "Low", "Medium", "High"))

text(3, 5, gsub("_", " ", period_str), cex=1.3)

plot_foil(subset(DCweek, Foils == "Before"))
plot_foil(subset(DCweek, Foils == "After"))
plot_foil(subset(DCweek, Foils == "Famous"))
plot_foil(subset(DCweek, Foils == "Fictitious"))

legend(x="topleft", legend=c("Before", "After", "Famous", "Fictitious"), bty="n", fill=pal_col, cex=1.2)
}


DC=read.csv(paste0(ESEUR_dir, "sourcecode/DoolingChristiaansen77.csv.xz"), as.is=TRUE)

Foil_str=unique(DC$Foils)
DC$col_str=mapvalues(DC$Foils, Foil_str, pal_col)

DCweek=subset(DC, Period == "1_week")

plot_period("2_days")
plot_period("1_week")

