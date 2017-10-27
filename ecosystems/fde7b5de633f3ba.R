#
# fde7b5de633f3ba.R, 16 Oct 17
# Data from:
# The Dependence of Operating System Size Upon Allocatable Resources
# Atilla Elci
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

OS=read.csv(paste0(ESEUR_dir, "ecosystems/fde7b5de633f3ba.csv.xz"), as.is=TRUE)

plot(OS$Resources, OS$Size, log="y", col=point_col,
	xlab="Unique devices", ylab="Memory (kbyte)\n")

# dev_mod=glm(Size ~ Resources, data=OS)
dev_mod=glm(log(Size) ~ Resources+I(Resources^2), data=OS)
# summary(dev_mod)

x_values=1:max(OS$Resources)

pred=predict(dev_mod, newdata=data.frame(Resources=x_values), type="response")
lines(x_values, exp(pred), col=pal_col[1])


# dev_mod=nls(log(Size) ~ a+b*Resources*exp(c*Resources), data=OS,
# 			start=list(a=100, b=0.3, c=-0.1), trace=FALSE)
# # summary(dev_mod)
# 
# pred=predict(dev_mod, newdata=data.frame(Resources=x_values))
# lines(x_values, exp(pred), col=pal_col[2])
# 
# 
