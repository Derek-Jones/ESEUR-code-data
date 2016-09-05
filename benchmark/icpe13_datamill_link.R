#
# icpe13_datamill_link.R, 31 Aug 16
#
# Data from:
# DataMill: Rigorous Performance Evaluation Made Easy
# Augusto Born de Oliveira and Jean-Christophe Petkovich and Thomas Reidemeister and Sebastian Fischmeister
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lattice")
library("latticeExtra")


from_str=c("129.97.68.195", "129.97.68.196", "129.97.68.204",
		"129.97.68.206", "129.97.68.208", "129.97.68.213",
		"129.97.68.214", "129.97.69.162", "129.97.69.168",
		"129.97.69.182", "129.97.69.195", "129.97.69.198")

to_str=c("1.6GHz Nano X2", "1.5GHz Xeon", "600MHz ARM",
		"600MHz_ARM", "3.2GHz P4", "3.4GHz i7",
		"3.3GHz i5", "3.2GHz P4", "1.6GHz P4",
		"3.0GHz Pentium D", "1.6GHz_P4", "150MHz Celeron")

bench=read.csv(paste0(ESEUR_dir, "benchmark/icpe13_datamill_perl.csv.xz"), as.is=TRUE)

bench$hostname=mapvalues(bench$hostname, from_str, to_str)

p=bwplot(Base.Run.Time ~ link_order|address_randomization+hostname,
		data=bench, as.table=TRUE, col="yellow",
		panel=panel.violin,
		par.strip.text=list(cex=0.7),
		scales=list(x=list(relation="same"),
			 y=list(relation="free", tick.number=4),
			 rot=c(0, 90)),
		xlab="Link order", ylab="Run Time (secs)")
t=useOuterStrips(p)
plot(t,
	panel.width=list(4.0, "cm"))

