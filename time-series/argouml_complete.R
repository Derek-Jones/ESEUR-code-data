#
# argouml_complete.R,  1 Feb 16
#
# Data from:
# Studying the co-evolution of production and test code in open source and industrial developer test processes through repository mining
# Andy Zaidman, Bart Van Rompaey, Arievan Deursen, Serge Demeyer
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("changepoint")
library("plyr")
library("zoo")


argo=read.csv(paste0(ESEUR_dir, "time-series/argouml_complete.csv.xz"), as.is=TRUE)
# results_jfreechart.csv

Test_code=diff(argo$Test.code)
change_at=cpt.mean(Test_code, method="PELT")
plot(change_at)

Test_smooth=rollmean(Test_code, 10)
change_at=cpt.mean(Test_smooth, method="PELT")
plot(change_at)

Test_7=aaply(seq(1, length(Test_code), by=7), 1,
				function(X) sum(Test_code[X:(X+6)]))
change_at=cpt.mean(Test_7, method="PELT")
plot(change_at)

acf(Test_7)

