#
# UAMR0853.R, 28 Dec 14
#
# Data from:
# On the Experiments in Algorithm Dynamics
# Mario Magidin and Elisa Viso
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


UAMR0853=read.csv(paste0(ESEUR_dir, "sourcecode/misc/UAMR0853.csv.xz"), as.is=TRUE)


# Consistency check of data
t=with(UAMR0853, which((N-NC) - N.NC > 0.001))
UAMR0853[t,]
t=with(UAMR0853, which((N1-N1C) - N1.N2C > 0.001))
UAMR0853[t,]
t=with(UAMR0853, which(N != N1 + N2))
UAMR0853[t,]



