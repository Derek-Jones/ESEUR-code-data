#
# argouml_complete.R, 17 Feb 18
#
# Data from:
# Studying the co-evolution of production and test code in open source and industrial developer test processes through repository mining
# Andy Zaidman, Bart Van Rompaey, Arievan Deursen, Serge Demeyer
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones

# Commit to version mapping for ArgoUML
# 408,0.9
# 1057,0.10
# 1748,0.12
# 3337,0.14
# 4515,0.16
# 6128,0.18
# 7416,0.20alpha

source("ESEUR_config.r")

library("changepoint")
library("plyr")
library("zoo")


pal_col=rainbow(3)


argo=read.csv(paste0(ESEUR_dir, "time-series/argouml_complete.csv.xz"), as.is=TRUE)
# results_jfreechart.csv

plot(argo$Production.code, type="l", log="y", col=pal_col[1],
	ylim=c(1, 1e5),
	xlab="Commits", ylab="Lines")
lines(argo$Test.code, col=pal_col[2])
lines(argo$Testcommands, col=pal_col[3])

plot(argo$Production.code/max(argo$Production.code), type="l", col=pal_col[1],
	ylab="Ratio")
lines(argo$Test.code/max(argo$Test.code), col=pal_col[2])
lines(argo$Testcommands/max(argo$Testcommands), col=pal_col[3])

legend(x="bottomright", legend=c("Production code", "Test code", "Test commands"), bty="n", fill=pal_col, cex=1.2)

Test_code=diff(argo$Test.code)
Prod_code=diff(argo$Production.code)

change_at=cpt.mean(Test_code, method="PELT")
plot(change_at)

Test_smooth=rollmean(Test_code, 10)
change_at=cpt.mean(Test_smooth, method="PELT")
plot(change_at)

Test_10=aaply(seq(1, length(Test_code), by=10), 1,
				function(X) sum(Test_code[X:(X+10-1)], na.rm=TRUE))
Prod_10=aaply(seq(1, length(Prod_code), by=10), 1,
				function(X) sum(Prod_code[X:(X+10-1)], na.rm=TRUE))

plot(diff(Test_10), log="y", col=pal_col[1],
	ylab="Lines")
points(diff(Prod_10), col=pal_col[2])

change_at=cpt.mean(Test_10, method="PELT")
plot(change_at)

acf(Test_10)
ccf(Prod_10, Test_10)

