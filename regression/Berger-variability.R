#
# Berger-variability.R, 13 Oct 17
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
library("VGAM")

pal_col=rainbow(2)


# model,feature,all,ctc
features=read.csv(paste0(ESEUR_dir, "regression/references_all2.csv.xz"), as.is=TRUE)

t=subset(features, model != "eCos-all" & model != "eCos-i386")
t=subset(t, all > 0)

features=ddply(t, .(model), function(df) {df$total=nrow(df); df})

plot(features$total, jitter(features$all), log="xy", col=point_col,
	ylim=c(1, 10),
	xlab="Total features", ylab="Dependencies per feature")

lines(loess.smooth(features$total, features$all, span=0.5), col=pal_col[1])

# boxplot(all ~ all*total, data=features, col="yellow", border=point_col,
# 	at=sort(unique(features$total)), pars=list(stablewex=3),
# 	ylim=c(1.0, 6),
# 	xlab="Model size (total features)", ylab="Flags required to enable feature")


feature_seq=seq(1, 6500, 100)

# Quadratic is slightly better fit
# feat_pmod=glm(all ~ total+I(total^2), data=features, family=poisson)
# 
# feat_ppred=predict(feat_pmod, newdata=data.frame(total=feature_seq),
# 				type="response", se.fit=FALSE)
#
# lines(feature_seq, feat_ppred, col="green")
#
# lower/higher 95% confidence intervals
# Need to change to type="link" in predict
# cl=exp(feat_pred$fit - 1.96*feat_pred$se.fit)
# ch=exp(feat_pred$fit + 1.96*feat_pred$se.fit)

# Count can never go below 1, use a zero truncated poisson, i.e., pospoisson
feat_mod=vglm(all ~ total+I(total^2), data=features, family=pospoisson)

feat_pred=predict(feat_mod, newdata=data.frame(total=feature_seq),
				type="response")

lines(feature_seq, feat_pred, col=pal_col[2])


# pal_col=rainbow(length(unique(features$model)))
# col_num=1
# plot(1, type="n", xlim=c(1, 10), ylim=c(1, 3000), log="y")
# 
# d_ply(features, .(model), function(df) {par(new=TRUE);plot(table(df$all), type="l",
# 				xlim=c(1, 10), ylim=c(1, 3000), log="y", col=pal_col[col_num]); col_num<<-col_num+1})


