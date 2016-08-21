#
# hujics-proc-pita.R, 15 Jul 16
#
# Data from:
#
# Workload Modeling for Computer Systems Performance Evaluation
# Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


plot_layout(2, 1)

# amd10.2  SF    root     __       0.05 secs Wed Dec 30 12:07
pita.2=read.fwf(paste0(ESEUR_dir, "data-check/hujics-proc-pita-1998.txt.xz"),
		width=c(-34, 4))
pita.2=subset(pita.2, V1 <= 1.0 & V1 >= 0.5,)
hist(pita.2$V1, breaks=100, col="red",
	main="",
	xlim=c(0.5, 1.0),
	xlab="", ylab="Number of processes\n")

text(0.75, 900, "2 significant digits", cex=1.3)

# amd10.2  SF    root     __       0.046875 secs Wed Dec 30 12:07
pita.6=read.fwf(paste0(ESEUR_dir, "data-check/hujics-proc-pita-1998-res.txt.xz"),
		width=c(-34, 8))

pita.6=subset(pita.6, V1 <= 1.0 & V1 >= 0.5)
hist(pita.6$V1, breaks=100, col="red",
	main="",
	xlim=c(0.5, 1.0),
	xlab="Runtime (seconds)", ylab="Number of processes")

text(0.75, 900, "6 significant digits", cex=1.3)

