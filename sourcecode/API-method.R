#
# API-method.R, 29 Jul 18
#
# Data from:
# Large-scale, AST-based API-usage of open source Java projects
# Ralf L{\"a}mmel and Ekaterina Pek and J{\"u}rgen Starek
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG Java API method project calls


source("ESEUR_config.r")


pal_col=rainbow(2)


api_method=read.csv(paste0(ESEUR_dir, "sourcecode/APIMethodsToProjectSize.csv.xz"), as.is=TRUE)


plot(api_method$Size, api_method$API.Methods, log="xy", col=pal_col[2],
	xlab="Project size (method calls)", ylab="API methods (distinct)\n")

a_mod=glm(log(API.Methods) ~ log(Size), data=api_method)

summary(a_mod)

pred=predict(a_mod, type="response", se.fit=TRUE)

lines(api_method$Size, exp(pred$fit), col=pal_col[1])

