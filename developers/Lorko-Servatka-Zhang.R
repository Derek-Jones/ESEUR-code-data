#
# Lorko-Servatka-Zhang.R,  4 Dec 19
# Data from:
# Anchoring in project duration estimation
# Matej Lorko and Maro\v{s} Serv\'{a}tka and Le Zhang
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human estimate

source("ESEUR_config.r")


pal_col=rainbow(3)

# 93 distinct subjects
lsz=read.csv(paste0(ESEUR_dir, "developers/Lorko-Servatka-Zhang.csv.xz"), as.is=TRUE)


aed=with(lsz,
		data.frame(Anchor,
				Estimate=c(Estimate1, Estimate2, Estimate3),
				Duration=c(Duration1, Duration2, Duration3),
				Iteration=rep(1:3, each=nrow(lsz))))

lsz_mod=glm(Estimate1 ~ Anchor, data=lsz)
summary(lsz_mod)

# Separate out the two anchors and non-anchor
a_none=subset(lsz, is.na(Anchor))
a_3=subset(lsz, Anchor== 3)
a_20=subset(lsz, Anchor== 20)

plot(a_3$Estimate3, a_3$Duration3, col=pal_col[1],
	xlab="Estimate", ylab="Actual\n")
points(a_none$Estimate3, a_none$Duration3, col=pal_col[2])
points(a_20$Estimate3, a_20$Duration3, col=pal_col[3])

# Fit regression models
est_range=seq(100, 1300, by=50)

a3_mod=glm(Duration3 ~ Estimate3, data=a_3)
# summary(a3_mod)

pred=predict(a3_mod, newdata=data.frame(Estimate3=est_range))
lines(est_range, pred, col=pal_col[1])

# This fit is not significant
anone_mod=glm(Duration3 ~ Estimate3, data=a_none)
# summary(anone_mod)

pred=predict(anone_mod, newdata=data.frame(Estimate3=est_range))
lines(est_range, pred, col=pal_col[2])

a20_mod=glm(Duration3 ~ Estimate3, data=a_20)
# summary(a20_mod)

pred=predict(a20_mod, newdata=data.frame(Estimate3=est_range))
lines(est_range, pred, col=pal_col[3])


aed_mod=glm(Estimate ~ Anchor*Iteration, data=aed)
summary(aed_mod)
# Coefficients:
#                  Estimate Std. Error t value Pr(>|t|)    
# (Intercept)       233.064     99.878   2.333   0.0206 *  
# Anchor             33.885      6.790   4.990 1.34e-06 ***
# Iteration          82.974     46.235   1.795   0.0743 .  
# Anchor:Iteration   -6.486      3.143  -2.063   0.0404 *  
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for gaussian family taken to be 93884.92)
# 
#     Null deviance: 24850745  on 197  degrees of freedom
# Residual deviance: 18213674  on 194  degrees of freedom
#   (81 observations deleted due to missingness)
# AIC: 2834.9

aed_mod=glm(Estimate ~ Anchor, data=aed)
summary(aed_mod)
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  399.012     37.971  10.508  < 2e-16 ***
# Anchor        20.914      2.581   8.101 5.71e-14 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# (Dispersion parameter for gaussian family taken to be 94983.38)
# 
#     Null deviance: 24850745  on 197  degrees of freedom
# Residual deviance: 18616743  on 196  degrees of freedom
#   (81 observations deleted due to missingness)
# AIC: 2835.3


