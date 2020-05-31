#
# SEC-TN12.R, 23 May 20
# Data from:
# Software Development Data White paper 2012-2013
# Kimio Akita and Shogo Itagaki and Yasushi Masawa and Makoto Nonaka and Takanori Hatani and Katsumi Hattori and Shuzo Morisaki and Yukihiro Yanagida and Tsutomu Takaya and Tsuneo Furuyama and Ogura Takashi
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_outsourced project_duration project_SLOC

source("ESEUR_config.r")


plot_layout(3, 1)


# person-hrs1.csv person-hrs2.csv
# out-cost.csv out-eff.csv
# sloc1.csv sloc2.csv
actual_mon=read.csv(paste0(ESEUR_dir, "projects/SEC-TN12/actual-mon.csv.xz"), as.is=TRUE)
sloc_2=read.csv(paste0(ESEUR_dir, "projects/SEC-TN12/sloc2.csv.xz"), as.is=TRUE)
out_eff=read.csv(paste0(ESEUR_dir, "projects/SEC-TN12/out-eff.csv.xz"), as.is=TRUE)

plot(actual_mon, type="b", col=point_col,
	xaxs="i", yaxs="i",
	xlim=c(0, 35), ylim=c(0, 570),
	xlab="Duration (months)", ylab="Projects\n")

plot(sloc_2, type="b", col=point_col,
	xaxs="i", yaxs="i",
	xlim=c(0, 201), ylim=c(0, 300),
	xlab="SLOC (thousand)", ylab="Projects\n")


plot(out_eff, type="b", col=point_col,
	xaxs="i", yaxs="i",
	ylim=c(0, 225),
	xlab="Outsourced effort (percentage)", ylab="Projects\n")


