#
# fde7b5de633f3ba.R, 22 May 20
# Data from:
# The Dependence of Operating System Size Upon Allocatable Resources
# Atilla Elci
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG operating-system_memory operating-system_device device_memory


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

pal_col=rainbow(2)

OS=read.csv(paste0(ESEUR_dir, "ecosystems/fde7b5de633f3ba.csv.xz"), as.is=TRUE)

plot(OS$Resources, OS$Size, log="y", col=pal_col[2],
	xlab="Unique devices", ylab="Memory (kbyte)\n\n")

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
