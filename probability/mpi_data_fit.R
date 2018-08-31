#
# mpi_data_fit.t, 30 Aug 18
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


# library("rebmix")
# 
# scan_dist=REBMIX(Dataset=list(data.frame(users=fig1_Allreduce$time)),
#  		Preprocessing=c("histogram", "parzen window"),
#  		cmax=2,
#  		Variables="continuous",
# 		pdf="lognormal",
#  		pdf="normal",
#  		K=10:50)
# 
# 
# coef(scan_dist)
#summary(slash_mod)
# 
# t=boot.REBMIX(scan_dist)
# 
# plot(scan_dist)


# mixtools use below

library("mixtools")

scan_dist=normalmixEM(fig1_Allreduce$time)

# summary(scan_dist)
# t=boot.se(scan_dist)

# The most likely behavior is not the default!
plot(scan_dist, whichplots=2, main2="", col2=pal_col,
	xlab2="Time (micro secs)", ylab2="Density\n")

