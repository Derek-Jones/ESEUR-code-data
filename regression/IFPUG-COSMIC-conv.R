#
# IFPUG-COSMIC-conv.R, 15 Sep 16
#
# Data from:
# Javad Mohammadian Amiri and Venkata Vinod Kumar Padmanabhuni
# A Comprehensive Evaluation of Conversion Approaches for Different Function Points
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


plot_a_fit=function(subj)
{
# w_mod=glm(FP ~ log(CFP), data=subj, family=poisson)
w_mod=glm(log(FP) ~ log(CFP), data=subj)
pred=predict(w_mod, newdata=data.frame(CFP=CFP_seq))
lines(CFP_seq, exp(pred), col=subj$col)
}

plot_fit=function(who)
{
d_ply(who, .(col), plot_a_fit)
}

plot_points=function(who)
{
points(who$CFP, who$FP, col=who$col)

#lines(loess.smooth(who$CFP, who$FP, span=0.5, family="gaussian"), col=line_col)
}



bench=read.csv(paste0(ESEUR_dir, "statistics/BTH2011Padmanabhuni.csv.xz"), as.is=TRUE)

# conv_mod=glm(FP ~ (who_FP+CFP)^2+kind+Dataset, data=bench)
# conv_mod=glm(FP ~ (who_FP+CFP)^2+kind, data=bench)
# summary(conv_mod)

no_students=subset(bench, Dataset != "Cuadtado_jj07" & Dataset != "Cuadtado_jj06")
no_Cuadtado=subset(no_students, Dataset != "Cuadtado_2007")

# table(no_students$who_CFP, no_students$who_FP)

conv_mod=glm(FP ~ (who_FP+CFP)^2+kind+Dataset, data=no_students)

conv_pmod=glm(FP ~ (who_FP+who_CFP+log(CFP))^2-who_FP:who_CFP+kind, family=poisson, data=no_students)
conv_mod=glm(log(FP) ~ (who_FP+log(CFP))^2+kind, data=no_students)
conv_cmod=glm(log(CFP) ~ (who_FP+log(FP))^2+kind, data=no_students)

summary(conv_pmod)
summary(conv_mod)
summary(conv_cmod)

CFP_seq=seq(20, 2000, by=5)

pal_col=rainbow(4)
D_names=unique(no_students$Dataset)
D_cols=rainbow(length(D_names))
no_students$col=mapvalues(no_students$Dataset, D_names, D_cols)

ind=subset(no_students, who_CFP == "ind")
aca=subset(no_students, who_CFP != "ind")

plot_layout(1, 2)

plot(1, type="n", log="xy",
	xlim=range(no_students$CFP), ylim=range(no_students$FP),
	xlab="COSMIC", ylab="FPA\n")

plot_points(ind)
plot_points(aca)

legend(x="topleft", legend=D_names, bty="n", fill=D_cols, cex=1.2)

# Remove what data that has a different slope to everything else
# aca=subset(no_Cuadtado, who_CFP != "ind")

plot(1, type="n", log="xy",
	xlim=range(no_students$CFP), ylim=range(no_students$FP),
	xlab="COSMIC", ylab="FPA\n")

plot_fit(ind)
plot_fit(aca)


# Remove what data that has a different slope to everything else
# aca=subset(no_Cuadtado, who_CFP != "ind")

library("simex")


no_students=subset(no_students, !is.na(kind))

no_students$l_CFP=log(no_students$CFP)
no_students$l_FP=log(no_students$FP)

conv_cmod=glm(l_CFP ~ (who_FP+l_FP)^2+kind, data=no_students)

conv_simex=simex(conv_cmod, SIMEXvariable="l_FP", measurement.error=no_students$l_FP/30, asymptotic=FALSE)

summary(conv_simex)



