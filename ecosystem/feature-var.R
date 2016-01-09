#
# feature-var.R,  2 Dec 15
#
# Data from:
# Variability Modeling in the Systems Software Domain
# Thorsten Berger and Steven She and Rafael Lotufo and Andrzej W\c{a}sowski and Krzysztof Czarnecki
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")

# model,feature,all,ctc
features=read.csv(paste0(ESEUR_dir, "regression/references_all2.csv.xz"), as.is=TRUE)

t=subset(features, model != "eCos-all" & model != "eCos-i386")
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
        xlim=c(1, 10), ylim=c(1, 3000),
	xlab="Dependent features", ylab="Number of features\n")

d_ply(features, .(model), feature_plot)

legend(x="topright", legend=unique(features$model),
				bty="n", fill=pal_col, cex=1.3)

