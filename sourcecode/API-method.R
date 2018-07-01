#
# API-method.R, 26 Dec 15
#
# Data from:
# Large-scale, AST-based API-usage of open source Java projects
# Ralf L{\"a}mmel and Ekaterina Pek and J{\"u}rgen Starek
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


api_method=read.csv(paste0(ESEUR_dir, "sourcecode/ZipfCombined.csv.xz"), as.is=TRUE)

api_method=na.omit(api_method)
api_method$l_Non_API=log(api_method$Non_API)
api_method$l_API=log(api_method$API)

plot(api_method$API, api_method$Non_API, log="xy", col=point_col,
	xlab="API calls", ylab="Non-API calls\n")

a_mod=glm(l_Non_API ~ l_API, data=api_method)

pred=predict(a_mod, type="response", se.fit=TRUE)

lines(api_method$API, exp(pred$fit), col="red")

