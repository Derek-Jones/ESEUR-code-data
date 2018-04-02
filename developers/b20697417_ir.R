#
# b20697417_ir.R, 11 Nov 17
# Data from:
# Pair programming productivity: Novice–novice vs. expert–expert
# Kim Man Lui and Keith C.C. Chan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")
library("plyr")

# plot_layout(2, 1)

pair_solo=read.csv(paste0(ESEUR_dir, "developers/b20697417_ir.csv.xz"), as.is=TRUE)
pair_solo$l_Round=log(pair_solo$Round)
pair_solo$e_C_score=exp(pair_solo$C_score)
pair_solo$AB_score=(pair_solo$A_score+pair_solo$B_score)/2
pair_solo$e_AB_score=exp(pair_solo$AB_score)
pair_solo$AB_score_perc=pair_solo$AB_score/50
# Raise to 4'th power to expand differences
pair_solo$AB_score_base=(1+pair_solo$AB_score-min(pair_solo$AB_score))^4

# plot(~ Solo_time + log(Round)+C_score^2, data=pair_solo)

pal_col=rainbow(max(pair_solo$Team))
pair_solo$col=pal_col[pair_solo$Team]

plot(0, type="n", xaxp=c(1, 4, 3),
	xlim=range(pair_solo$Round), ylim=range(pair_solo$Solo_time),
	xlab="Round", ylab="Time (minutes)\n")
d_ply(pair_solo, .(Team), function(df) lines(df$Round, df$Solo_time, col=df$col))
# snls_mod=nls(Solo_time ~ a*exp(c*(b*AB_score_base+Round)), data=pair_solo,
# 		start=list(a=900, b=0.001, c=-0.5))
# Power law is a very marginal better fit to the data
# (and its the brand name equation to use).
# snls_mod=nls(Solo_time ~ a*(b*AB_score_base+Round)^c, data=pair_solo,
# 		start=list(a=900, b=0.01, c=-0.5))
# pair_solo$s_pred=predict(snls_mod)
# d_ply(pair_solo, .(Team), function(df) points(df$Round, df$s_pred, col=df$col))
# 
# s_pred=predict(snls_mod)
# points(pair_solo$Round, s_pred, col=point_col)
# 
# plot(0, type="n", xaxp=c(1, 4, 3),
# 	xlim=range(pair_solo$Round), ylim=range(pair_solo$Pair_time),
# 	xlab="Round", ylab="Time (minutes)\n")
# d_ply(pair_solo, .(Team), function(df) lines(df$Round, df$Pair_time, col=df$col))
# pnls_mod=nls(Pair_time ~ a*(b*AB_score_base+Round)^c, data=pair_solo,
# 		start=list(a=900, b=0.01, c=-0.5))
# pnls_mod=nls(Pair_time ~ a*exp(b*AB_score_base+c*Round), data=pair_solo,
# 		start=list(a=900, b=0.1, c=-0.5))
# pair_solo$p_pred=predict(pnls_mod)
# d_ply(pair_solo, .(Team), function(df) points(df$Round, df$p_pred, col=df$col))
# d_ply(pair_solo, .(Team), function(df)
#  points(df$Round, predict(pnls_mod, newdata=data.frame(AB_score_base=df$AB_score_base, Round=df$Round)), col=df$col))

# points(pair_solo$Round, p_pred, col=point_col, lwd=0.4)

# 
# s_mod=glm(Solo_time ~ l_Round+I(C_score^2)+l_Round:e_C_score, data=pair_solo)
# summary(s_mod)
# 
# 
# plot(~ Pair_time + log(Round)+AB_score^2, data=pair_solo)
# 
# p_mod=glm(Pair_time ~ l_Round+I(AB_score^2)+l_Round:e_AB_score, data=pair_solo)
# summary(p_mod)
# p_pred=predict(p_mod)
# points(pair_solo$Round, p_pred)
# 
# 
# tnls_mod=nls(Pair_time ~ (a+b*AB_score_base^3)*Round^c, data=pair_solo,
# 		start=list(a=500, b=-1, c=-0.5))
# summary(tnls_mod)
# t_pred=predict(tnls_mod)
# points(pair_solo$Round, t_pred)
# 
# # There is a TODO in the nlmer code and until it is done WEDO
# power.f=deriv(~ (a+b*AB_score_base^3)*Round^c,
# 			namevec=c("a", "b", "c"),
# 			function.arg=c("AB_score_base", "Round", "a", "b", "c"))
# nlme_mod=nlmer(Pair_time ~ power.f(AB_score_base, Round, a, b, c) ~ (a+b+c) | Team,
# 		data=pair_solo,
# 		start=c(a=500, b=-1, c=-0.5))
# summary(nlme_mod)
# confint(nlme_mod)
# 
# pnls_mod=nls(Pair_time ~ a*(b*AB_score_base^3+Round)^c, data=pair_solo,
# 		start=list(a=900, b=0.001, c=-0.5), trace=TRUE)
# summary(pnls_mod)
# p_pred=predict(pnls_mod)
# points(pair_solo$Round, p_pred)
# 
# # Cannot get this to converge.  Solo_time does not converge either.
# power.f=deriv(~ a*(b*AB_score_base^3+Round)^c,
# 			namevec=c("a", "b", "c"),
# 			function.arg=c("AB_score_base", "Round", "a", "b", "c"))
# nlme_mod=nlmer(Pair_time ~ power.f(AB_score_base, Round, a, b, c) ~ (a+b) | Team,
# 		data=pair_solo,
# 		start=c(a=700, b=0.001, c=-0.3), verbose=2)
# summary(nlme_mod)
# confint(nlme_mod)
 
 
