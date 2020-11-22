#
# feature-var.R, 28 Aug 20
#
# Data from:
# Variability Modeling in the Systems Software Domain
# Thorsten Berger and Steven She and Rafael Lotufo and Andrzej W\c{a}sowski and Krzysztof Czarnecki
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG feature_dependent system_variability


source("ESEUR_config.r")


library("plyr")

# model,feature,all,ctc
features=read.csv(paste0(ESEUR_dir, "regression/references_all2.csv.xz"), as.is=TRUE)

t=subset(features, (model != "eCos-all") & (model != "eCos-i386"))
features=subset(t, all > 0)

pal_col=rainbow(length(unique(features$model)))


feature_plot=function(df)
{
t=table(df$all)
lines(names(t), t, col=pal_col[col_num])
col_num<<-col_num+1
}


col_num=1
plot(1, type="n", log="y",
	xaxs="i",
        xlim=c(1, 11), ylim=c(1, 2000),
	xlab="Dependent features", ylab="Number of features\n")

d_ply(features, .(model), feature_plot)

legend(x="topright", legend=unique(features$model),
				inset=-c(0.02, 0.02), bty="n", fill=pal_col, cex=1.2)

