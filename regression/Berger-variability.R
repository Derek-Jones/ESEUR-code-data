#
# Berger-variability.R, 18 May 15
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

# model,feature,all,ctc
features=read.csv(paste0(ESEUR_dir, "regression/references_all2.csv.xz"), as.is=TRUE)

t=subset(features, model != "eCos-all" & model != "eCos-i386")
t=subset(t, all > 0)

features=ddply(t, .(model), function(df) {df$total=nrow(df); df})

boxplot(all ~ all*total, data=features, col="yellow", border=point_col,
	at=sort(unique(features$total)), pars=list(stablewex=3),
	ylim=c(1.0, 6),
	xlab="Model size (total features)", ylab="Flags required to enable feature")


# dep=ddply(features, .(model), function(df) {d=data.frame(model=df$model[1],
# 					mean=mean(df$all),
# 					features=df$total[1])
# 					d})

# dep_mod=glm(mean ~ features, data=dep)

# dep_pred=predict(dep_mod, type="response", se.fit=TRUE)

# lines(dep$features, dep_pred$fit, col="red")
# lines(dep$features, dep_pred$fit+1.96*dep_pred$se.fit, col="pink")
# lines(dep$features, dep_pred$fit-1.96*dep_pred$se.fit, col="pink")


feature_seq=seq(1, 6500, 100)

# Build a model from the averaged values (the paper did this
# using a gaussian! The confidence bounds are very different).
#dep_glm=glm(mean ~ features, data=dep, family=Gamma(link="identity"))
#dep_pred=predict(dep_glm, newdata=data.frame(features=feature_seq),
#				type="response", se.fit=TRUE)
#
#lines(feature_seq, dep_pred$fit, col="blue")
#
# lower/higher 95% confidence intervals
#cl=dep_pred$fit - 1.96*dep_pred$se.fit
#ch=dep_pred$fit + 1.96*dep_pred$se.fit
#
#lines(feature_seq, cl, col="green")
#lines(feature_seq, ch, col="green")

# The non-zero truncated model (which is not that different from other
# models, but we doing things correctly).
# feat_mod=glm(all ~ total, data=features, family=poisson)
# 
# feat_pred=predict(feat_mod, newdata=data.frame(total=feature_seq),
# 				type="response", se.fit=TRUE)

# lines(feature_seq, feat_pred$fit, col="blue")

# lower/higher 95% confidence intervals
# cl=feat_pred$fit - 1.96*feat_pred$se.fit
# ch=feat_pred$fit + 1.96*feat_pred$se.fit

# lines(feature_seq, cl, col="green")
# lines(feature_seq, ch, col="green")

# Count can never go below 1
feat_mod=vglm(all ~ total, data=features, family=pospoisson)

feat_pred=predict(feat_mod, newdata=data.frame(total=feature_seq),
				type="response", se.fit=FALSE)

# lines(feature_seq, feat_pred$fit, col="blue")
lines(feature_seq, feat_pred, col="blue")

# lower/higher 95% confidence intervals
# cl=feat_pred$fit - 1.96*feat_pred$se.fit
# ch=feat_pred$fit + 1.96*feat_pred$se.fit

# lines(feature_seq, cl, col="green")
# lines(feature_seq, ch, col="green")

# TODO confidence bounds...

pal_col=rainbow(length(unique(features$model)))
col_num=1
plot(1, type="n", xlim=c(1, 10), ylim=c(1, 3000), log="y")

d_ply(features, .(model), function(df) {par(new=TRUE);plot(table(df$all), type="l",
				xlim=c(1, 10), ylim=c(1, 3000), log="y", col=pal_col[col_num]); col_num<<-col_num+1})


