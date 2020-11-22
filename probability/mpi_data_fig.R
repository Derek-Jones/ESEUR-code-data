#
# mpi_data_fig.R,  5 Mar 20
#
# Data from:
# Reproducible {MPI} Micro-Benchmarking Isn't As Easy As You Think
# Sascha Hunold and  Alexandra Carpen-Amarie and Jesper Larsson Tr{\"a}ff
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG benchmark_MPI benchmark_reproducible


source("ESEUR_config.r")


pal_col=rainbow(2)


# "";"test";"count";"size";"time";"nodes";"nnp";"rank";"exp"
fig1=read.csv(paste0(ESEUR_dir, "probability/mpi_data_fig1.csv.xz"), sep=";", as.is=TRUE)

fig1_Allreduce=subset(fig1, test == "Allreduce")
fig1_Allreduce=subset(fig1_Allreduce, time < 60)

fig1_Scan=subset(fig1, test == "Scan")

plot(density(fig1_Allreduce$time), col=pal_col[2], main="",
	xaxs="i", yaxs="i",
	xlim=c(15, 120), ylim=c(0, 0.125),
	xlab="Runtime (micro secs)", ylab="Density\n")

lines(density(fig1_Scan$time), col=pal_col[1])


