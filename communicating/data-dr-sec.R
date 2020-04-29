#
# data.dr-sec.R, 10 Apr 20
# Data from:
# Data-Driven Security: Analysis, Visualization and Dashboards
# Jay Jacobs and Bob Rudis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG virus_reports UFO_reports


source("ESEUR_config.r")


par(mar=MAR_default+c(0.0, 0.7, 0, 0))

pal_col=rainbow(2)


ip_ufo=read.csv(paste0(ESEUR_dir, "communicating/county-data.csv.xz"), as.is=TRUE)

plot(ip_ufo$ufo2010, ip_ufo$ipaddr, log="xy", col=pal_col[2],
	xlab="UFO reports", ylab="Virus infections reported\n\n")

ufo_mod=glm(log(ipaddr) ~ log(ufo2010), data=ip_ufo,
					subset=(ipaddr > 0) & (ufo2010 > 0))
# summary(ufo_mod)

x_bounds=1:500
pred=predict(ufo_mod, newdata=data.frame(ufo2010=x_bounds))

lines(x_bounds, exp(pred), col=pal_col[1])

