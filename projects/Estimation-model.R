#
# Estimation-model.R, 24 May 20
# Data from:
# Effort Estimation with Story Points and COSMIC Function Points - An Industry Case Study
# Christophe Commeyne and Alain Abran and Rachida Djouab
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_story-point estimate_COSMIC-FP


source("ESEUR_config.r")


pal_col=rainbow(2)

em=read.csv(paste0(ESEUR_dir, "projects/Estimation-model.csv.xz"), as.is=TRUE)

em$Total_CFP=em$Entry_CFP+em$Exit_CFP+em$Read_CFP+em$Write_CFP

plot(em$Estimate, em$Total_CFP, col=pal_col[2], log="xy",
	xlab="Story point estimate (hours)", ylab="COSMIC FP\n")

cfp_mod=glm(log(Total_CFP) ~ log(Estimate), data=em)
summary(cfp_mod)

x_vals=seq(5, 200, by=5)
pred=predict(cfp_mod, newdata=data.frame(Estimate=x_vals), se.fit=TRUE)

lines(x_vals, exp(pred$fit), col=pal_col[1])
lines(x_vals, exp(pred$fit+1.98*pred$se.fit), col=pal_col[1], lty=2)
lines(x_vals, exp(pred$fit-1.98*pred$se.fit), col=pal_col[1], lty=2)

