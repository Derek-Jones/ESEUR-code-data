#
# basili1981.R, 23 May 20
# Data from:
# Victor R. Basili and John Beane
# Can the {Parr} Curve Help with Manpower Distribution and Resource Estimation Problems?
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_Parr-model estimate_Putnam-model


source("ESEUR_config.r")


pal_col=rainbow(3)


proj=read.csv(paste0(ESEUR_dir, "projects/basili1981.csv.xz"), as.is=TRUE)

p4=subset(proj, Project == 4)
x_weeks=1:max(p4$week)


plot(p4$week, p4$man_hours, col=point_col,
	xaxs="i", yaxs="i",
	xlim=c(0, 60), ylim=c(0, 400),
	xlab="Weeks", ylab="Effort (man-hours)\n")

ray_mod=nls(man_hours ~ K*a*week*exp(-a*week*week), data=p4,
			# trace=TRUE,
			start=list(K=10000, a=0.003))
pred=predict(ray_mod, newdata=data.frame(week=x_weeks))

lines(x_weeks, pred, col=pal_col[1])

parr_mod=nls(man_hours ~ K*a*exp(-b*week)/(1+a*exp(-b*week))^2, data=p4,
			# trace=TRUE,
			start=list(K=100, a=1, b=0.03))
pred=predict(parr_mod, newdata=data.frame(week=x_weeks))

lines(x_weeks, pred, col=pal_col[2])

quad_mod=glm(man_hours ~ week+I(week^2), data=p4)
pred=predict(quad_mod, newdata=data.frame(week=x_weeks))

lines(x_weeks, pred, col=pal_col[3])


legend(x="bottom", legend=c("Norden-Putnam", "Parr", "Quadratic"), bty="n", fill=pal_col, cex=1.2)


