#
# pone.0103023.R,  2 Dec 17
# Data from:
# journal.pone.0103023
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("RcppCNPy")


bench=npyLoad(paste0(ESEUR_dir, "projects/data_derby.npy"), as.is=TRUE)

plot(table(bench[, 1]))
plot(table(bench[, 2]))
plot(table(bench[, 3]), log="x")
plot(table(bench[, 4]), log="x")

