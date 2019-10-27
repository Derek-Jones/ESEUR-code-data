#
# 82507128-kitchenham.R, 28 Sep 19
# Data from:
# An empirical study of maintenance and development estimation accuracy
# Barbara Kitchenham and Shari Lawrence Pfleeger and Beth McColl and Suzanne Eagan
# Magne J{\o}rgensen
# Regression Models of Software Development Effort Estimation Accuracy and Bias
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG effort_estimate effort_actual

source("ESEUR_config.r")


library("foreign")

pal_col=rainbow(3)


kitch=read.arff(paste0(ESEUR_dir, "projects/82507128-kitchenham.arff"))
jorg=read.csv(paste0(ESEUR_dir, "projects/Regression-models.csv.xz"), as.is=TRUE)

plot(kitch$First.estimate, kitch$Actual.effort, log="xy", col=pal_col[1],
	xlim=c(5, max(kitch$First.estimate)),
	ylim=c(5, max(kitch$Actual.effort)),
	xlab="Estimate (hours)", ylab="Actual (hours)\n")

points(jorg$Estimated.effort, jorg$Actual.effort, col=pal_col[3])

lines(c(5, 1e5), c(5, 1e5), col=pal_col[2])

legend(x="bottomright", legend=c("Kitchenham", "Jørgensen"), bty="n", fill=pal_col[-2], cex=1.2)

x_bounds=exp(seq(1, log(max(kitch$First.estimate)), by=0.5))

j_mod=glm(log(Actual.effort) ~ log(Estimated.effort), data=jorg)
summary(j_mod)
pred=predict(j_mod, newdata=data.frame(Estimated.effort=x_bounds))
lines(x_bounds, exp(pred), col=pal_col[3])

k_mod=glm(log(Actual.effort) ~ log(First.estimate), data=kitch)
summary(k_mod)
pred=predict(k_mod, newdata=data.frame(First.estimate=x_bounds))
lines(x_bounds, exp(pred), col=pal_col[1])

# 
# plot(kitch$First.estimate, kitch$Adjusted.function.points, log="xy", col=point_col,
# 	xlab="Estimate", ylab="Adjusted.function.points\n")
# 
# plot(kitch$Actual.effort, kitch$Adjusted.function.points, log="xy", col=point_col,
# 	xlab="Actual", ylab="Function points\n")
# 
# library("MASS")
# 
# e_mod=glm(Actual.effort ~ (First.estimate+Adjusted.function.points
# 				+Client.code+Project.type
# 				+First.estimate.method)^2
# 				, data=kitch)
# 
# t=stepAIC(e_mod)
# summary(t)
# 
# 
# e_mod=glm(formula = Actual.effort ~ First.estimate
#     + First.estimate:Adjusted.function.points
#     + First.estimate:Client.code
#     , data = kitch)
# 
# summary(e_mod)


