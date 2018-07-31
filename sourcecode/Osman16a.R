#
# Osman16a.R, 29 Jul 18
# Data from:
# Tracking Null Checks in Open-Source Java Systems
# Haidar Osman Manuel Leuenberger Mircea Lungu Oscar Nierstrasz 
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG Java null if-statement


source("ESEUR_config.r")


pal_col=rainbow(2)


Osman=read.csv(paste0(ESEUR_dir, "sourcecode/Osman16a.csv.xz"), as.is=TRUE)

null_chk=subset(Osman, Null_Checks > 0)

plot(Osman$Conditionals, Osman$Null_Checks, log="xy", col=pal_col[2],
	xlab="Conditionals", ylab="Null checks\n")

x_bounds=exp(seq(0, 12, by=0.1))

null_mod=glm(log(Null_Checks) ~ log(Conditionals) ,data=null_chk)

pred=predict(null_mod, newdata=data.frame(Conditionals=x_bounds))
lines(x_bounds, exp(pred), col=pal_col[1])

# A slightly better fit
# null_mod=glm(log(Null_Checks) ~ log(Conditionals)+I(log(Conditionals)^0.5) ,data=null_chk)

# summary(null_mod)


