#
# hal-mc-met.R, 25 Feb 20
#
# Data from:
# The linux kernel as a case study in software evolution
# Ayelet Israeli and Dror G. Feitelson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C_metrics metric_Halstead metric_McCabe LOC_Halstead LOC_McCabe Complexity_McCabe 


source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(2)


metrics=read.csv(paste0(ESEUR_dir, "sourcecode/linux-2.6.9-met.csv.xz"), as.is=TRUE)

# It looks like noticeable noise at low values of LOC
# metrics=subset(metrics, LOC > 0)
metrics=subset(metrics, LOC > 10)

x_bounds=exp(seq(log(1), log(1e4), 0.1))

# plot(metrics$LOC, metrics$HD, log="xy")
plot(metrics$LOC, metrics$HV, log="xy", col=pal_col[2],
	ylim=c(60, 5e4), # values chosen to get 'pleasing' axis labels
	xlab="LOC", ylab="Halstead volume\n")

HV_mod=glm(log(HV) ~ log(LOC), data=metrics, subset=(LOC > 10))
pred=predict(HV_mod, newdata=data.frame(LOC=x_bounds))
lines(x_bounds, exp(pred), col=pal_col[1])
# summary(HV_mod)

plot(metrics$LOC, metrics$MCC, log="xy", col=pal_col[2],
	xlab="LOC", ylab="Cyclomatic complexity\n")

MCC_mod=glm(log(MCC) ~ log(LOC), data=metrics, subset=(LOC > 10))
# Non-linear model is a slightly better fit
# MCC_mod=nls(log(MCC) ~ a+b*log(LOC)^c, data=metrics, subset=(LOC > 10),
# 		start=c(a=1, b=0.7, c=1.1))
pred=predict(MCC_mod, newdata=data.frame(LOC=x_bounds))
lines(x_bounds, exp(pred), col=pal_col[1])

# summary(MCC_mod)

# plot(metrics$MCC, metrics$HV, log="xy", col=pal_col[2],
# 	xlab="Cyclomatic complexity", ylab="Halstead volume\n")

