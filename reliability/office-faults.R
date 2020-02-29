#
# office-faults.R, 29 Feb 20
# Data from:
# Showing How Security Has (And Hasn't) Improved, After Ten Years Of Trying
# Dan Kaminsky and Michael Eddington and Adam Cecchetti
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Office_faults fuzzing

source("ESEUR_config.r")


library("plyr")
library("SpadeR")

library("ggplot2")
library("iNEXT") # defines its own ChaoSpecies function


major_count=function(df)
{
W_df=subset(df, TargetName == "Word")

return(count(W_df$MajorHash))
}

pal_col=rainbow(5)

fuzz=read.csv(paste0(ESEUR_dir, "reliability/fuzzmark-office-pdf-11-Mar-2011.tsv.xz"), sep="\t", as.is=TRUE)

y2003=subset(fuzz, Year == 2003)
y2007=subset(fuzz, Year == 2007)
y2010=subset(fuzz, Year == 2010)


w03=major_count(y2003)
w07=major_count(y2007)
w10=major_count(y2010)

office_releases=list("y2003"=w03$freq, "2007"=w07$freq, "y2010"=w10$freq)

w03_pred=ChaoSpecies(w03$freq, datatype = "abundance")
w07_pred=ChaoSpecies(w07$freq, datatype = "abundance")
w10_pred=ChaoSpecies(w10$freq, datatype = "abundance")


off_pop=iNEXT(office_releases, endpoint=5e4)

t=ggiNEXT(off_pop, type=1)+
		scale_x_continuous(expand=c(0,0))+
		scale_y_continuous(expand=c(0,0))+
		theme(legend.position=c(0.15, 0.85),
			panel.background=element_rect(fill="white",
							color="grey50"))
plot(t)

