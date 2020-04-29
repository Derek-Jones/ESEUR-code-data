#
# peerj-1219.R,  5 Apr 20
#
# Data from:
# On the Impact of Sampling Frequency on Software Energy Measurements
# Rub{\'e}n Saborido and Venera Arnaoudova and Giovanni Beltrame and Foutse Khomh and Giuliano Antoniol
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))


bench=read.csv(paste0(ESEUR_dir, "benchmark/me.botanica-1.energy.csv.xz"),
			as.is=TRUE, sep="\t")

en_ts=ts(bench, start=0, frequency=5e5)

# spectrum(en_ts)

spec.ar(en_ts, n.freq=200, col=point_col,
	main="",
	xaxs="i",
	xlim=c(0, 60000),
	xlab="Frequency", ylab="Power density\n\n")


