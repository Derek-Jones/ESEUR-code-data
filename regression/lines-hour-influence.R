#
# lines-hour-influence.R, 29 Sep 18
#
# Data from:
# On the effectiveness of early life cycle defect prediction with Bayesian Nets
# Norman Fenton and Martin Neil and William Marsh and Peter Hearty and {\L}ukasz Radli\'{n}ski and Paul Krause
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG effort LOC

source("ESEUR_config.r")

library(car)


loc_hour=read.csv(paste0(ESEUR_dir, "regression/10.1.1.157.6206.csv.xz"), as.is=TRUE)
loc_hour=subset(loc_hour, !is.na(KLoC))
loc_hour=loc_hour[order(loc_hour$Hours), ]
# influenceIndexPlot uses row.names and it is confusing because the original
# ones are maintained from before: loc_hour[order(loc_hour$KLoC), ]
row.names(loc_hour)=1:nrow(loc_hour)


# all_mod=glm(KLoC ~ Hours, data=loc_hour)
all_mod=glm(KLoC ~ I(Hours^0.5), data=loc_hour)

influenceIndexPlot(all_mod, main="", col=point_col,
		grid=FALSE, cex.axis=1.0, cex.lab=1.4)

