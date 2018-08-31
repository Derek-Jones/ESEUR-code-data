#
# DeBiasExptData.R, 17 Aug 18
# Data from:
# An Experimental Evaluation of a De-biasing Intervention for Professional Software Developers
# Martin Shepperd and Carolyn Mair and Magne Jørgensen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# ALSO developers/estimation-biases.R
# TAG experiment estimation country LOC anchoring


source("ESEUR_config.r")


pal_col=rainbow(4)


db=read.csv(paste0(ESEUR_dir, "projects/DeBiasExptData.csv.xz"), as.is=TRUE)

db_mod=glm(sqrt(EstProd) ~ Workshop*Anchor+Country, data=db)
summary(db_mod)

low=subset(db, Anchor == "low")
low_wY=subset(low, Workshop == "Y")
low_wN=subset(low, Workshop == "N")
high=subset(db, Anchor == "high")
high_wY=subset(high, Workshop == "Y")
high_wN=subset(high, Workshop == "N")

plot(0, type="n",
	xlim=c(0, 1), ylim=c(0, 100),
	xlab="Anchor", ylab="Estimate")

lines(c(0, 1), c(mean(low_wY$EstProd), mean(high_wY$EstProd)), col=pal_col[1])
lines(c(0, 1), c(mean(low_wN$EstProd), mean(high_wN$EstProd)), col=pal_col[2])

lines(c(0, 1), c(median(low_wY$EstProd), median(high_wY$EstProd)), col=pal_col[3])
lines(c(0, 1), c(median(low_wN$EstProd), median(high_wN$EstProd)), col=pal_col[4])

lines(c(0, 1), c(exp(mean(log(low_wY$EstProd))), mean(exp(log(high_wY$EstProd)))), col=pal_col[1])
lines(c(0, 1), c(exp(mean(log(low_wN$EstProd))), mean(exp(log(high_wN$EstProd)))), col=pal_col[2])

plot(sort(high_wN$EstProd), log="y", col=pal_col[1])
points(sort(low_wN$EstProd), col=pal_col[2])

points(sort(high_wY$EstProd), col=pal_col[3])
points(sort(low_wY$EstProd), col=pal_col[4])

