#
# mpi_fit_summary.t, 19 Jul 15
#
# Data from:
# Reproducible {MPI} Micro-Benchmarking Isn't As Easy As You Think
# Sascha Hunold and  Alexandra Carpen-Amarie and Jesper Larsson Tr{\"a}ff
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")



# "";"test";"count";"size";"time";"nodes";"nnp";"rank";"exp"
fig1=read.csv(paste0(ESEUR_dir, "probability/mpi_data_fig1.csv.xz"), sep=";", as.is=TRUE)


fig1_Allreduce=subset(fig1, test == "Allreduce")
fig1_Allreduce=subset(fig1_Allreduce, time < 60)

fig1_Scan=subset(fig1, test == "Scan")


# mixtools use below

library("mixtools")

scan_dist=normalmixEM(fig1_Allreduce$time)

summary(scan_dist)
# t=boot.se(scan_dist)


# The most likely behavior is not the default!
# plot(scan_dist, whichplots=2)

