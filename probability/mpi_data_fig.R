#
# mpi_data_fig.R, 13 Dec 15
#
# Data from:
# Reproducible {MPI} Micro-Benchmarking Isn't As Easy As You Think
# Sascha Hunold and  Alexandra Carpen-Amarie and Jesper Larsson Tr{\"a}ff
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


plot_layout(1, 2)

# "";"test";"count";"size";"time";"nodes";"nnp";"rank";"exp"
fig1=read.csv(paste0(ESEUR_dir, "probability/mpi_data_fig1.csv.xz"), sep=";", as.is=TRUE)

fig1_Allreduce=subset(fig1, test == "Allreduce")
fig1_Allreduce=subset(fig1_Allreduce, time < 60)

fig1_Scan=subset(fig1, test == "Scan")

plot(density(fig1_Scan$time), main="",
	xlim=c(70, 120),
	xlab="Runtime (micro secs)", ylab="Density\n")

plot(density(fig1_Allreduce$time), main="",
	xlim=c(15, 55),
	xlab="Runtime (micro secs)", ylab="Density\n")


