#
# McCullough_ATC11.R,  9 Oct 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")
library("R.matlab")


mdir="/usr1/data-rbook/T/CoreQ_2010-12-14_Rivoire_4_single/serial/"

mat_2_csv=function(X)
{
t=readMat.default(paste0(mdir, X))

q=t$samples
colnames(q)=t$columns

write.csv(q, file=paste0(ESEUR_dir, "regression/Mcsv/", X, ".csv.xz"), row.names=FALSE)
}


f=list.files(mdir, pattern="*.mat")

a_ply(f, .margins=1, mat_2_csv)

