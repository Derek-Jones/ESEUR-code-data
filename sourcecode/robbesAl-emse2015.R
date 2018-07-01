#
# robbesAl-emse2015.R, 29 Jun 18
# Data from:
# Object-oriented software extensions in practice
# Romain Robbes and David R{\'o}thlisberger and {\'E}ric Tanter
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG Smalltalk class data-extension extension hierarchy source-code


source("ESEUR_config.r")


pal_col=rainbow(2)

visit=read.csv(paste0(ESEUR_dir, "sourcecode/robbesAl-emse2015.csv.xz"), as.is=TRUE)

# The two plots appearing as Fig 9 in the paper (except the paper
# figures have mislabelled the x/y axis (they are switched; cannot tell
# this without looking at their code).
#
# visit_oo=subset(visit, oo > 0)
# 
# plot(visit_oo$classes, visit_oo$oo, log="xy",
# 	xlim=c(1, 400), ylim=c(1, 100), 
# 	xlab="Hierarchy size", ylab="Data extensions\n")
# 
# oo_mod=glm(log(oo) ~ log(classes)+I(log(classes)^2), data=visit_oo)
# summary(oo_mod)
# 
# x_bounds=exp(seq(0, log(500), by=0.5))
# pred=predict(oo_mod, newdata=data.frame(classes=x_bounds))
# lines(x_bounds, exp(pred), col="red")
# 
# 
# ord_v=visit_oo[order(visit_oo$classes), ]
# loess_mod=loess(log(oo) ~ log(classes), data=ord_v, span=0.2)
# loess_pred=predict(loess_mod)
# lines(ord_v$classes, exp(loess_pred), col=loess_col)
# 
# 
# visit_adt=subset(visit, adt > 0)
# 
# plot(visit_adt$classes, visit_adt$adt, log="xy",
# 	xlim=c(1, 400), ylim=c(1, 100), 
# 	xlab="Hierarchy size", ylab="Operation extensions\n")
# 
# adt_mod=glm(log(adt) ~ log(classes)+I(log(classes)^2), data=visit_adt)
# summary(adt_mod)
# 
# pred=predict(adt_mod, newdata=data.frame(classes=x_bounds))
# lines(x_bounds, exp(pred), col="red")
# 
# 
# ord_v=visit_adt[order(visit_adt$classes), ]
# loess_mod=loess(log(adt) ~ log(classes), data=ord_v, span=0.2)
# loess_pred=predict(loess_mod)
# lines(ord_v$classes, exp(loess_pred), col=loess_col)

visit_oo_adt=subset(visit, (oo > 0) & (adt > 0))

plot(visit_oo_adt$adt, visit_oo_adt$oo, log="xy", col=pal_col[2],
	xlim=c(1, 100), ylim=c(1, 100), 
	xlab="Operation extensions", ylab="Data extensions\n")

oo_adt_mod=glm(log(oo) ~ I(log(adt)^2), data=visit_oo_adt)
summary(oo_adt_mod)

pred=predict(oo_adt_mod, newdata=data.frame(adt=x_bounds))
lines(x_bounds, exp(pred), col=pal_col[1])


# A loess fit hugs the quadratic :-)
# ord_v=visit_oo_adt[order(visit_oo_adt$adt), ]
# loess_mod=loess(log(oo) ~ log(adt), data=ord_v, span=0.3)
# loess_pred=predict(loess_mod)
# lines(ord_v$adt, exp(loess_pred), col=loess_col)
# 

# Power law fit goes down the middle, but is way off the loess line
# od_mod=nls(oo ~ a+b*adt^c, data=visit_oo_adt,
# 		start=list(a=2, b=1, c=2))
# summary(od_mod)
# 
# pred=predict(od_mod, newdata=data.frame(adt=x_bounds))
# lines(x_bounds, pred, col="green")
# 

