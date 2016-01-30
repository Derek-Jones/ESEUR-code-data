#
# peerj-1219.R, 30 Jan 16
#
# Data from:
# On the Impact of Sampling Frequency on Software Energy Measurements
# Rub{\'e}n Saborido and Venera Arnaoudova and Giovanni Beltrame and Foutse Khomh and Giuliano Antoniol
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


bench=read.csv(paste0(ESEUR_dir, "benchmark/me.botanica-1.energy.csv.xz"),
			as.is=TRUE, sep="\t")

en_ts=ts(bench, start=0, frequency=5e5)

# spectrum(en_ts)

spec.ar(en_ts, n.freq=200,
	main="",
	xlim=c(0, 60000),
	xlab="Frequency", ylab="Power density\n")


