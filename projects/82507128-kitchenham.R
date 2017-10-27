#
# 82507128-kitchenham.R,  1 Oct 17
# Data from:
# An empirical study of maintenance and development estimation accuracy
# Barbara Kitchenham and Shari Lawrence Pfleeger and Beth McColl and Suzanne Eagan
# Magne J{\o}rgensen
# Regression Models of Software Development Effort Estimation Accuracy and Bias
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("foreign")

pal_col=rainbow(2)


kitch=read.arff(paste0(ESEUR_dir, "projects/82507128-kitchenham.arff"))
jorg=read.csv(paste0(ESEUR_dir, "projects/Regression-models.csv.xz"), as.is=TRUE)

plot(kitch$First.estimate/100, kitch$Actual.effort/100, log="xy", col=pal_col[1],
	xlim=c(5, max(kitch$First.estimate))/100,
	ylim=c(5, max(kitch$Actual.effort))/100,
	xlab="Estimate (100 hours)", ylab="Actual\n")

points(jorg$Estimated.effort/100, jorg$Actual.effort/100, col=pal_col[2])

lines(c(5, 1e5)/100, c(5, 1e5)/100, col="grey")

legend(x="bottomright", legend=c("Kitchenham", "Jørgensen"), bty="n", fill=pal_col, cex=1.2)

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


