#
# mpi_data_fig.R, 30 Aug 18
#
# Data from:
# Reproducible {MPI} Micro-Benchmarking Isn't As Easy As You Think
# Sascha Hunold and  Alexandra Carpen-Amarie and Jesper Larsson Tr{\"a}ff
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark MPI


source("ESEUR_config.r")


pal_col=rainbow(2)


# "";"test";"count";"size";"time";"nodes";"nnp";"rank";"exp"
fig1=read.csv(paste0(ESEUR_dir, "probability/mpi_data_fig1.csv.xz"), sep=";", as.is=TRUE)

fig1_Allreduce=subset(fig1, test == "Allreduce")
fig1_Allreduce=subset(fig1_Allreduce, time < 60)

fig1_Scan=subset(fig1, test == "Scan")

plot(density(fig1_Allreduce$time), col=pal_col[2], main="",
	xlim=c(15, 120),
	xlab="Runtime (micro secs)", ylab="Density\n")

lines(density(fig1_Scan$time), col=pal_col[1])


