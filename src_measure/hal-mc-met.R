#
# hal-mc-met.R, 26 Dec 15
#
# Data from:
# The linux kernel as a case study in software evolution
# Ayelet Israeli and Dror G. Feitelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


plot_layout(3, 1)
brew_col=rainbow_hcl(3)


metrics=read.csv(paste0(ESEUR_dir, "src_measure/linux-2.6.9-met.csv.xz"), as.is=TRUE)

# plot(metrics$LOC, metrics$HD, log="xy")
plot(metrics$LOC, metrics$HV, log="xy", col=point_col,
	xlab="KLOC", ylab="Halstead volume\n")
plot(metrics$LOC, metrics$MCC, log="xy", col=point_col,
	xlab="KLOC", ylab="Cyclomatic complexity\n")

plot(metrics$MCC, metrics$HV, log="xy", col=point_col,
	xlab="Cyclomatic complexity", ylab="Halstead volume\n")

