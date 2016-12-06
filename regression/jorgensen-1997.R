#
# jorgensen-1997.R,  2 Nov 16
# Data from:
# Effort Estimation: Software Effort Estimation by Analogy and “Regression Toward the Mean”
# Magne Jørgensen, Ulf Indahl, Dag Sjøberg
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("simex")

pal_col=rainbow(3)

jorg=read.csv(paste0(ESEUR_dir, "regression/jorgensen-1997.csv.xz"), as.is=TRUE)
jorg$l_Size=log(jorg$Size)
jorg$l_Effort=log(jorg$Effort)

plot(jorg$Size, jorg$Effort, log="xy", col=point_col,
	xlab="Size (function points)", ylab="Effort (hours)\n")

# t=loess.smooth(log(jorg$Size), log(jorg$Effort), span=0.3)
# lines(exp(t$x), exp(t$y), col=loess_col)

# j_mod=glm(log(Effort) ~ l_Size+I(l_Size^2), data=jorg)
jes_mod=glm(l_Effort ~ l_Size, data=jorg)

xbounds=seq(20, 10000, by=20)

es_pred=predict(jes_mod, newdata=data.frame(l_Size=log(xbounds)), se.fit=TRUE)

lines(xbounds, exp(es_pred$fit), col=pal_col[1])
lines(xbounds, exp(es_pred$fit+1.96*es_pred$se.fit), col=pal_col[2])
lines(xbounds, exp(es_pred$fit-1.96*es_pred$se.fit), col=pal_col[2])


jse_mod=glm(l_Size ~ l_Effort, data=jorg)

se_pred=predict(jse_mod, newdata=data.frame(l_Effort=log(xbounds)))

# plot(jorg$Effort, jorg$Size, log="xy", col=point_col,
# 	xlab="Effort (hours)", ylab="Size (function points)\n")
# lines(xbounds, exp(se_pred), col=pal_col[3])

lines(exp(se_pred), xbounds, col=pal_col[3])

jes_sim_mod=simex(jes_mod, SIMEXvariable="l_Size", measurement.error=jorg$l_Size/10, asymptotic=FALSE)

summary(jes_sim_mod)

jse_sim_mod=simex(jse_mod, SIMEXvariable="l_Effort", measurement.error=jorg$l_Effort/20, asymptotic=FALSE)

summary(jse_sim_mod)



# 
# plot_layout(1, 2)
# 
# x = log(jorg$Size)
# y = log(jorg$Effort)
# 
# yx_line = glm(y ~ x) # Assume x values do not contain any error
# xy_line = glm(x ~ y) # Assume y values do not contain any error
# 
# plot(y ~ x, col=point_col,
# 	xlab="Size", ylab="Effort\n")
# yx_pred=predict(yx_line)
# lines(x, yx_pred, col=pal_col[1])
# 
# # Draw error lines to fitted line
# segments(x, y, x, fitted(yx_line), lty = 2, col =pal_col[1]) # vertical line
# 
# plot(y ~ x, col=point_col,
# 	xlab="Size", ylab="\n")
# 
# yx_pred=predict(yx_line)
# lines(x, yx_pred, col=pal_col[1])
# 
# # To plot the line fitted to x ~ y on the same axis as the y ~ x plot
# # we need to map the intercept and slope from y = a + bx to x = -a/b + y/b
# # xy_line.coef=xy_line$coefficients
# # abline(coef=c(-xy_line.coef[1]/xy_line.coef[2], 1/xy_line.coef[2]), col=pal_col[2])
# 
# # Or use predict
# xy_pred=predict(xy_line)
# lines(xy_pred, y, col=pal_col[2])
# 
# segments(x, y, fitted(xy_line), y, lty = 2, col =pal_col[2]) # horizontal line
# 
