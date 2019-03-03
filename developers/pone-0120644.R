#
# pone-0120644.R, 19 Feb 19
# Data from:
# Jaap M. J. Murre and Joeri Dros
# Replication and Analysis of {Ebbinghaus'} Forgetting Curve
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human learning forgetting


source("ESEUR_config.r")


pal_col=rainbow(4)


learn_saving=function(saving, saving_se, col_str)
{
norm_save=saving/saving[1]

lines(eb$Interval.secs, norm_save, col=col_str)

arrows(eb$Interval.secs, norm_save,
                eb$Interval.secs, norm_save-saving_se, col=col_str,
		length=0.07, angle=90)
arrows(eb$Interval.secs, norm_save,
                eb$Interval.secs, norm_save+saving_se, col=col_str,
		length=0.07, angle=90)

}



eb=read.csv(paste0(ESEUR_dir, "developers/pone.0120644.csv.xz"), as.is=TRUE)

plot(0.1, type="n", log="x",
	yaxs="i",
	xlim=range(eb$Interval.secs), ylim=c(0, 1),
	xlab="Seconds", ylab="Normalised saving\n")


learn_saving(eb$Ebbinghaus, eb$Ebbinghaus.SE, pal_col[1])
learn_saving(eb$Mack, eb$Mack.SE, pal_col[2])
learn_saving(eb$Seitz, eb$Seitz.SE, pal_col[3])
learn_saving(eb$Drost, eb$Drost.SE, pal_col[4])

legend(x="topright", legend=c("Ebbinghaus", "Mack", "Seitz", "Drost"), bty="n", fill=pal_col, cex=1.2)


