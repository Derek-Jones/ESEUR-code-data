#
# piantadosi2014zipfs.R, 28 Jul 18
# Data from:
# Zipf's word frequency law in natural language: a critical review and future directions
# Steven T. Piantadosi
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(3)


mean_val=function(df)
{
return(data.frame(Value=df$Value[1], Occurrences=mean(df$Occurrences)))
}


all_nums=read.csv(paste0(ESEUR_dir, "ecosystems/piantadosi2014zipfs.csv.xz"), as.is=TRUE)

after_1960=subset(all_nums, Year >= 1960)

eng=subset(after_1960, Language == "Eng")
ita=subset(after_1960, Language == "Ita")
rus=subset(after_1960, Language == "Rus")

e_mean=ddply(eng, .(Value), mean_val)
i_mean=ddply(ita, .(Value), mean_val)
r_mean=ddply(rus, .(Value), mean_val)

plot(e_mean$Value, e_mean$Occurrences, log="xy", col=pal_col[1],
	ylim=range(c(e_mean$Occurrences, i_mean$Occurrences)),
	xlab="Numeric word value", ylab="Occurrences\n")

points(r_mean$Value, r_mean$Occurrences, col=pal_col[2])
points(i_mean$Value, i_mean$Occurrences, col=pal_col[3])

legend(x="bottomleft", legend=c("English", "Russian", "Italian"), bty="n", fill=pal_col, cex=1.2)

